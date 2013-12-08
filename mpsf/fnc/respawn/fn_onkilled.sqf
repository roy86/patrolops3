/*
	Author: Eightysix

	Description:

*/
private["_lives","_gearList"];

mpsf_player_respawned = false;
mpsf_player_respawned_byHALO = false;
_role = player getVariable ["mpsf_VAR_roleAttribute","Rifleman"];

closeDialog 0;

[_this select 0,_this select 1] spawn mpsf_fnc_onkilled_sitrep;
[mpsf_param_respawn_playertime] spawn mpsf_fnc_onkilled_effects;
[mpsf_param_respawn_playertime] spawn mpsf_fnc_onkilled_camera;

_gearList = if!(isNil "mpsf_VAR_savedLoadout") then { mpsf_VAR_savedLoadout }else{ [mpsf_player_body] call mpsf_fnc_getLoadout };

121 cuttext [ localize "STR_MPSF_RESPWN_KILLED", "PLAIN",2];
sleep mpsf_param_respawn_playertime;
[1,""] call mpsf_fnc_camera_fadeout;

createDialog "mpsf_respawn_map";

while{ !mpsf_player_respawned } do {
	if(!dialog) then {
		sleep 1;
		createDialog "mpsf_respawn_map";
	};
};

if !(mpsf_player_respawned_byHALO) then { [player,_gearList] call mpsf_fnc_setLoadout };

_lives = if( mpsf_param_respawn_deathcount >= 0) then { format[localize "STR_MPSF_RESPWN_LIFEREM", round(mpsf_param_respawn_deathcount)] }else{ "" };
[5,format[localize "STR_MPSF_RESPWN_RENTER",_lives] ] spawn mpsf_fnc_camera_fadein;

closeDialog 0;
mpsf_selected_point = nil;
if(!isNil "mpsf_respawn_selectMarker") then { deleteMarkerLocal mpsf_respawn_selectMarker};

mpsf_respawn_selectMarker = nil;
mpsf_player_body spawn {
	hideBody _this;
	sleep 3;
	deleteVehicle _this;
};

player setVariable ["mpsf_VAR_roleAttribute",_role,true];
mpsf_player_body = player;
mpsf_player_respawned = true;