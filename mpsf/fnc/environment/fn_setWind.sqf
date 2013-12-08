/*
	Author: Eightysix

	Description:
	Sets the environment wind

	Syntax:
	[<number>,<number>] call mpsf_fnc_setWind;

	Example:

*/
private["_state","_time"];

_windE = _this select 0;
_WindN = _this select 1;

setWind [_windE, _WindN, true];

["Weather",format["mpsf_fnc_setWind to %1",[_windE, _WindN] ] ] call mpsf_fnc_log;