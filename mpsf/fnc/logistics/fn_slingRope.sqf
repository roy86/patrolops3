private["_lifter","_object","_count"];

_lifter = _this select 0;
_object = _this select 1;

_count = count mpsf_logistics_liftCables;
mpsf_logistics_liftCables set [_count,[_lifter,_object]]; PublicVariable "mpsf_logistics_liftCables";

waitUntil {
	!([_lifter,_object] call mpsf_fnc_isLifted)
};

mpsf_logistics_liftCables set [_count,[]]; PublicVariable "mpsf_logistics_liftCables";