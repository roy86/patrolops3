/*
	Author: Shuko
	Modified: Eightysix

	Description:
		Initilises the mission taskmaster

	Syntax:
		- Preconfigured Tasks	

	Example:
		[] call mpsf_fnc_taskmaster;
	
*/

mpsf_tasks_initDone = false;
mpsf_tasks_showHints = false;

if(mpsfSRV) then {
	mpsf_tasks_Tasks = [];
	if (!isnil "mpsf_CfgTasks_PreDefinedTasks") then {
		if (count mpsf_CfgTasks_PreDefinedTasks > 0) then {
			{ _x call mpsf_fnc_addTask }forEach mpsf_CfgTasks_PreDefinedTasks;
		};
	};
	publicvariable "mpsf_tasks_Tasks";
	if (mpsf_debug_log) then { diag_log format["MPSF -- TaskMaster Init: %1",mpsf_tasks_Tasks] };
};

if(mpsfCLI) then {
	mpsf_tasks_TasksLocal = [];

	waituntil {!isnil "mpsf_tasks_Tasks"};

	private "_sh";
	_sh = mpsf_tasks_Tasks spawn mpsf_fnc_handleTaskEvent;
	waituntil {scriptdone _sh};

	mpsf_tasks_showHints = true;
	mpsf_tasks_initDone = true;

	"mpsf_tasks_Tasks" addPublicVariableEventHandler { (_this select 1) spawn mpsf_fnc_handleTaskEvent; };
};