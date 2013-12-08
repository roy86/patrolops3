private["_lifter","_object"];

_loader = _this select 0;
_object = _loader getVariable ["mpsf_loaded",objNull];

if(isNull _object) exitWith { _loader setVariable ["mpsf_loaded",objNull,true] };

[true,"HINT",format[ localize "STR_MPSF_LOGIST_UNLOADINGOBJECT",[_object] call mpsf_fnc_getCfgText,[_loader] call mpsf_fnc_getCfgText] ] call mpsf_fnc_hint;

sleep 3;

_loader setVariable ["mpsf_loaded",objNull,true];
_object setVariable ["mpsf_loaded",objNull,true];