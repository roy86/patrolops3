/*
	Author: Eightysix

	Description:
	
*/
private ["_player","_varName","_positions","_objectPositions","_groupPositions","_sidePositions","_globalPositions"];

_positions = [];
_varName = "mpsf_respawn_positions_";
_g = missionnamespace getvariable [_varName + "global",[]];
_l = missionnamespace getvariable [_varName + "local",[]];
_r = missionnamespace getvariable [_varName + "rallypoints",[]];
_h = missionnamespace getvariable [_varName + "halo",[]];

{
	_isMHQ = _x getVariable ["mpsf_mhq",nil];
	if(!isNil "_isMHQ") then {
		if( _x getVariable ["mpsf_mhq_state",false] ) then {
			_text = [_dest] call mpsf_fnc_getCfgText;
			_l set [count _l,[ _isMHQ, _x, "", format["%1 (MHQ)",_text] ] ];
		};
	};
}forEach vehicles;

{
	_positions = _positions - [_x];
	if( [player,(_x select 0)] call mpsf_fnc_checkObjCondition ) then {
		_positions set [count _positions,_x];
	};
} foreach (_g+_l+_r+_h);

_positions = _positions - [""];
mpsf_respawn_positions_list = _positions;

_positions;