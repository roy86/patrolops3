private["_lifter","_object"];

_dragger = _this select 0;
_object = _dragger getVariable ["mpsf_dragged",objNull];

if(isNull _object) exitWith {};

[true,"HINT",format["Releasing %1 from %2",[_object] call mpsf_fnc_getCfgText,[_dragger] call mpsf_fnc_getCfgText] ] call mpsf_fnc_hint;

_dragger setVariable ["mpsf_dragged",objNull,true];
_object setVariable ["mpsf_dragged",objNull,true];