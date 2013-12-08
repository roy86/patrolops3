/*
	Author: Eightysix

	Description:
	Sets the Rain

	Syntax:
	[<number>,<number>] call mpsf_fnc_setRain;

	Example:

*/
private["_state","_time"];

_state = _this select 0;
_time = _this select 1;

_time setRain _state;

["Weather",format["mpsf_fnc_setRain to %1",[_state,_time] ] ] call mpsf_fnc_log;