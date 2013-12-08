mpsf_VAR_w2s_array = [];
mpsf_VAR_w2s_data = [];

if(mpsf_param_hud_worldtoscreen > 1) exitWith {};

mpsf_fnc_getZoom = {[0.5,0.5] distance (worldToScreen (positionCameraToWorld [1,0.484,1])) };

[] spawn mpsf_fnc_hud_assignedTeamWatcher;

[] spawn {
	private["_temp1array","_temp2array"];

	waitUntil{
		sleep 1;
		waitUntil{alive player};

		_temp1array = mpsf_VAR_w2s_array;
		_temp2array = mpsf_VAR_w2s_data;

		{
			if( alive _x && !(_x IN _temp1array) && _x != player ) then { _temp1array set [count _temp1array, _x ] };
			if( !(alive _x) && _x IN _temp1array) then { _temp1array = _temp1array - [_x] };
		}forEach (playableUnits + switchableUnits + (units group player));

		{
			private["_pos","_pos2D","_distance","_divsor","_alpha","_display","_colour","_text"];

			_alpha = 1;
			_colour = [1,0.2,0.2,0.8];
			_pos = visiblePosition _x;
			_distance = round(player distance _pos);
			if !(_x getVariable ["mpsf_injury_inAgony",false]) then {
				_pos2D = worldtoscreen _pos;
				_divsor = switch (true) do {
					case ( vehicle player isKindof "Air" ) : { 30 };
					case ( vehicle player isKindof "LandVehicle" ) : { 20 };
					default { 10 };
				};
				_alpha = (0 max (1 - log(_distance/_divsor) ) ) min 1;

				_colour = if(_x IN (units group player) ) then { _x call mpsf_fnc_hud_getTeamColour }else{ [0.6784,0.7490,0.5137,1] };
				_colour set [3,_alpha];
			};

			_display = false;
			if( [player] call mpsf_fnc_hasARgear || !(mpsf_param_hud_requireGlasses) ) then {
				if( _alpha > 0 ) then{
					if !( vehicle _x != _x && driver (vehicle _x ) != _x ) then { _display = true };
				};
			};

			_text = if( !(format["%1", name _x] == "") and !(format["%1", name _x] == "Error: No unit") ) then {
				if( [] call mpsf_fnc_getZoom > 2 || _distance < 8 ) then {
					format ["%1 %2 - %3m", toupper localize format ["STR_SHORT_%1",rank _x],toupper (name _x),_distance]
				}else{ "" };
			}else{"Unit KIA"};

			_temp2array set [
				_forEachIndex,
				[
					_display,
					_x call mpsf_fnc_hud_getUnitIcon,
					_colour,
					([player, _x] call BIS_fnc_dirTo) - direction _x,
					_text
				]
			];
		}forEach _temp1array;

		mpsf_VAR_w2s_data = _temp2array;
		mpsf_VAR_w2s_array = _temp1array;

		false
	};
};

addMissionEventHandler ["Draw3D", {
	private["_data","_pos"];
	if(mpsf_hud_worldtoscreen_display) then {
		for "_i" from 0 to ((count mpsf_VAR_w2s_array) - 1) do {
			if( count mpsf_VAR_w2s_data > 0 ) then {
				_data = (mpsf_VAR_w2s_data select _i);
				if(_data select 0) then {
					_pos = visiblePosition (mpsf_VAR_w2s_array select _i);
					_pos set [2,(_pos select 2) + 2.2];
					[
						_data select 1,
						_data select 2,
						_pos,
						0.6,0.6,
						_data select 3,
						_data select 4
					] call mpsf_fnc_drawIcon3D;
				};
			};
		};
	};

	{
		if(count _x == 2) then {
			_point1 = (_x select 0) call mpsf_fnc_getPos;
			_point2 = (_x select 1) call mpsf_fnc_getPos;
			drawLine3D [_point1, _point2, [0,0,0,1] ];
			drawLine3D [_point1, _point2, [0,0,0,1] ];
			drawLine3D [_point1, _point2, [0,0,0,1] ];
		};
	}forEach mpsf_logistics_liftCables;
}];