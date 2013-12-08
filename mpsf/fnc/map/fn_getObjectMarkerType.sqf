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
private["_object","_prefix","_type"];

_object = switch (typename _this) do {
	case "GROUP"	: { [vehicle (leader _this),side _this] };
	case "OBJECT"	: { [vehicle _this,side _this] };
	default { [_this,civilian] };
};

_prefix = switch (_object select 1) do {
	case east : { "o" };
	case west : { "b" };
	case resistance : { "n" };
	default { "n" };
};

_type = switch (true) do {
	case ( (_object select 0) isKindof "Truck" )		: { format["%1_motor_inf",_prefix] };
	case ( (_object select 0) isKindof "Wheeled_APC" )	: { format["%1_motor_inf",_prefix] };
	case ( (_object select 0) isKindof "Car" )		: { format["%1_motor_inf",_prefix] };
	case ( (_object select 0) isKindof "Tracked_APC" )	: { format["%1_mech_inf",_prefix] };
	case ( (_object select 0) isKindof "Tank" )		: { format["%1_armor",_prefix] };
	case ( (_object select 0) isKindof "Helicopter" )	: { format["%1_air",_prefix] };
	case ( (_object select 0) isKindof "UAV" )		: { format["%1_uav",_prefix] };
	case ( (_object select 0) isKindof "Plane" )		: { format["%1_plane",_prefix] };
	case ( (_object select 0) isKindof "StaticWeapon" )	: { format["%1_art",_prefix] };
	case ( (_object select 0) isKindof "LandVehicle" )	: { format["%1_motor_inf",_prefix] };
	case ( (_object select 0) isKindof "CaManBase" )	: { format["%1_inf",_prefix] };
	case ( (_object select 0) isKindof "Air" )		: { format["%1_air",_prefix] };
	case ( (_object select 0) isKindof "Ship" )		: { format["%1_naval",_prefix] };
	default { format["%1_inf",_prefix] };
};

_type 