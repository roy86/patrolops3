/*
	Author: Eightysix

	Description:
	
*/
_varName = "mpsf_respawn_positions_";

switch (_this select 0) do {
	case "rally" : { missionnamespace setvariable [_varName + "rallypoints",[] ]; };
	case "halo"  : { missionnamespace setvariable [_varName + "halo",[] ]; };
};