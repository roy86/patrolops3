/*
	Author: Community & Eightysix

	Description:
	Not to be called Directly!

*/
private ["_thisCount","_position","_side","_type","_radius","_stance","_spwngrp","_units","_strength","_skill","_unit"];

if(!mpsfSRV && !mpsfHLC) exitWith {};

_thisCount = count _this;

_position	= _this select 0;
_side		= _this select 1;
_type		= if(_thisCount > 2) then { _this select 2 }else{ "INF" };
_radius		= if(_thisCount > 3) then { _this select 3 }else{ 0 };
_stance		= if(_thisCount > 4) then { _this select 4 }else{ "NONE" };
_strength	= if(_thisCount > 5) then { _this select 5 }else{ 0 };

if(isNil "mpsf_param_ai_skill") then { mpsf_param_ai_skill = 0.67 };

_units = if( toupper(typename _type) == "STRING" ) then {
	_type call mpsf_fnc_getpreDefinedSquads;
}else{
	_type;
};

_spwngrp = createGroup _side;

if(count _units == 0 || isNull _spwngrp) exitWith {
	["fnc_Create_Group",format["ERROR No Units in List %1",_type],true] call mpsf_fnc_log;

	if( mpsfHLC ) then {
		mpsf_HLC_CLI__SPAWNER = format["Unable to spawn group. No Units in List %1",_type];
		publicVariableServer "mpsf_HLC_CLI__SPAWNER";
	};

	grpNull
};

_strength = if( toupper(typename _type) == "ARRAY" ) then {
	count _units
}else{
	if(_thisCount > 5) then { _strength }else{ count _units };
};

_position = if(_radius > 0) then { [_position,_radius,random 360] call mpsf_fnc_getPos }else{ _position call mpsf_fnc_getPos };

for "_j" from 0 to (_strength - 1) do {
	_unit = _spwngrp createUnit [_units select _j, _position, [], 0, "NONE"];
	_unit setSkill mpsf_param_ai_skill;
	_unit allowFleeing 0;
};

if(mpsf_param_ai_easyKill) then { (units _spwngrp) spawn mpsf_fnc_setDamageEH_AI; };

["fnc_Create_Group",format["Group Spawned at %1 with %2 Units",_position,count (units _spwngrp)] ] call mpsf_fnc_log;

mpsf_active_units = mpsf_active_units + (units _spwngrp);

if( mpsfHLC ) then {
	mpsf_HLC_CLI__SPAWNER = _spwngrp;
	publicVariableServer "mpsf_HLC_CLI__SPAWNER";
};

_spwngrp