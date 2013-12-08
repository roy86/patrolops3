private["_list","_j","_next","_prev","_lim","_script"];

// ==== PO3 Mission Types ==================================================================================
po3_missions = [
	 "po3_task_m01_attackBase"			// <!-- GOOD
	,"po3_task_m02_attackConvoyArmour"	// <!-- GOOD
//	,"po3_task_m03_attackConvoySupply"	// <!-- TEST
//	,"po3_task_m04_captureIntel"		// <!-- TEST
	,"po3_task_m05_captureOfficer"		// <!-- GOOD
	,"po3_task_m06_captureTown"			// <!-- GOOD
	,"po3_task_m07_captureVehicle"		// <!-- GOOD
	,"po3_task_m08_clearMinefield"		// <!-- GOOD
	,"po3_task_m09_clearRunway"			// <!-- GOOD
	,"po3_task_m10_clearSeaMinefield"	// <!-- GOOD
	,"po3_task_m11_createSupplies"		// <!-- GOOD
	,"po3_task_m12_createTower"			// <!-- GOOD
	,"po3_task_m13_defendBase"			// <!-- GOOD
	,"po3_task_m14_defendDamagedBoat"	// <!-- GOOD
	,"po3_task_m15_defendTown"			// <!-- GOOD
	,"po3_task_m16_destroyArtillery"	// <!-- GOOD
	,"po3_task_m17_destroyCaches"		// <!-- GOOD
	,"po3_task_m18_destroyTower"		// <!-- GOOD
	,"po3_task_m19_intelDrone"			// <!-- GOOD
//	,"po3_task_m20_rescuePilots"		// <!-- TEST
];

_list = po3_missions;
//_list = ["po3_task_m03_attackConvoySupply"];
_j = (count _list - 1) min (round random (count _list));
_next = _list select _j;
_prev = _list;
_missioncount = if(isNil "po3_param_missioncount") then { 3 }else{ po3_param_missioncount };
if !(mpsf_debug) then { sleep 30 };
while { _missioncount != 0 } do {
	_lim = 0;
	while{ _next IN _prev && _lim < count _list } do {
		_j = (count _list - 1) min (round random (count _list));
		_next = _list select _j;
		_lim = _lim + 1;
	};
	_prev = if(count _prev >= count _list) then { [_next] }else{ _prev + [_next] };
	_missioncount = _missioncount - 1;
	sleep 5;
	_script = [] execVM format["po3\tasks\%1.sqf",_next];
	waitUntil{ sleep 10; scriptdone _script || !(isNil "mpsf_force_TASKEND") };
	if!(isNil "mpsf_force_TASKEND") then {
		terminate _script;
		[format["TASK%1",PO3_TASK__IDD],"canceled"] call mpsf_fnc_updateTask;

		{ if(alive _x) then { _x setDamage 1 }; }forEach PO3_TOTAL_UNITS;
		{ if( {isPlayer _x} count (crew _x) == 0 ) then { _x setDamage 1 }; }forEach PO3_TOTAL_VEHICLES;

		mpsf_force_TASKEND = nil;
		_missioncount = _missioncount + 1;
	};
};

_counter = 0;
{
	switch (_x select 5) do {
		case "succeeded" : {
			_counter = _counter + 1;
		};
		case "failed" : {
			_counter = _counter - 1;
		};
	};
} foreach mpsf_tasks_Tasks;

mpsf_mission_Status = if(_counter >= 0) then { true }else{ false }; publicVariable "mpsf_mission_Status";