private["_location","_position","_locaname","_locRadis","_spawnPos","_class","_crashUAV","_spawnAmbush","_intelpercent","_increment","_fired1","_fired2","_fired3","_fired4"];
// =========================================================================================================
//	Define Random Location
// =========================================================================================================

	_location = "poi" call po3_fnc_getNewPos;

	PO3_TASK__DIF	= po3_param_missionskill;
	PO3_TASK__POS	= _location select 0;
	PO3_TASK__IDD	= format["%1%2:%3",round(PO3_TASK__POS select 0),round(PO3_TASK__POS select 1),(round random 99)];

	_position = [PO3_TASK__POS,[0,(500*PO3_TASK__DIF)],random 360,false] call mpsf_fnc_getPos;
	_locaname = _location select 1;
	_locRadis = _location select 2;

// =========================================================================================================
//	Create Target
// =========================================================================================================

	_spawnPos = [_position,[0,60],10,0] call mpsf_fnc_getSafePos;

	_class = [12] call po3_fnc_getVehicleTypes;
	_crashUAV = [ _spawnPos, _class call mpsf_fnc_getArrayRandom, random 360, 0 ] call mpsf_fnc_createVehicle;
	_crashUAV allowDamage false;
	_crashUAV setDamage 0.8;
	_crashUAV setFuel 0;
	_crashUAV lock true;

// =========================================================================================================
//	Create Hostiles - Guards (RANDOM)
// =========================================================================================================
	PO3_TOTAL_UNITS = [];
	PO3_TOTAL_VEHICLES = [];

	_randomValue = (round random 2);
	if(_randomValue >= 1) then {
		for "_i" from 0 to (3*PO3_TASK__DIF) do {
			_grp = nil;
			_grp = [ _position, (po3_side_3 select 0), "EN_PatrolGroup0", 25 ] call mpsf_fnc_createGroup;
			if !(isNil "_grp") then {
				[ position leader _grp, _grp ] spawn mpsf_fnc_groupDefendPos;
				PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _grp);
				sleep 1;
			};
		};
	};
	if(_randomValue >= 2) then {
		// Create Force
		for "_i" from 0 to (3*PO3_TASK__DIF) do {
			_class = [4,9,14] call po3_fnc_getVehicleTypes;
			_veh = nil;
			if(count _class > 0) then {
				_ingress = [position _crashUAV,[10,40] ] call mpsf_fnc_getPos;
				_veh = ([ _ingress,_class call mpsf_fnc_getArrayRandom,random 360,0,(po3_side_3 select 0)] call mpsf_fnc_createVehicle) select 0;
				if !(isNil "_veh") then {
					PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _veh);
					PO3_TOTAL_VEHICLES set [ count PO3_TOTAL_VEHICLES, vehicle (leader _veh) ];
				};
			};
		};
	};

// =========================================================================================================
//	Create Tasks
// =========================================================================================================

	[ format["TASK%1",PO3_TASK__IDD],
		localize "STR_PO3_M19_TITLE",
		format[localize "STR_PO3_M19_DESCR",PO3_TASK__IDD,_locaname,[_crashUAV] call mpsf_fnc_getCfgText],
		(po3_side_1 select 0),
		[format["MRKR%1",PO3_TASK__IDD],PO3_TASK__POS,"mil_unknown","ColorOPFOR"," Approx.UAV.Pos"],
		"assigned",
		PO3_TASK__POS,//(_position),
		localize "STR_PO3_M19_TITLE"
	] call mpsf_fnc_addTask;

	["PO3",format["Task: %1 %2 Generated at %3","DroneIntel",PO3_TASK__IDD,_location],true] spawn mpsf_fnc_log;

// =========================================================================================================
//	WHILE DOWNLOADING INTEL
// =========================================================================================================

	_spawnAmbush = {
		private["_position","_b","_ingress","_grp"];

		_position = _this select 0;
		_b = _this select 1;
		_ingress = [_position ,[400,500],random 360,false] call mpsf_fnc_getPos;

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

	_intelpercent = 0;
	_fired1 = false;
	_fired2 = false;
	_fired3 = false;
	_fired4 = false;

	While{ _intelpercent < 1 && damage _crashUAV < 0.9 } do {
		sleep 1;

		_b = (6*(playersNumber(po3_side_1 select 0)/40)*PO3_TASK__DIF) max 1;

		if( _intelpercent > 0.1 && !_fired1 ) then {
			[_position,(_b)] spawn _spawnAmbush;
			_fired1 = true;
		};

		if( _intelpercent > 0.4 && !_fired2 ) then {
			[_position,(_b)*2] spawn _spawnAmbush;
			_fired2 = true;
		};

		if( _intelpercent > 0.7 && !_fired4 ) then {
			[_position,(_b)*3] spawn _spawnAmbush;
			_fired4 = true;
		};

		_nearByUnits = [_crashUAV,8,(po3_side_1 select 0),["CAManBase"]] call mpsf_fnc_getNearbyPlayers;
		if( count (_nearByUnits) > 0 ) then {
			_crashUAV allowDamage true;
			_increment = 0.01 / (PO3_TASK__DIF*3) / 3;
			_intelpercent = _intelpercent + _increment;
			[_nearByUnits,["Downloaded",_intelpercent]] call mpsf_fnc_sendProgressBar;
		};
	};

// =========================================================================================================
//	WAIT UNTIL COMPLETE/FAIL
// =========================================================================================================

	sleep 1;
	if( damage _crashUAV < 0.9 ) then {
		[(po3_side_1 select 0),"SIDE",format[localize "STR_PO3_M19_MSG_0",[_crashUAV] call mpsf_fnc_getCfgText] ] call mpsf_fnc_sendChat;
		[(po3_side_1 select 0),"HINT",format[localize "STR_PO3_M19_MSG_0",[_crashUAV] call mpsf_fnc_getCfgText] ] call mpsf_fnc_sendHint;
		waitUntil{ sleep 1; damage _crashUAV > 0.8 || count ([_crashUAV,200,po3_side_1,["CAManBase"]] call mpsf_fnc_getNearbyPlayers) <= 0 };
		[format["TASK%1",PO3_TASK__IDD],"succeeded"] call mpsf_fnc_updateTask;
	}else{
		[format["TASK%1",PO3_TASK__IDD],"failed"] call mpsf_fnc_updateTask;
	};

// =========================================================================================================
//	Cleanup
// =========================================================================================================

	[position _crashUAV,PO3_TOTAL_UNITS,PO3_TOTAL_VEHICLES] spawn {
		private["_target","_units","_vehicles"];

		_target = _this select 0;
		_units = _this select 1;
		_vehicles = _this select 2;

		waitUntil { count ([_target,500,(po3_side_1 select 0),["CAManBase"]] call mpsf_fnc_getNearbyPlayers) == 0 };

		{ if(alive _x) then { _x setDamage 1 }; }forEach _units;
		{ if( {isPlayer _x} count (crew _x) == 0 ) then { _x setDamage 1 }; }forEach _vehicles;
	};
	sleep 2;
	deleteVehicle _crashUAV;

if(true) exitWith {};