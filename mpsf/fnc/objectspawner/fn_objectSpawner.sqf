/*
	Author: Community & Eightysix

	Description:
	Not to be called Directly!

*/
private ["_type","_side","_position","_dir","_radius","_vehicle","_grp","_crewtype","_max","_unit"];

if(!mpsfSRV && !mpsfHLC) exitWith {};


_position	= _this select 0;
_type		= _this select 1;
_dir		= if(count _this > 2) then { _this select 2 }else{ random 360 };
_radius		= if(count _this > 3) then { _this select 3 }else{ 0 };
_side		= if(count _this > 4) then { _this select 4 }else{ nil };

_position = if(_radius > 0) then { [_position,_radius] call mpsf_fnc_getPos }else{ _position call mpsf_fnc_getPos };

_vehicle = createVehicle [_type, _position, [], _radius, "NONE"];
_vehicle setDir _dir;

if(isNil "_side") exitWith{
	if( mpsfHLC ) then {
		mpsf_HLC_CLI__SPAWNER = _vehicle;
		publicVariableServer "mpsf_HLC_CLI__SPAWNER";
	};

	["fnc_Create_Object",format["Object %1 Created at %2",_vehicle,_position] ] spawn mpsf_fnc_log;

	_vehicle;
};

_grp = createGroup _side;

_crewtype = getArray (configFile >> "CfgVehicles" >> _type >> "typicalCargo");
if( count(_crewtype - ["Soldier"]) == 0 ) then{
	_crewtype = switch (_side) do {
		case resistance : { [mpsf_CfgSpawner_DefaultCrewTypes select 2] };
		case east : { [mpsf_CfgSpawner_DefaultCrewTypes select 1] };
		default { [mpsf_CfgSpawner_DefaultCrewTypes select 0] };
	};
};
_max = (count _crewtype) - 1;

if( (_vehicle emptyPositions "commander") > 0 ) then {
	_unit = _grp createUnit [_crewtype select (round random _max), _position, [], _radius, "NONE"];
	_unit setSkill mpsf_param_ai_skill;
	_unit allowFleeing 0;
	_unit moveinCommander _vehicle;
};

if( ( _vehicle emptyPositions "gunner") > 0 ) then {
	_unit = _grp createUnit [_crewtype select (round random _max), _position, [], _radius, "NONE"];
	_unit setSkill mpsf_param_ai_skill;
	_unit allowFleeing 0;
	_unit moveinGunner _vehicle;
};

if( ( _vehicle emptyPositions "driver") > 0 ) then {
	_unit = _grp createUnit [_crewtype select (round random _max), _position, [], _radius, "NONE"];
	_unit setSkill mpsf_param_ai_skill;
	_unit allowFleeing 0;
	_unit moveinDriver _vehicle;
};

if(mpsf_param_ai_easyKill) then { (units _grp) spawn mpsf_fnc_setDamageEH_AI; };

["fnc_Create_Object",format["Object %1 created at %2 with crew",_vehicle,_position]] call mpsf_fnc_log;

mpsf_active_units = mpsf_active_units + (units _grp) + [_vehicle];

if(mpsf_debug_log) then { diag_log format["MPSF -- Spawner Group and Object Created: %1",[units _grp,_vehicle]] };

if( mpsfHLC ) then {
	mpsf_HLC_CLI__SPAWNER = [_grp,_vehicle];
	publicVariableServer "mpsf_HLC_CLI__SPAWNER";
};

[_grp,_vehicle]