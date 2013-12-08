/*
	Author: Eightysix

	Description:
	
*/
private["_text"];

mpsf_player_respawned = false;

closeDialog 0;

[4] spawn mpsf_fnc_onkilled_camera;

121 cuttext [ localize "STR_MPSF_RESPWN_REQUEST", "PLAIN",2];
sleep 2;
[1,""] call mpsf_fnc_camera_fadeout;

createDialog "mpsf_respawn_map";

waitUntil{ mpsf_player_respawned || !dialog };

_text = if(Dialog) then { localize "STR_MPSF_RESPWN_DEPLYED" }else{ "" };
[3,_text] spawn mpsf_fnc_camera_fadein;

closeDialog 0;
mpsf_selected_point = nil;
if(!isNil "mpsf_respawn_selectMarker") then { deleteMarkerLocal mpsf_respawn_selectMarker};
mpsf_respawn_selectMarker = nil;

mpsf_player_respawned = true;