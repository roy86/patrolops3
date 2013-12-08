/*
	Author: Eightysix

	Description:
	
*/
if !(mpsfCLI) exitWith {};

if !(getPlayerUID player IN mpsf_playerskilled) then {
	mpsf_playerskilled = [ count mpsf_playerskilled, getPlayerUID player ];
	publicVariable "mpsf_playerskilled";
};

KEGs_can_exit_spectator = false;

waitUntil {alive player};

switch (playerside) do {
	case east : { player setPosATL ("respawn_east" call mpsf_fnc_getPos) };
	case west : { player setPosATL ("respawn_west" call mpsf_fnc_getPos) };
	case resistance : { player setPosATL ("respawn_guerrila" call mpsf_fnc_getPos) };
	case civilian : { player setPosATL ("respawn_civilian" call mpsf_fnc_getPos) };
};

[player] joinSilent mpsf_death_group;
setplayerRespawnTime 0;
removeAllItems player;
removeAllWeapons player;
removeBackpack player;

[player,player,player] spawn mpsf_spectate_start;