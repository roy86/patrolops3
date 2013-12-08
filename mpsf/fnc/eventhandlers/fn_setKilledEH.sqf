/*
	Author: Eightysix

	Description:
	

	Syntax:

*/
if(isNil "mpsf_death_group") then { mpsf_death_group = grpNull };
if(isNil "mpsf_param_respawn_playertime") then { mpsf_param_respawn_playertime = 10 };

if( (getPlayerUID player) IN mpsf_playerskilled ) exitWith { player call mpsf_fnc_dead };

setplayerRespawnTime mpsf_param_respawn_playertime;

player addEventHandler ["Killed",{
	KEGs_can_exit_spectator = false;
	if(mpsf_param_respawn_deathcount == 0) then {
		player spawn mpsf_fnc_dead;
	}else{
		mpsf_param_respawn_deathcount = round(mpsf_param_respawn_deathcount - 1);
		[_this select 0, _this select 1] spawn mpsf_fnc_onkilled;
	};

	[] spawn {
		WaitUntil{ alive player };
		setplayerRespawnTime mpsf_param_respawn_playertime;
	};
}];