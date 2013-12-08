private["_location","_position","_locaname"];
// =========================================================================================================
//	Define Random Location
// =========================================================================================================

	_location = ["town","poi"] call po3_fnc_getNewPos;

	PO3_TASK__DIF	= po3_param_missionskill;
	PO3_TASK__POS	= _location select 0;
	PO3_TASK__IDD	= format["%1%2:%3",round(PO3_TASK__POS select 0),round(PO3_TASK__POS select 1),(round random 99)];

	_position = [PO3_TASK__POS,[0,(500*PO3_TASK__DIF)],random 360,false] call mpsf_fnc_getPos;
	_locaname = _location select 1;
	_locRadis = _location select 2;

// =========================================================================================================
//	Create Mines
// =========================================================================================================

	_allroads = _position nearRoads 200;
	_roads = [];
	_allmines = [];

	{ if(count roadsconnectedto _x > 1) then { _roads = _roads + [_x]; }; } foreach _allroads;

	_minetype = ["APERSMine","APERSBoundingMine","ATMine"] call mpsf_fnc_getArrayRandom;
	_minename = getText (configFile >> "CfgVehicles" >> _minetype >> "displayName");

	_checkRoads = false;
	if(count _roads > 3) then {
		{
			if(random 1 <= 0.4) then {
				_randompos_on_road = [(getpos _x select 0) + 2.5 - random 5, (getpos _x select 1) + 2.5 - random 5, 0];
				_mine = createMine [_minetype, _randompos_on_road, [], 0];
				_allmines = _allmines + [_mine];
			};
			if( count _allmines >= 6 ) exitWith{};
		} foreach _roads;
		_checkRoads = true;
	} else {
		_position = [_position,250,0.1,2] call mpsf_fnc_getFlatArea;
		for "_i" from 1 to (4+(round random 2)) do {
			_randompos = [(_position select 0) + 25 - random 50, (_position select 1) + 25 - random 50, 0];
			_mine = createMine [_minetype, _randompos, [], 0];
			_allmines = _allmines + [_mine];
		};
	};

	{
		if(mpsf_debug) then {
			_marker = createmarkerlocal [format["%2%1",_x,random 999],(_x call mpsf_fnc_getPos)];
			_marker setmarkershapelocal "ICON";
			_marker setmarkertypelocal "mil_dot";
			_marker setmarkercolorlocal "ColorRed";
		};
	}forEach _allmines;

// =========================================================================================================
//	Create Hostiles - Guards
// =========================================================================================================
	PO3_TOTAL_UNITS = [];
	PO3_TOTAL_VEHICLES = [];

	for "_i" from 1 to 2 do {
		_grp = nil;
		_grp = [ _position, (po3_side_3 select 0), "EN_PatrolGroup0", 20 ] call mpsf_fnc_createGroup;
		if !(isNil "_grp") then {
			[ _position, _grp ] spawn mpsf_fnc_groupDefendPos;
			PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _grp);
			sleep 1;
		};
	};

// =========================================================================================================
//	Create Tasks
// =========================================================================================================

	[ format["TASK%1",PO3_TASK__IDD],
		localize "STR_PO3_M08_TITLE",
		if!(_checkRoads) then {
			format[localize "STR_PO3_M08_DESCR_1",PO3_TASK__IDD,_minename,_locaname,count _allmines ]
		}else{
			format[localize "STR_PO3_M08_DESCR_2",PO3_TASK__IDD,_minename,_locaname,count _allmines ]
		},
		(po3_side_1 select 0),
		[format["MRKR%1",PO3_TASK__IDD],PO3_TASK__POS,"mil_unknown","ColorOPFOR",format[" %1",_minename]],
		"assigned",
		(PO3_TASK__POS),
		localize "STR_PO3_M08_TITLE"
	] call mpsf_fnc_addTask;

	["PO3",format["Task: %1 %2 Generated at %3","ClearMinefield",PO3_TASK__IDD,_location],true] spawn mpsf_fnc_log;

	waitUntil{ sleep 1; count ([_position,300,(po3_side_1 select 0),["CAManBase","LandVehicle"] ] call mpsf_fnc_getNearbyUnits) > 0 };
	[(po3_side_1 select 0),"SIDE",localize "STR_PO3_M08_MSG_0"] call mpsf_fnc_sendChat;

// =========================================================================================================
//	Create Hostiles
// =========================================================================================================

//	_b = 4*(PO3_TASK__DIF*3);
	_b = (12*(playersNumber(po3_side_1 select 0)/40)*PO3_TASK__DIF) max 1;

	for "_i" from 1 to _b do {
		_ingress = [_position ,[400,500],random 360,false] call mpsf_fnc_getPos;
		_grp = nil;
		_grp = [ _ingress, (po3_side_3 select 0), format["EN_GroupForce_%1",round random 4], 50 ] call mpsf_fnc_createGroup;
		if !(isNil "_grp") then {
			[ _position, _grp ] spawn mpsf_fnc_groupAttackPos;
			PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _grp);
			sleep 1;
		};
	};

	_vehClass = [];
	if(_b <= 2) then { _vehClass set [count _vehClass,4]; };
	if(_b >= 3)  then { _vehClass set [count _vehClass,5]; };
	if(_b >= 4) then { _vehClass set [count _vehClass,3]; };

	for "_i" from 0 to (_b/2) do {
		if(random 1 > 0.5 || _b >= 8) then {
			_class = _vehClass call po3_fnc_getVehicleTypes;
			if(count _class > 0) then {
				_ingress = [_position ,[400,500],random 360,false] call mpsf_fnc_getPos;
				_veh = ([ _ingress,_class call mpsf_fnc_getArrayRandom,random 360,100,(po3_side_3 select 0)] call mpsf_fnc_createVehicle) select 0;
				if !(isNil "_veh") then {
					[ _position, _veh, 100 + round(random 300) ] spawn mpsf_fnc_groupPatrolArea;
					PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _veh);
					PO3_TOTAL_VEHICLES set [ count PO3_TOTAL_VEHICLES, vehicle (leader _veh) ];
				};
			};
		};
	};

// =========================================================================================================
//	WAIT UNTIL COMPLETE/FAIL
// =========================================================================================================

	while { { mineActive _x } count _allmines > 0 && count([_position,1000,(po3_side_1 select 0),["CAManBase","LandVehicle"] ] call mpsf_fnc_getNearbyUnits) > 0 } do { sleep 5 };

	sleep 1;
	if( { mineActive _x } count _allmines == 0 ) then {
		[format["TASK%1",PO3_TASK__IDD],"succeeded"] call mpsf_fnc_updateTask;
	}else{
		[(po3_side_1 select 0),"SIDE",localize "STR_PO3_M08_MSG_1"] call mpsf_fnc_sendChat;
		[format["TASK%1",PO3_TASK__IDD],"failed"] call mpsf_fnc_updateTask;
	};

// =========================================================================================================
//	Cleanup
// =========================================================================================================

	[PO3_TASK__POS,PO3_TOTAL_UNITS,PO3_TOTAL_VEHICLES] spawn {
		private["_target","_units","_vehicles"];

		_target = _this select 0;
		_units = _this select 1;
		_vehicles = _this select 2;

		waitUntil { count ([_target,500,(po3_side_1 select 0),["CAManBase"]] call mpsf_fnc_getNearbyPlayers) == 0 };

		{ if(alive _x) then { _x setDamage 1 }; }forEach _units;
		{ if( {isPlayer _x} count (crew _x) == 0 ) then { _x setDamage 1 }; }forEach _vehicles;
	};

if(true) exitWith {};