private["_towVeh","_object"];

_towVeh = _this select 0;
_object = _towVeh getVariable ["mpsf_isTowingObj",objNull];

if(isNull _object) exitWith {};

[true,"HINT",format["Releasing %1 from %2",[_object] call mpsf_fnc_getCfgText,[_towVeh] call mpsf_fnc_getCfgText] ] call mpsf_fnc_hint;

_towVeh setVariable ["mpsf_isTowingObj",objNull,true];
_object setVariable ["mpsf_isTowingObj",objNull,true];