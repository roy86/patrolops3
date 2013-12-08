/*
	Author: Shuko
	Modified: Eightysix

	Description:
	

	Syntax:
	

	Example:
	
	
*/

if (!isserver) ExitWith {};

private "_task";

for "_i" from 0 to (count mpsf_tasks_Tasks - 1) do {
	if (_this == ((mpsf_tasks_Tasks select _i) select 0)) then {
		_task =+ mpsf_tasks_Tasks select _i;
		_task set [5,"assigned"];
		mpsf_tasks_Tasks set [_i,_task];
	};
};

publicvariable "mpsf_tasks_Tasks";

if (!isdedicated && mpsf_tasks_initDone) then {
	mpsf_tasks_Tasks spawn mpsf_fnc_handleTaskEvent;
};