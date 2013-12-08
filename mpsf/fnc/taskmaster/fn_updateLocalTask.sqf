/*
	Author: Shuko
	Modified: Eightysix

	Description:
		DO NOT CALL DIRECTLY	
*/

private ["_task","_name","_state","_handle","_marker"];

for "_i" from 0 to (count mpsf_tasks_TasksLocal - 1) do {
	_task =+ mpsf_tasks_TasksLocal select _i;
	_name = _task select 0;

	if (_name == (_this select 0)) then {
		_marker = _this select 4;
		_state = _this select 5;
		_task set [1,_state];
		mpsf_tasks_TasksLocal set [_i,_task];

		{
			_handle = _x;
			{
				if (_handle in (simpletasks _x)) then {
					_handle settaskstate _state;

					if (_x == player) then {
						if (mpsf_tasks_showHints) then { [_handle,_state] call mpsf_fnc_showTaskHint };
						if (count _marker > 0) then {
							if (_state in ["succeeded","failed","canceled"]) then {
								if mpsf_debug then { diag_log format ["mpsf_Taskmaster> updateTask deleting marker: %1, state: %2",_marker,_state]};
								if (typename (_marker select 0) == typename "") then {
									_marker = [_marker];
								};
								{
									deletemarkerlocal (_x select 0);
								} foreach _marker;
							};
						};
					};
				};
			} foreach (if ismultiplayer then {playableunits} else {switchableunits});
		} foreach (_task select 2);
	};
};