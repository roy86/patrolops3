scriptName "mpsf\fnc\camera\fn_outrosequence.sqf";
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
private ["_p1","_p2","_trg"];

mpsf_enable_text_cursorTarget = true;
if(isnil "mpsf_mission_Status") then { mpsf_mission_Status = true };

_title = if( mpsf_mission_Status ) then { localize "STR_MPSF_BRIEF_WINTITLE" }else{ localize "STR_MPSF_BRIEF_LOSETITLE" };
_music = if( mpsf_a3 ) then { "Track12_StageC_action" }else{ "EP1_Track07" };

playMusic _music; 0 fadeMusic 1;
[3,_title] call mpsf_fnc_camera_fadeout;
sleep 3;
[1,""] spawn mpsf_fnc_camera_fadein;

{
	if( !(isPlayer _x) && Local _x) then {
		_x disableAI "TARGET";
		_x disableAI "AUTOTARGET";
		_x disableAI "MOVE";
	};
}forEach allunits;

_trg = player;
_p2 = player call mpsf_fnc_getPos;
{
	if(isPlayer _x || !isMultiplayer && _X in (units group player) ) then{

		_p1 = _x call mpsf_fnc_getPos;
		_p2 = _x call mpsf_fnc_getPos;
		_trg = _x;

		_p1 set [0,(_p1 select 0) + 9*sin(getDir _x) - (2+random 4)*cos(getDir _x)];
		_p1 set [1,(_p1 select 1) + 9*cos(getDir _x) + (2+random 4)*sin(getDir _x)];
		_p1 set [2,(_p1 select 2) + (1 + random 3)];
		_p2 set [0,(_p2 select 0) + 2*sin(getDir _x) - (2+random 4)*cos(getDir _x)];
		_p2 set [1,(_p2 select 1) + 9*cos(getDir _x) + (2+random 4)*sin(getDir _x)];
		_p2 set [2,(_p2 select 2) + (1 + random 3)];

		[_x] spawn mpsf_fnc_text_cursortarget;

		[ [ _p1, _trg,0,0.8,false,false],[ _p2, _trg,4,0.4,false,false] ] call mpsf_fnc_camera_path;
	};
} foreach allUnits;

[ [ _p2, _trg,0,0.5,false,false],[ [_p2 select 0,_p2 select 1,1000], _trg,5,0.9,false,false] ] spawn mpsf_fnc_camera_path;

["Mission",format["EndMission at %1",time]] call mpsf_fnc_log;

if(mpsf_a3) then {
	if(mpsf_mission_Status) then {
		"end1" call BIS_fnc_endMission;
	}else{
		"end2" call BIS_fnc_endMission;
	};
}else{
	endmission "END1";
};
