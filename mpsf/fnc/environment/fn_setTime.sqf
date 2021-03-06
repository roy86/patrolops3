/*
	Author: Eightysix

	Description:
	Returns Marker Type of the type vehicle the unit or group is operating.

	Syntax:
	_Type = (unit/group/vehicle) call mpsf_fnc_getObjectMarkerType;

	Example:
	_Type = (player) call mpsf_fnc_getObjectMarkerType;
	_Type = (vehicle player) call mpsf_fnc_getObjectMarkerType;
*/
// Written by EightySix

if(!mpsfSRV) exitWith{ setDate date };

private["_year","_month","_day","_hour","_min"];

	_year	= if(count _this > 2) then { _this select 0 }else{ date select 0 };
	_month	= if(count _this > 2) then { _this select 1 }else{ date select 1 };
	_day	= if(count _this > 2) then { _this select 2 }else{ date select 2 };
	_hour	= if(count _this > 2) then { _this select 3 }else{ _this select 0 };
	_min	= if(count _this > 2) then { _this select 4 }else{ _this select 1 };

	setDate [_year,_month,_day,_hour,_min];

	["Time",format["mpsf_fnc_setTime to %1",[_year,_month,_day,_hour,_min] ] ] call mpsf_fnc_log;

if(true) exitWith{};