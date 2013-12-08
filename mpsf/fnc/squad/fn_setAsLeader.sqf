private["_unit","_group"];

_unit = switch (typeName (_this) ) do {
	case (typeName []) : { _this select 0 };
	case (typeName grpNull) : { (units _this) select 0 };
	case (typeName objNull) : { _this };
	default { nil };
};
_group = _this select 1;

if(isNil "_unit" || typename _group != typeName grpNull ) exitWith { [true,"HINT","ERROR IN assignGroupLeader"] call mpsf_fnc_hint };

if !(_unit IN (units _group)) then {
	[_unit,_group] call mpsf_fnc_unitJoinGroup;
	sleep 0.1;
};

_group selectLeader _unit;

[ _unit, "GROUP", format[localize "STR_MPSF_DIALOG_ASSIGNLEADERGROUP", str _group] ] call mpsf_fnc_sendChat;
[side _group, "SIDE", format[localize "STR_MPSF_DIALOG_NEWGROUPLEADER", name (leader _group),str _group] ] call mpsf_fnc_sendChat;

true