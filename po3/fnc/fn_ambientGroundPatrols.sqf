// Written by EightySix
if(!mpsfSRV || !isNil "po3_VAR_ambientGroundPatrols_active") exitWith{};
po3_VAR_ambientGroundPatrols_active = true;

_wparray = [];
{
	_pos = (_x select 0) call mpsf_fnc_getPos;
	if !(surfaceIsWater _pos) then{
		_wparray set [count _wparray,_pos];
	};
} foreach (po3_pos_allowed select 5);

_wparray = _wparray call mpsf_fnc_arrayShuffle;

_script = _wparray spawn {
	private["_class","_vehicle","_group","_airframe","_position","_wp"];
	_Tunits = [];
	_wparray = _this;

	While { true } do{
		_rndpos = _wparray call mpsf_fnc_getArrayRandom;
		_class = "SQUAD";
		_grp = if(random 1 > 0.5 ) then {
			[ _rndpos, (po3_side_3 select 0),format["EN_PatrolGroup%1",round random 2] ] call mpsf_fnc_createGroup;
		}else{
			_class = ([3,4,5] call po3_fnc_getVehicleTypes) call mpsf_fnc_getArrayRandom;
			([ _rndpos, _class,0,0, (po3_side_3 select 0)] call mpsf_fnc_createVehicle) select 0;
		};

		_Side1Count = playersNumber (po3_side_1 select 0);
		_Side2Count = playersNumber (po3_side_2 select 0);
		_factor = 3*(1 max round(log(_Side1Count+_Side2Count)));
		_refCount = count(units _grp) * _factor;
		_Tunits = _Tunits + (units _grp);

		{
			_position = _x call mpsf_fnc_getPos;
			_wp = _grp addWaypoint [_position,150];
			_wp setWaypointCompletionRadius 200;

			if(_forEachIndex == 0) then {
				_wp setWaypointSpeed "NORMAL";
				_wp setWaypointBehaviour "SAFE";
				_wp setWaypointFormation "STAG COLUMN";
			};

			if(mpsf_debug) then {
				_marker = createMarkerlocal [format["mpsf_temp_ap%1",_x],_x];
				_marker setMarkerTypelocal "mil_dot";
				_marker setMarkersizelocal [0.3,0.3];
				_marker setMarkerTextlocal ("GND" + str _forEachIndex);
			};
		} foreach _this;

		_wp = _grp addWaypoint [waypointPosition [_grp,0],100];
		_wp setWaypointType "CYCLE";

		["PO3",format["po3_fnc_ambientGroundPatrols: Created %1",[_grp,_class]],true ] call mpsf_fnc_log;

		while { {alive _x} count _Tunits  >= _refCount } do { sleep 30 };
	};
};