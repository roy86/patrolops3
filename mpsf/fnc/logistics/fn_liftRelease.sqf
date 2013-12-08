private["_lifter","_object"];

_lifter = _this select 0;
_object = _lifter getVariable ["mpsf_lifted",objNull];

if(isNull _object) exitWith {};

[true,"HINT",format["Releasing %1 from %2",[_object] call mpsf_fnc_getCfgText,[_lifter] call mpsf_fnc_getCfgText] ] call mpsf_fnc_hint;

_lifter setVariable ["mpsf_lifted",objNull,true];
_object setVariable ["mpsf_lifted",objNull,true];