private["_location","_position","_locaname"];
// =========================================================================================================
//	Define Random Location
// =========================================================================================================

	_location = ["hill","poi"] call po3_fnc_getNewPos;

	PO3_TASK__DIF	= po3_param_missionskill;
	PO3_TASK__POS	= _location select 0;
	PO3_TASK__IDD	= format["%1%2:%3",round(PO3_TASK__POS select 0),round(PO3_TASK__POS select 1),(round random 99)];

	_position = [ [PO3_TASK__POS,[0,(500*PO3_TASK__DIF)],random 360,false],50,10,0,0.3] call mpsf_fnc_getSafePos;
	_locaname = _location select 1;
	_locRadis = _location select 2;

// =========================================================================================================
//	Create Target(s)
// =========================================================================================================

	//ensure no other trowers at AO
	{ _x setDamage 1 }forEach (nearestObjects [_position,po3_target_tower_types,500]);
	sleep 1;

	// create target Tower
	_targetTower = (po3_target_tower_types call mpsf_fnc_getArrayRandom) createVehicle _position;
	_targetTower setVectorUp [0,0,1];
	[_targetTower] call mpsf_fnc_setDamageEH_C4Only;

// =========================================================================================================
//	Create Hostiles
// =========================================================================================================
	PO3_TOTAL_UNITS = [];
	PO3_TOTAL_VEHICLES = [];

//	_b = 4*(PO3_TASK__DIF*3);
	_b = (12*(playersNumber(po3_side_1 select 0)/40)*PO3_TASK__DIF) max 1;

	for "_i" from 1 to _b do {
		_grp = nil;
		_grp = [ _position, (po3_side_3 select 0), format["EN_GroupForce_%1",round random 4], 200 ] call mpsf_fnc_createGroup;
		if !(isNil "_grp") then {
			[ _position, _grp, (50 * _i) ] spawn mpsf_fnc_groupPatrolArea;
			PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _grp);
			sleep 1;
		};
	};

	for "_i" from 1 to 2 do {
		_grp = nil;
		_grp = [ _position, (po3_side_3 select 0), format["EN_GroupForce_%1",round random 4], 100 ] call mpsf_fnc_createGroup;
		if !(isNil "_grp") then {
			[ _position, _grp ] spawn mpsf_fnc_groupDefendPos;
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
				_veh = ([ _position,_class call mpsf_fnc_getArrayRandom,random 360,100,(po3_side_3 select 0)] call mpsf_fnc_createVehicle) select 0;
				if !(isNil "_veh") then {
					[ _position, _veh, 100 + round(random 300) ] spawn mpsf_fnc_groupPatrolArea;
					PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _veh);
					PO3_TOTAL_VEHICLES set [ count PO3_TOTAL_VEHICLES, vehicle (leader _veh) ];
				};
			};
		};
	};

	_statics = [_position,4,50,[10] call po3_fnc_getVehicleTypes,(po3_side_3 select 0)] call mpsf_fnc_createStaticDefense;
	if( count _statics > 0 ) then {
		{ PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _x); }forEach _statics;
	};

// =========================================================================================================
//	Create Tasks
// =========================================================================================================

	[ format["TASK%1",PO3_TASK__IDD],
		localize "STR_PO3_M18_TITLE",
		format[ localize "STR_PO3_M18_DESCR",PO3_TASK__IDD,(po3_side_3 select 2),_locaname],
		(po3_side_1 select 0),
		[format["MRKR%1",PO3_TASK__IDD],PO3_TASK__POS,"mil_objective","ColorOPFOR",localize "STR_PO3_M18_TITLE"],
		"assigned",
		PO3_TASK__POS,
		localize "STR_PO3_M18_TITLE"
	] call mpsf_fnc_addTask;

	["PO3",format["Task: %1 %2 Generated at %3","DestroyTower",PO3_TASK__IDD,_location],true] spawn mpsf_fnc_log;

// =========================================================================================================
//	WAIT UNTIL COMPLETE/FAIL
// =========================================================================================================

	waitUntil { sleep 3; !(alive _targetTower) || damage _targetTower > 0.8 || ((getPosATL _targetTower) select 2) < 0 };

	sleep 1;
	[format["TASK%1",PO3_TASK__IDD],"succeeded"] call mpsf_fnc_updateTask;

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
	};


if(true) exitWith {};