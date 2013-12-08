scriptName "mpsf\fnc\debug\fn_log.sqf";
/*
	Author: Eightysix
*/

_category	= if(count _this > 0) then { _this select 0 }else{ "Log" };
_text		= if(count _this > 1) then { _this select 1 }else{ _this };
_force		= if(count _this > 2) then { _this select 2 }else{ false };

if(!mpsf_debug_log && !_force) exitWith { false };

if(typeName _text != "STRING") then { _text = str(_text) };
_text = format["%3:MPSF - %1: %2",toUpper _category,_text,[diag_frameno,diag_ticktime,time]];
diag_log _text;

if(mpsf_debug || _force) then {
	[true,"HINT",_text] call mpsf_fnc_hint;
};

true