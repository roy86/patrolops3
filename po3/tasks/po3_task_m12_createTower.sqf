private["_location","_position","_locaname"];
// =========================================================================================================
//	Define Random Location
// =========================================================================================================

	_location = ["hill","POI"] call po3_fnc_getNewPos;

	PO3_TASK__DIF	= po3_param_missionskill;
	PO3_TASK__POS	= [ [(_location select 0),0,0,false],350,4,5,0.5] call mpsf_fnc_getflatarea;
	PO3_TASK__IDD	= format["%1%2:%3",round(PO3_TASK__POS select 0),round(PO3_TASK__POS select 1),(round random 99)];

	_position = PO3_TASK__POS;
	_locaname = _location select 1;
	_locRadis = _location select 2;

// =========================================================================================================
//	Create Target(s)
// =========================================================================================================

	{ _x setDamage 1 }forEach (nearestObjects [_position,po3_target_tower_types,350]);

	_returnPoint = format["return_point_%1",(po3_side_1 select 0)] call mpsf_fnc_getPos;
	_container = "Land_Cargo20_military_green_F" createVehicle _returnPoint;
	[_container] call mpsf_fnc_setAsLoadable;
	_container setVariable ["mpsf_deployable_tower",true,true];
	_container setVariable ["mpsf_packedClass",(po3_target_tower_types call mpsf_fnc_getArrayRandom),true];
	_container setVariable ["mpsf_isPackable",true,true];

// =========================================================================================================
//	Create Hostiles
// =========================================================================================================
	PO3_TOTAL_UNITS = [];
	PO3_TOTAL_VEHICLES = [];

	po3_FLAG_task08_fail = false;
	po3_FLAG_task08_towerSetup = false;

	// Tower Detector
	_towerDetector = [] spawn {
		private["_timer","_spawnAmbush"];

		_spawnAmbush = {
			private["_position","_b","_ingress","_grp"];

			_position = _this select 0;
			_b = _this select 1;
			_ingress = [_position ,[550,750],random 360,false] call mpsf_fnc_getPos;

			_vehClass = [];
			if(_b <= 3) then { _vehClass set [count _vehClass,4]; };
			if(_b >= 3 && _b < 9)  then { _vehClass set [count _vehClass,5]; };
			if(_b >= 6) then { _vehClass set [count _vehClass,3]; };

			for "_i" from 0 to _b do {
				_grp = nil;
				_grp = [ _ingress, (po3_side_3 select 0), format["EN_GroupForce_%1",round random 4], 50 ] call mpsf_fnc_createGroup;
				if !(isNil "_grp") then {
					[ _position, _grp ] spawn mpsf_fnc_groupAttackPos;
					PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _grp);
					sleep 1;
				};
			};

			for "_i" from 0 to (floor(_b/2)) do {
				if(random 1 > 0.5 || _b > 6) then {
					_class = _vehClass call po3_fnc_getVehicleTypes;
					if(count _class > 0) then {
						_ingress = [_position ,[500,600],random 360,false] call mpsf_fnc_getPos;
						_veh = ([ _ingress,_class call mpsf_fnc_getArrayRandom,random 360,100,(po3_side_3 select 0)] call mpsf_fnc_createVehicle) select 0;
						if !(isNil "_veh") then {
							[ _position, _veh ] spawn mpsf_fnc_groupAttackPos;
							PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _veh);
							PO3_TOTAL_VEHICLES set [ count PO3_TOTAL_VEHICLES, vehicle (leader _veh) ];
						};
					};
				};
			};
		};

		_fired1 = false;
		_fired2 = false;
		_fired3 = false;

		waitUntil { sleep 1; count nearestObjects[ PO3_TASK__POS, po3_target_tower_types, 80] > 0 || format["TASK%1",PO3_TASK__IDD] call mpsf_fnc_isTaskcompleted };

		if( count nearestObjects[ PO3_TASK__POS, po3_target_tower_types, 80] > 0 ) then {
			_Ttime = round(600 * PO3_TASK__DIF) max 300;
			_timer = _Ttime;
			[ (po3_side_1 select 0), "SIDE", format[localize "STR_PO3_M12_MSG_0",round(_timer/60)] ] call mpsf_fnc_sendChat;
			waitUntil { sleep 1;

				_b = (4*(playersNumber(po3_side_1 select 0)/40)*PO3_TASK__DIF) max 1;

				_timer = _timer - 1;
				if( _timer < (_Ttime*0.8) && !_fired1 ) then {
					_fired1 = true;
					[PO3_TASK__POS,_b*1] spawn _spawnAmbush;
					[(po3_side_1 select 0), "SIDE", localize "STR_PO3_M12_MSG_3"] call mpsf_fnc_sendChat;
				};

				if( _timer < (_Ttime*0.6) && !_fired2 ) then {
					_fired2 = true;
					[PO3_TASK__POS,_b*2] spawn _spawnAmbush;
					[(po3_side_1 select 0), "SIDE", localize "STR_PO3_M12_MSG_4"] call mpsf_fnc_sendChat;
				};

				if( _timer < (_Ttime*0.3) && !_fired3 ) then {
					_fired3 = true;
					[PO3_TASK__POS,_b*3] spawn _spawnAmbush;
					[(po3_side_1 select 0), "SIDE", localize "STR_PO3_M12_MSG_6"] call mpsf_fnc_sendChat;
				};

				if( _timer < (_Ttime*0.6) && (random 1 > 0.9) ) then {
					[(po3_side_1 select 0), "SIDE", localize "STR_PO3_M12_MSG_5"] call mpsf_fnc_sendChat;
				};

				if( count( [PO3_TASK__POS,200,(po3_side_3 select 0),["LandVehicle"] ] call mpsf_fnc_getNearbyUnits) > 0 ) then {
					[(po3_side_1 select 0),"SIDE",format[localize "STR_PO3_M12_MSG_1",(po3_side_3 select 2)]] call mpsf_fnc_sendChat;
					waitUntil{count ([PO3_TASK__POS,200,(po3_side_3 select 0),["LandVehicle"] ] call mpsf_fnc_getNearbyUnits) == 0};
					[(po3_side_1 select 0),"SIDE",format[localize "STR_PO3_M12_MSG_2",(po3_side_3 select 2)]] call mpsf_fnc_sendChat;
				};

				_timer <= 0
				|| count nearestObjects[ PO3_TASK__POS, po3_target_tower_types, 80] == 0
				|| format["TASK%1",PO3_TASK__IDD] call mpsf_fnc_isTaskcompleted
			};
			if(_timer <= 0) then { po3_FLAG_task08_towerSetup = true }else{ po3_FLAG_task08_fail = true };

		}else{
			po3_FLAG_task08_fail = true;
		};
	};

