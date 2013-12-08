private["_target"];

_target = _this select 0;

if(_target == mpsf_logistics_SelectedLoadObject) exitWith { [true,"HINT","You cannot load the object on itself!"] call mpsf_fnc_hint };

[_target,mpsf_logistics_SelectedLoadObject] spawn mpsf_fnc_loadObjectOn;

mpsf_logistics_SelectedLoadObject = objNull;
mpsf_logistics_SelectedLoadObject = nil;