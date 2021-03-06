scriptName "mpsf\fnc\config\fn_getCfgIcon.sqf";
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
private["_object","_class","_picture"];

_object = switch (typeName (_this select 0)) do {
	case "OBJECT"	: { typeOf (_this select 0) };
	case "STRING"	: { _this select 0 };
	default { nil };
};

if(isNil "_object") exitWith { ["fnc_getCfgIcon","Unknown Entitiy"] call mpsf_fnc_log; "" };

_class = switch (true) do {
	case ( isClass ( configFile >> "CfgMarkers"	>> _object ) ) : { "CfgMarkers" };
	case ( isClass ( configFile >> "CfgWeapons"	>> _object ) ) : { "CfgWeapons" };
	case ( isClass ( configFile >> "cfgGroupIcons"	>> _object ) ) : { "cfgGroupIcons" };
	case ( isClass ( configFile >> "CfgVehicles"	>> _object ) ) : { "CfgVehicles" };
	case ( isClass ( configFile >> "CfgGlasses"	>> _object ) ) : { "CfgGlasses" };
	case ( isClass ( configFile >> "CfgItems"	>> _object ) ) : { "CfgItems" };
	default { nil };
};

if(isNil "_class") exitWith { ["fnc_getCfgIcon",format["Detect Config ICON Error off %1",_object]] call mpsf_fnc_log; "" };

_picture = switch (_class) do {
	case "CfgMarkers";
	case "CfgGlasses";
	case "CfgItems";
	case "CfgWeapons";
	case "CfgVehicles"	: {
		if(_object isKindof "CaManBase") then {
			getText(configFile >> "CfgVehicleIcons" >> (getText(configFile >> _class >> _object >> "icon")))
		}else{
			getText(configFile >> _class >> _object >> "icon")
		};
	};
	case "cfgGroupIcons"	: { getText(configFile >> _class >> _object >> "picture") };
};

_picture;