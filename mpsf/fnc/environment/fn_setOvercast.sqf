/*
	Author: Eightysix

	Description:
	Sets the Rain

	Syntax:
	[<number>,<number>] call mpsf_fnc_setRain;

	Example:

*/
private["_overcast","_time"];

_overcast = _this select 0;
_time = _this select 1;

_time setOvercast _overcast;
//simulSetHumidity _overcast;

["Weather",format["mpsf_fnc_setOvercast to %1",[_overcast,_time] ] ] call mpsf_fnc_log;

//if(mpsf_debug_log) then { diag_log format["MPSF -- Weather SetOvercast : %1",_this ] };
