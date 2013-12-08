/*
	Author: Shuko
	Modified: Eightysix

	Description:
	

	Syntax:
	

	Example:
	

*/

waituntil {alive player};

private "_name";

{
	_name = _x select 0;
	if (_name call mpsf_fnc_hasLocalTask) then {
		if ([_name,(_x select 5)] call mpsf_fnc_hasTaskStateChanged) then {
			if mpsf_debug then { diag_log format ["mpsf_Taskmaster> handleEvent calling updateTask: %1",_name]};
			_x call mpsf_fnc_updateLocalTask;
		};
	} else {
		if mpsf_debug then { diag_log format ["mpsf_Taskmaster> handleEvent calling addTask: %1",_name]};
		_x call mpsf_fnc_addLocalTask;
	};
} foreach _this;