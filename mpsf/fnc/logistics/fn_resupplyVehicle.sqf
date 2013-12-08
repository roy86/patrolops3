private ["_vehicle","_position","_vehtype","_vehname","_status_d","_status_f","_sitrep"];

_vehicle	= _this;
_position	= _vehicle call mpsf_fnc_getPos;
_vehtype	= typeOf _vehicle;
_vehname	= [_vehtype] call mpsf_fnc_getCfgText; //getText (configFile >> "CfgVehicles" >> _vehtype >> "displayName");
_status_d	= damage _vehicle;
_status_f	= fuel _vehicle;

if(vehicle player == player) then {
	if( player call mpsf_fnc_checkActionBusy ) exitWith {};
	true call mpsf_fnc_setActionBusy;
};

[true,"HINT",
	format[
		localize "STR_MPSF_VEHRSUP_CHECK",
		_vehname,
		mapGridPosition _position,
		str(round(_status_d*100))+"%",
		str(round(_status_f*100))+"%"
	]
] call mpsf_fnc_hint;

mpsf_pVAR_resupplyVehicle = [random 999, _vehicle]; publicVariable "mpsf_pVAR_resupplyVehicle";

sleep 4;

if(alive player && alive _Vehicle && _vehicle distance _position <= 3) then {
	[format[localize "STR_MPSF_VEHRSUP_START",_vehname]] call mpsf_fnc_hint;
	_vehicle setFuel 0;
};

if(alive player && alive _Vehicle && _vehicle distance _position <= 3) then {
	_repaired = [_vehicle,_vehname,_position,_status_d] call mpsf_fnc_repairVehicle;
};

if(alive player && alive _Vehicle && _vehicle distance _position <= 3) then {
	_rearmed  = [_vehicle,_vehname,_position] call mpsf_fnc_rearmVehicle;
};

if(alive player && alive _Vehicle && _vehicle distance _position <= 3) then {
	_refueled = [_vehicle,_vehname,_position,_status_f] call mpsf_fnc_refuelVehicle;
};

if(alive player && alive _Vehicle && _vehicle distance _position <= 3) then {
	_vehicle setDamage 0;
	_vehicle setFuel 1;
	_vehicle setVehicleAmmo 1;
};

if(!alive player || !alive _Vehicle || _vehicle distance _position > 3) then { [true,"HINT",format[localize "STR_MPSF_VEHRSUP_STOP",_vehname]] call mpsf_fnc_hint };

false call mpsf_fnc_setActionBusy;

[true,"HINT",format[localize "STR_MPSF_VEHRSUP_END",_vehname]] call mpsf_fnc_hint;
