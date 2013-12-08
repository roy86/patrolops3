/*
	Author: Shuko
	Modified: Eightysix

	Description:
	Updates a task on the server and broadcasts the updates to the clients

	Syntax:
		- Unique Task ID
		- Task Status ("succeeded","failed","canceled")

	Example:
		["TASK1","canceled"] call mpsf_fnc_updateTask;
		["TASK2","failed"] call mpsf_fnc_updateTask;
		["TASK3","succeeded"] call mpsf_fnc_updateTask;

*/

if (!isserver) ExitWith {};

private ["_task","_state"];

_state = (_this select 1);

for "_i" from 0 to (count mpsf_tasks_Tasks - 1) do {
	_task =+ (mpsf_tasks_Tasks select _i);
	if ((_task select 0) == (_this select 0)) then {
		_task set [5,_state];
	};
	mpsf_tasks_Tasks set [_i,_task];
};

if (count _this > 2) then {
	switch (typename (_this select 2)) do {
		case (typename ""): { (_this select 2) call mpsf_fnc_assignTask };
		case (typename []): { (_this select 2) spawn { sleep 1; _this call mpsf_fnc_addTask} };
	};
};
publicvariable "mpsf_tasks_Tasks";

if (!isdedicated && mpsf_tasks_initDone) then {
	mpsf_tasks_Tasks spawn mpsf_fnc_handleTaskEvent;
};