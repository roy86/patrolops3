/*
	Author: Eightysix

	Description:

	Syntax:

	Example:
*/

#define MPSF_HUDSettings_TBNR (uiNamespace getVariable "mpsf_HUDSettings_Tbnr")
#define MPSF_HUDSettings_HBNR (uiNamespace getVariable "mpsf_HUDSettings_Hbnr")
#define MPSF_HUDSettings_VDSL (uiNamespace getVariable "mpsf_HUDSettings_VDslider")
#define MPSF_HUDSettings_VDST (uiNamespace getVariable "mpsf_HUDSettings_VDtext")

_distance	= _this select 1;

setViewDistance (round _distance);
MPSF_HUDSettings_VDST ctrlSetText format[localize "STR_MPSF_DIALOG_GRAPHIC_VIEWDIST",(round viewdistance)];