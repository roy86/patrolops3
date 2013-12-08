private["_location","_position","_locaname"];
// =========================================================================================================
//	Define Random Location
// =========================================================================================================

	_location = "town" call po3_fnc_getNewPos;

	PO3_TASK__DIF	= po3_param_missionskill;
	PO3_TASK__POS	= _location select 0;
	PO3_TASK__IDD	= format["%1%2:%3",round(PO3_TASK__POS select 0),round(PO3_TASK__POS select 1),(round random 99)];

	_position = [PO3_TASK__POS,0,0,false] call mpsf_fnc_getPos;
	_locaname = _location select 1;
	_locRadis = _location select 2;

// =========================================================================================================
//	Create Tasks
// =========================================================================================================

	[ format["TASK%1",PO3_TASK__IDD],
		format[localize "STR_PO3_M15_TITLE",_locaname],
		format[localize "STR_PO3_M15_DESCR",PO3_TASK__IDD,_locaname,(po3_side_3 select 2)],
		(po3_side_1 select 0),
		[format["MRKR%1",PO3_TASK__IDD],_position,"mil_objective","ColorBlufor",format[localize "STR_PO3_M15_TITLE",_locaname]],
		"assigned",
		_position,
		format[localize "STR_PO3_M15_TITLE",_locaname]
	] call mpsf_fnc_addTask;

// =========================================================================================================
//	WAIT UNTIL ARRIVAL
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

	waitUntil{ sleep 1; count([_position,100,(po3_side_3 select 0),["CAManBase"]] call mpsf_fnc_getNearbyUnits) <= 3 };

	[(po3_side_1 select 0),"SIDE",format[localize "STR_PO3_M15_MSG_1",(po3_side_3 select 2)]] call mpsf_fnc_sendChat;

// =========================================================================================================
//	Create Hostiles
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

	_intelpercent = 1;
	_percentAlive = 1;
	_fired1 = false;
	_fired2 = false;
	_fired3 = false;

	While{ _percentAlive > 0.15 && count([_position,300,(po3_side_1 select 0),["CAManBase","LandVehicles"]] call mpsf_fnc_getNearbyPlayers) > 0 } do {
		sleep 3;

		_b = (4*(playersNumber(po3_side_1 select 0)/40)*PO3_TASK__DIF) max 1;

		if( _percentAlive < 0.9 && !_fired1 ) then {
			[_position,(_b)] call _spawnAmbush;
			[(po3_side_1 select 0),"SIDE",format[localize "STR_PO3_M15_MSG_2",(po3_side_3 select 2)]] call mpsf_fnc_sendChat;
			_fired1 = true;
			_percentAlive = ({alive _x} count PO3_TOTAL_UNITS)/(count PO3_TOTAL_UNITS);
		};

		if( _percentAlive < 0.6 && !_fired2 ) then {
			[_position,(_b)*2] call _spawnAmbush;
			[(po3_side_1 select 0),"SIDE",format[localize "STR_PO3_M15_MSG_3",(po3_side_3 select 2)]] call mpsf_fnc_sendChat;
			_fired2 = true;
			_percentAlive = ({alive _x} count PO3_TOTAL_UNITS)/(count PO3_TOTAL_UNITS);
		};

		if( _percentAlive < 0.3 && !_fired3 ) then {
			[_position,(_b)*3] call _spawnAmbush;
			[(po3_side_1 select 0),"SIDE",format[localize "STR_PO3_M15_MSG_4",(po3_side_3 select 2)]] call mpsf_fnc_sendChat;
			_fired3 = true;
			_percentAlive = ({alive _x} count PO3_TOTAL_UNITS)/(count PO3_TOTAL_UNITS);
		};

		_nearByUnits = [_position,100,(po3_side_1 select 0),["CAManBase","LandVehicles"]] call mpsf_fnc_getNearbyPlayers;
		if( count (_nearByUnits) > 0 ) then {
			_increment = 0.03 / (PO3_TASK__DIF*3) / 3;
			_intelpercent = _intelpercent - _increment;
			_percentAlive = ({alive _x} count PO3_TOTAL_UNITS)/(count PO3_TOTAL_UNITS);
			_percentAlive = _percentAlive max _intelpercent;
			["player == leader group player",["EN Strength",_percentAlive - 0.15] ] call mpsf_fnc_progressBar;
		};
	};

// =========================================================================================================
//	WAIT UNTIL COMPLETE/FAIL
// =========================================================================================================

	sleep 1;
	if(_percentAlive <= 0.1) then {
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
	};

if(true) exitWith {};