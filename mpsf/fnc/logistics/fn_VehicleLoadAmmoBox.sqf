private[];

_vehicle	= _this select 0;
_position	= _vehice call mpsf_fnc_getPos;

if(_vehice getVariable ["mpsf_ammobox_loaded",false]) exitWith { [localize "STR_MPSf_LOGIST_AMMOBOX_ONBOARD"] call mpsf_fnc_hint };

_canLoad = [_vehicle,"AMMO"] call mpsf_fnc_getVehicleConfig;
_nearbyReupplyPoints = {_x != vehicle player && _x getVariable ["mpsf_resupply",false]} count (_position nearEntities 10)
_nearbyAmmoboxes = {_x isKindof "Ammobox" } count (_position nearEntities 10)

if( _canLoad && _nearbyReupplyPoints > 0 ) then {
	[ format[localize "STR_MPSF_LOGIST_MAGBOX_LOADING",[_vehicle] call mpsf_fnc_getCfgText] ] call mpsf_fnc_hint;
	sleep 10;
	_vehicle setVariable ["mpsf_ammoboxLoaded",true,true];
	[ format[localize "STR_MPSF_LOGIST_MAGBOX_LOADED",[_vehicle] call mpsf_fnc_getCfgText] ] call mpsf_fnc_hint;
}else{
	// Do Nothing
};