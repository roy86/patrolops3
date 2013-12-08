scriptName "mpsf\fnc\ai\fn_group_attack.sqf";
/*
	Author: Community & Eightysix

	Description:
	Sets a group to attack a location. Expect Explosions.

	Syntax:
	[<position>,<group>] spawn mpsf_fnc_group_attack

		position - Array, String, Object
		group - Group ID

	Returns: Nil
*/
private ["_grp", "_pos","_wp"];

_position = (_this select 0) call mpsf_fnc_getPos;
_grp = switch( toUpper( typeName( _this select 1 ) ) ) do {
	case "GROUP" : { _this select 1 };
	case "OBJECT" : { group driver (_this select 1) };
	default {nil};
};

if(isNil "_grp") exitWith { ["fnc_Group_Attack","Undefined Group"] call mpsf_fnc_log };

_wp = _grp addWaypoint [_position, 0];
_wp setWaypointType "SAD";
_wp setWaypointCompletionRadius 20;

_grp setBehaviour "COMBAT";
_grp setCombatMode "YELLOW";
_grp setFormation "WEDGE";
_grp setSpeedMode "NORMAL";