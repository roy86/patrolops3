private ["_tankFuel","_turretClass","_tankDir","_tankUp","_weapon","_turretDir","_turretUp","_dispersion","_speed","_speed0","_speed1","_speed2"];

_tank = _this select 0;
_pos = _tank call mpsf_fnc_getPos;
_dir = direction _tank;

if !(local _tank) exitWith { ["Not local"] call mpsf_fnc_hints };

_tankFuel = fuel _tank;
if (_tankFuel == 0) exitWith { ["No fuel"] call mpsf_fnc_hints };
if (4 < random 5) exitWith {};


_turretClass = "Land_Wreck_Slammer_turret_F";
_hullclass = "Land_Wreck_Slammer_hull_F";

_tankDir = vectorDir _tank;
_tankUp = vectorUp _tank;

// Turret direction
_weapon = (weapons _tank) select 0;
_turretDir = _tank weaponDirection _weapon;
_turretDir = ((_turretDir select 0) atan2 (_turretDir select 1)) - (direction _tank);

deleteVehicle _tank;
_tank = _hullClass createVehicle _pos; _tank setPos _pos; _tank setDir (_dir+180);
_can = "Land_Can_Dented_F" createVehicle [0,0,0];
_can setPos [_pos select 0,_pos select 1,(_pos select 2) + 3];
_turret = _turretClass createVehicle [0,0,0];
sleep 0.1;

//_turret attachTo [_can,[0,0,0]];
_turret setDir _turretDir;
_turret setDamage 1;

waitUntil {(_turret distance _tank) < 10};

createVehicle ["test_EmptyObjectForFireBig",(getPos _turret),[],0,"CAN_COLLIDE"];

//detach _turret;	// exactly that's what happens

_dispersion = random 360;
_speed = 9 + random 9;

_turretUp = vectorUp _turret;
_speed0 = _speed * (_turretUp select 0) + (3 * cos (_dispersion));
_speed1 = _speed * (_turretUp select 1) + (3 * sin (_dispersion));
_speed2 = _speed * (_turretUp select 2);

_can setVelocity [_speed0, _speed1, _speed2]; hint str [_speed0, _speed1, _speed2];

/*
// Stabilize turret
waitUntil {sleep 10; (velocity _turret select 2) < 1};
_turret setVelocity [0,0,0];
_turret setPosASL getPosASL _turret;
*/