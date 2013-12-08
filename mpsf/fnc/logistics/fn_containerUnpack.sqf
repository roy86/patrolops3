private["_container","_packer","_position","_direction","_objectClass","_containerClass","_object"];

_container	= _this select 0;
_packer		= _this select 1;

if(_packer == player) then {
	if( player call mpsf_fnc_checkActionBusy ) exitWith {};
	true call mpsf_fnc_setActionBusy;
};

_position = _container call mpsf_fnc_getPos; _position set [2,0];
_direction = direction _container;

_objectClass = _container getVariable ["mpsf_packedClass","Land_Cargo20_military_green_F"];
_containerClass = typeOf _container;

_container setVariable ["mpsf_isPackable",false,true];

[true,"HINT",format[localize "STR_MPSF_LOGIST_OBJPACKUOBJ",[_objectClass] call mpsf_fnc_getCfgText,[_containerClass] call mpsf_fnc_getCfgText] ] call mpsf_fnc_hint;

[_packer,"Pack_container"] call mpsf_fnc_animateUnit; // playMove "AinvPknlMstpSlayWrflDnon_medic";

_timer = 8;
waitUntil { sleep 1; _timer = _timer - 1;
	_timer <= 0
	|| !(alive _container)
	|| !(alive _packer)
};
[_packer,"Pack_Stop"] call mpsf_fnc_animateUnit;

if(_packer == player) then { false call mpsf_fnc_setActionBusy };
if !(_timer <= 0) exitWith { _container setVariable ["mpsf_isPackable",true,true] };

deleteVehicle _container;
_object = createVehicle [_objectClass,_position,[],0,"NONE"];
_object setPosATL _position;
_object setDir _direction;
_object setVariable ["mpsf_packedClass",_containerClass,true];
_object setVariable ["mpsf_isPackable",true,true];

_object