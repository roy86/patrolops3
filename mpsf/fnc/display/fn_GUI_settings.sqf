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
disableSerialization;

_display = _this select 0;

uiNamespace setVariable ["mpsf_HUDSettings_GUI",	_display ];
uiNamespace setVariable ["mpsf_HUDSettings_Tbnr",	_display displayCtrl  0];
uiNamespace setVariable ["mpsf_HUDSettings_Hbnr",	_display displayCtrl  1];
uiNamespace setVariable ["mpsf_HUDSettings_VDslider",	_display displayCtrl  2];
uiNamespace setVariable ["mpsf_HUDSettings_VDtext",	_display displayCtrl  3];
uiNamespace setVariable ["mpsf_HUDSettings_BUltra",	_display displayCtrl  4];
uiNamespace setVariable ["mpsf_HUDSettings_BHigh",	_display displayCtrl  5];
uiNamespace setVariable ["mpsf_HUDSettings_BMed",	_display displayCtrl  6];
uiNamespace setVariable ["mpsf_HUDSettings_BLow",	_display displayCtrl  7];
uiNamespace setVariable ["mpsf_HUDSettings_BOff",	_display displayCtrl  8];
uiNamespace setVariable ["mpsf_HUDSettings_B3DHud",	_display displayCtrl  9];

#define MPSF_HUDSettings_TBNR (uiNamespace getVariable "mpsf_HUDSettings_Tbnr")
#define MPSF_HUDSettings_HBNR (uiNamespace getVariable "mpsf_HUDSettings_Hbnr")
#define MPSF_HUDSettings_VDSL (uiNamespace getVariable "mpsf_HUDSettings_VDslider")
#define MPSF_HUDSettings_VDST (uiNamespace getVariable "mpsf_HUDSettings_VDtext")

MPSF_HUDSettings_VDSL sliderSetRange [500,15000];
MPSF_HUDSettings_VDSL sliderSetPosition viewdistance;
MPSF_HUDSettings_VDST ctrlSetText format[localize "STR_MPSF_DIALOG_GRAPHIC_VIEWDIST",(round viewdistance)];