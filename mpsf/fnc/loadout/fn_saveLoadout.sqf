_unit = _this select 0;

if!(_unit isKindof "Man") exitWith {};

[_unit,true] call mpsf_fnc_getLoadout;

[true,"HINT","Your loadout and gear have been saved"] call mpsf_fnc_hint;
[true,"GLOBAL","Your loadout and gear have been saved"] call mpsf_fnc_chat;