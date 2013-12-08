/*
	Author: Eightysix

	Description:


	Syntax:


	Example:

*/
private["_fog","_time"];

_fog = _this select 0;
_time = _this select 1;

_time setFog _fog;

["Weather",format["mpsf_fnc_setFog to %1<br/>%2",(_this select 0),_fog] ] call mpsf_fnc_log;