// =========================================================================================================
//	Create Mines
// =========================================================================================================

	_allroads = _position nearRoads 300;
	_roads = [];
	_allmines = [];

	{ if(count roadsconnectedto _x > 1) then { _roads = _roads + [_x]; }; } foreach _allroads;

	if(count _roads > 3) then {
		{
			if(random 1 <= 0.4) then {
				_randompos_on_road = [(getpos _x select 0) + 2.5 - random 5, (getpos _x select 1) + 2.5 - random 5, 0];
				_mine = createMine ["ATMine", _randompos_on_road, [], 0];
				PO3_TOTAL_VEHICLES set [count PO3_TOTAL_VEHICLES,_mine];
				_allmines set [count _allmines,_mine];
				if(mpsf_debug) then {
					_marker = createmarkerlocal [format["%2%1",_x,random 999],_randompos_on_road];
					_marker setmarkershapelocal "ICON";
					_marker setmarkertypelocal "mil_dot";
					_marker setmarkercolorlocal "ColorRed";
				};
			};
			if( count _allmines >= 7 ) exitWith{};
		} foreach _roads;
	};

// =========================================================================================================
//	Create Tasks
// =========================================================================================================

	[ format["TASK%1",PO3_TASK__IDD],
		localize "STR_PO3_M12_TITLE",
		format[localize "STR_PO3_M12_DESCR",PO3_TASK__IDD,_locaname],
		(po3_side_1 select 0),
		[format["MRKR%1",PO3_TASK__IDD],PO3_TASK__POS,"mil_objective","ColorBLUFOR",localize "STR_PO3_M12_TITLE"],
		"assigned",
		(PO3_TASK__POS),
		localize "STR_PO3_M12_TITLE"
	] call mpsf_fnc_addTask;

	waitUntil{ sleep 1;
		if(!(alive _container) || damage _container >= 1) then { po3_FLAG_task08_fail = true };
		count ([_position,300,(po3_side_1 select 0),["CAManBase","LandVehicle"] ] call mpsf_fnc_getNearbyPlayers) > 0 || !(alive _container) || damage _container == 1
	};

// =========================================================================================================
//	WAIT UNTIL COMPLETE/FAIL
// =========================================================================================================

	waitUntil{ sleep 1;
		if( count ([_position,300,(po3_side_1 select 0),["CAManBase","LandVehicle"] ] call mpsf_fnc_getNearbyUnits) == 0 ) then { po3_FLAG_task08_fail = true };
		po3_FLAG_task08_towerSetup || po3_FLAG_task08_fail
	};

	sleep 1;
	if !(po3_FLAG_task08_fail) then {
		[format["TASK%1",PO3_TASK__IDD],"succeeded"] call mpsf_fnc_updateTask;
	}else{
		[format["TASK%1",PO3_TASK__IDD],"failed"] call mpsf_fnc_updateTask;
	};

// =========================================================================================================
//	Cleanup
// =========================================================================================================

	[_position,PO3_TOTAL_UNITS,PO3_TOTAL_VEHICLES] spawn {
		private["_target","_units","_vehicles"];

		_target = _this select 0;
		_units = _this select 1;
		_vehicles = _this select 2;

		waitUntil { count ([_target,500,(po3_side_1 select 0),["CAManBase"]] call mpsf_fnc_getNearbyPlayers) == 0 };

		{ if(alive _x) then { _x setDamage 1 }; }forEach _units;
		{ if( {isPlayer _x} count (crew _x) == 0 ) then { _x setDamage 1 }; }forEach _vehicles;
		{ deleteVehicle _x; }forEach (nearestObjects [_target,po3_target_tower_types,350]);
	};
if(true) exitWith {};
