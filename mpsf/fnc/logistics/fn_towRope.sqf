private["_towVeh","_object","_count"];

_towVeh = _this select 0;
_object = _this select 1;

_count = count mpsf_logistics_liftCables;
mpsf_logistics_liftCables set [_count,[_towVeh,_object]]; PublicVariable "mpsf_logistics_liftCables";

waitUntil {
	!([_towVeh,_object] call mpsf_fnc_isTowed)
};

mpsf_logistics_liftCables set [_count,[]]; PublicVariable "mpsf_logistics_liftCables";