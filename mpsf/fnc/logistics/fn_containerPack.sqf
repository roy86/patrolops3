private["_object","_packer","_position","_direction","_containerClass","_objectClass","_container"];

_packer = _this select 0;
_object	= nearestObjects[ position _packer, ["Land_TTowerBig_2_F","Land_Communication_F"], 20] select 0;

if(isNil "_object") exitWith {};

if(_packer == player) then {
	if( player call mpsf_fnc_checkActionBusy ) exitWith {};
	true call mpsf_fnc_setActionBusy;
};

_position = _object call mpsf_fnc_getPos; _position set [2,0];
_direction = direction _object;

_containerClass = _object getVariable ["mpsf_packedClass","Land_Cargo20_military_green_F"];
_objectClass = typeOf _object;

_object setVariable ["mpsf_isPackable",false,true];

[true,"HINT",format[localize "STR_MPSF_LOGIST_OBJPACKIOBJ",[_object] call mpsf_fnc_getCfgText,[_containerClass] call mpsf_fnc_getCfgText] ] call mpsf_fnc_hint;

[_packer,"Pack_Object"] call mpsf_fnc_animateUnit;// playMove "AinvPknlMstpSlayWrflDnon_medic";

_timer = 8;
waitUntil { sleep 1; _timer = _timer - 1;
	_timer <= 0
	|| !(alive _object)
	|| !(alive _packer)
};
[_packer,"Pack_Stop"] call mpsf_fnc_animateUnit;

if(_packer == player) then { false call mpsf_fnc_setActionBusy };
if !(_timer <= 0) exitWith { _object setVariable ["mpsf_isPackable",true,true] };

deleteVehicle _object;
_container = createVehicle [_containerClass,_position,[],0,"NONE"];
_container setPosATL _position;
_container setDir _direction;
_container setVariable ["mpsf_packedClass",_objectClass,true];
_container setVariable ["mpsf_isPackable",true,true];

_container