_positions = [
	format["respawn_%1",po3_side_1 select 0] call mpsf_fnc_getPos,
	format["respawn_%1",po3_side_2 select 0] call mpsf_fnc_getPos,
	format["respawn_%1",po3_side_3 select 0] call mpsf_fnc_getPos
];

for "_i" from 0 to 2 do {
	_pos = _positions select _i;

	_nearbyBuildings = nearestObjects [_pos, ["building"], 100];
	{
	    _x allowDamage false;
	    _x enableSimulation false;
	}forEach _nearbyBuildings;
};

if(isNil "mpsf_protector_enable") then { mpsf_protector_enable = true };

[] spawn {
	while {true} do {
		_state = [ format["respawn_%1",po3_side_1 select 0] call mpsf_fnc_getPos,500,1,["CAManBase","LandVehicle","AIR"],[(po3_side_3 select 0)],false] call po3_fnc_checkNearEntities;
		if (_state) then {
			mpsf_protector_enable = false;
		//	["Enemy Forces detected near base. Base Anti Fire Disabled"] call mpsf_fnc_chat_command;
		}else{
			mpsf_protector_enable = true;
		//	["Enemy Forces cleared. Base Anti Fire Enabled"] call mpsf_fnc_chat_command;
		};
		waitUntil {
			sleep 5;
			_state && !([ format["respawn_%1",po3_side_1 select 0] call mpsf_fnc_getPos,500,0,["CAManBase","LandVehicle","AIR"],[(po3_side_3 select 0)],false] call po3_fnc_checkNearEntities) ||
			!_state && ([ format["respawn_%1",po3_side_1 select 0] call mpsf_fnc_getPos,500,0,["CAManBase","LandVehicle","AIR"],[(po3_side_3 select 0)],false] call po3_fnc_checkNearEntities)
		};
	};
};