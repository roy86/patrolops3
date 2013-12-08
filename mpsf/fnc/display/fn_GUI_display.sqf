if(dialog) exitWith {};

if(count _this <= 1) then {
	[ localize "STR_MPSF_DIALOG_GRAPHIC_KEYPRESS" ] call mpsf_fnc_hint;
};

switch (true) do {
/*	// LAND
	case ((vehicle player) isKindof "Wheeled_APC_F");
	case ((vehicle player) isKindof "Wheeled_APC");
	case ((vehicle player) isKindof "Truck_F");
	case ((vehicle player) isKindof "Truck");
	case ((vehicle player) isKindof "Car_F");
	case ((vehicle player) isKindof "Car");
	case ((vehicle player) isKindof "Motorcycle");
	case ((vehicle player) isKindof "Tank_F");
	case ((vehicle player) isKindof "Tank");
	case ((vehicle player) isKindof "StaticWeapon");
	case ((vehicle player) isKindof "LandVehicle")		: { createDialog "mpsf_player_HUDsettings" };
	// MAN
	case ((vehicle player) isKindof "SoldierWB");
	case ((vehicle player) isKindof "SoldierEB");
	case ((vehicle player) isKindof "SoldierGB");
	case ((vehicle player) isKindof "CAManBase")		: { createDialog "mpsf_player_HUDsettings" };
	// AIR
	case ((vehicle player) isKindof "ParachuteBase");
	case ((vehicle player) isKindof "Helicopter_Base_F");
	case ((vehicle player) isKindof "Helicopter");
	case ((vehicle player) isKindof "UAV");
	case ((vehicle player) isKindof "Plane_Base_F");
	case ((vehicle player) isKindof "Plane");
	case ((vehicle player) isKindof "Air")			: { createDialog "mpsf_player_HUDsettings" };
	// SEA
	case ((vehicle player) isKindof "Ship")			: { createDialog "mpsf_player_HUDsettings" };

*/	default { createDialog "mpsf_player_HUDsettings" };
};
