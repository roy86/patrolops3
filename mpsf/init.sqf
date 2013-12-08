// =========================================================================================================
// MPSF - MultiPlayer Scripting Framework by EightySix
// Version Release 3.1
// PERMITTED FOR PUBLIC RELEASE WITHOUT MODIFICATION
// =========================================================================================================
diag_log [diag_frameno, diag_ticktime, time, format ["###### %1 MPSF INIT ######", missionName] ];
enableSaving [false, false];
// =========================================================================================================
mpsf_debug = false;
mpsf_debug_log = false;

if(mpsf_debug) then {
	OnMapSingleClick "vehicle player SetPos [_pos select 0, _pos select 1, if( (vehicle player) isKindof ""AIR"" && isEngineOn (vehicle player) ) then { 100 }else{ 0 } ]";
	player allowDamage false;
};

// = Pre-Defining Repawn Deployment Points =====================================================
mpsf_CfgRespawn_PreDefinedPositions = [
	 [west,"redeploy_west","b_hq","Base"]
	,[west,"redeploy_west_marine","b_naval","Marina Base South"]
	,[west,"redeploy_west_marine_1","b_naval","Marina Base North"]
	,[east,"redeploy_east","o_hq","Base"]
	,[east,"redeploy_east_marine","o_naval","Marina Base South"]
	,[east,"redeploy_east_marine_1","o_naval","Marina Base North"]
	,[resistance,"redeploy_guerrila","n_hq","Base"]
	,[resistance,"redeploy_guerrila_marine","n_naval","Marina Base South"]
	,[resistance,"redeploy_guerrila_marine_1","n_naval","Marina Base North"]
];
mpsf_CfgSupport_UASVehicles = [ // [WEST,EAST,RESISTANCE]
	["B_UavTerminal",	"O_UavTerminal",	"I_UavTerminal"		],	// Terminals
	["B_UAV_02_CAS_F",	"O_UAV_02_CAS_F",	"I_UAV_02_CAS_F"	],	// UAV
	["B_UGV_01_rcws_F",	"O_UGV_01_rcws_F",	"I_UGV_01_rcws_F"	]	// UGV
];
// =========================================================================================================
// !!  DO NOT MODIFY THIS FILE  !!
// =========================================================================================================
#include <cfgMPSF.hpp>
#include <cfgMPSFLogistics.hpp>
#include <cfgMPSFLoadouts.hpp>
#ifdef MPSF_VERSION_A3
	mpsf_a3 = true;
	mpsf_reference_object = "Sign_Pointer_F";
	mpsf_reference_heliempty = "Land_HelipadEmpty_F";
	mpsf_cfg_ammobox = "B_supplyCrate_F";
#else
	mpsf_a3 = false;
	mpsf_reference_object = "HeliHEmpty";
	mpsf_reference_heliempty = "HeliHEmpty";
	mpsf_cfg_ammobox = "USBasicWeapons_EP1";
#endif
#ifdef PLAYER_INJURY_DISABLE_UNCONSCIOUS
	mpsf_param_injury_down = false;
#endif
mpsf_spectate_start = { [_this select 0, _this select 1, _this select 2] execVM (mpsf_path_modules+"keg_spectate\mpsf_specate_Kegetys.sqf"); };
[] call mpsf_fnc_processParams;
[] call mpsf_fnc_taskmaster;
[] call mpsf_fnc_syncMPEnv;
[] spawn mpsf_fnc_cleanup;
if(mpsfSRV) then {
	mpsf_SRV_HLC_grp_recieved = nil;
	{ switch (side _x) do { case west : { mpsf_active_side_west = true }; case east : { mpsf_active_side_east = true }; case resistance : { mpsf_active_side_guer = true }; case civilian : { mpsf_active_side_civ = true }; case sidelogic : { mpsf_active_side_logic = true }; }; }forEach allunits;
	if(isNil "mpsf_active_side_west") then { createCenter west };
	if(isNil "mpsf_active_side_east") then { createCenter east };
	if(isNil "mpsf_active_side_guer") then { createCenter resistance };
	if(isNil "mpsf_active_side_civ")  then { createCenter civilian };
	if(isNil "mpsf_active_side_logic") then { createCenter sideLogic };
	west setFriend [civilian, 1]; west setFriend [east, 0];// west setFriend [resistance, 0];
	east setFriend [civilian, 1]; east setFriend [west, 0];// east setFriend [resistance, 0];
//	resistance setFriend [civilian,0]; resistance setFriend [east,0]; resistance setFriend [west,0];
	civilian setFriend [east,1]; civilian setFriend [west,1];// civilian setFriend [resistance, 1];
	["Centers","All Centers Created and Friendships set"] call mpsf_fnc_log;
	mpsf_respawn_positions_global = mpsf_CfgRespawn_PreDefinedPositions; publicVariable "mpsf_respawn_positions_global";
	["Redeploy",format["Initilised with points: %1",mpsf_CfgRespawn_PreDefinedPositions] ] call mpsf_fnc_log;
	mpsf_playerskilled = []; publicVariable "mpsf_playerskilled";
	mpsf_death_group = createGroup civilian; publicVariable "mpsf_death_group";
	["DeathGroup",format["Init %1",mpsf_death_group] ] call mpsf_fnc_log;
	mpsf_logistics_referencepoint = mpsf_reference_heliempty createVehicle [0, 0, 0]; publicVariable "mpsf_logistics_referencepoint";
	[] spawn mpsf_fnc_objectrespawn;
	"mpsf_HLC_CLI__DATA" addPublicVariableEventHandler { ["HLC",format["Detected %1",_this select 1] ] call mpsf_fnc_log; (_this select 1) call mpsf_fnc_initHLC; };
	"mpsf_HLC_CLI__SPAWNER" addPublicVariableEventHandler { ["HLC",format["HLC Spawned %1: %2",typename (_this select 1),(_this select 1)] ] call mpsf_fnc_log; mpsf_SRV_HLC_grp_recieved = _this select 1; };
	"mpsf_brdcst_requestOwnerChange" addPublicVariableEventHandler { (_this select 1) call mpsf_fnc_setOwner };
};
if(mpsfCLI) then {
	[] call mpsf_fnc_diary;
	mpsf_respawn_rallypoint_active = false;
	[] spawn {
		waituntil {!isnull player};
		mpsf_player_body = player;
		player call mpsf_fnc_setHealEH;
		player call mpsf_fnc_setDamageEH;
		player call mpsf_fnc_setKilledEH;
	};
	[] spawn { /* Handle TK */
		private["_score"];
		while {true} do {
			waitUntil { alive player && rating player < 0 };
			if( rating player < 0 ) then {
				_score = (-1*(rating player));
				player addrating _score;
				_score = rating player;
			};
		};
	};
//	if(mpsf_mod_ace_enabled) then { [player, true] call ace_fnc_setCrewProtection; };
	"mpsf_brdcst_chat" addPublicVariableEventHandler { (_this select 1) call mpsf_fnc_chat; };
	"mpsf_brdcst_hint" addPublicVariableEventHandler { (_this select 1) call mpsf_fnc_hint; };
	"mpsf_brdcst_progressBar" addPublicVariableEventHandler { (_this select 1) call mpsf_fnc_progressbar; };
	"mpsf_brdcst_tactxt" addPublicVariableEventHandler { (_this select 1) call mpsf_fnc_text_tactical; };
	"mpsf_pVAR_effectLGHTSTRK" addPublicVariableEventHandler { (_this select 1) call mpsf_fnc_effectLightningStrike; };
	"mpsf_brdcst_SRVCLI" addPublicVariableEventHandler { mpsf_brdcst_serverRequest = true };
	"mpsf_pVAR_declaredAmmobox" addPublicVariableEventHandler { (_this select 1) call mpsf_fnc_handleAmmobox; };
	"mpsf_pVAR_declaredSupplybox" addPublicVariableEventHandler { (_this select 1) call mpsf_fnc_handleSupplybox; };
};
if(mpsfHLC) then { [] spawn mpsf_fnc_setHLCID; };
"mpsf_pVAR_changeDateTime" addPublicVariableEventHandler { (_this select 1) spawn mpsf_fnc_changeTime; };
"mpsf_pVAR_skipDateTime" addPublicVariableEventHandler { (_this select 1) spawn mpsf_fnc_skipTime; };
"mpsf_pVAR_changeFog" addPublicVariableEventHandler { (_this select 1) spawn mpsf_fnc_setFog; };
"mpsf_pVAR_changeOvercast" addPublicVariableEventHandler { (_this select 1) spawn mpsf_fnc_setOvercast; };
"mpsf_pVAR_changeWind" addPublicVariableEventHandler { (_this select 1) spawn mpsf_fnc_setWind; };
"mpsf_pVAR_changeRain" addPublicVariableEventHandler { (_this select 1) spawn mpsf_fnc_setRain; };
"mpsf_pVAR_animationState" addPublicVariableEventHandler { (_this select 1) spawn mpsf_fnc_playActionNow; };
"mpsf_pVAR_directionState" addPublicVariableEventHandler { (_this select 1) spawn mpsf_fnc_setDir; };
"mpsf_pVAR_resupplyVehicle" addPublicVariableEventHandler { _vehicle = (_this select 1) select 1; if(local _vehicle) then { _vehicle call mpsf_fnc_resupplyVehicle }; };
"mpsf_pVAR_changeGroupID" addPublicVariableEventHandler { (_this select 1) spawn mpsf_fnc_setGroupID; };
"mpsf_pVAR_changeGroupLeader" addPublicVariableEventHandler { (_this select 1) spawn mpsf_fnc_setLeader; };
"mpsf_pVAR_setVehicleHit" addPublicVariableEventHandler { (_this select 1) spawn mpsf_fnc_setVehicleHitLocal; };
["Init Finished",[diag_frameno, diag_ticktime, time, missionName] ] call mpsf_fnc_log;
mpsf_core_init = true;
sleep 1;
if(mpsfSRV) then {
	if(mpsf_param_ambient_civs_enable) then { [300,8,6] spawn mpsf_fnc_ambientCivs; };
	if(mpsf_param_ambient_civtraffic_enable) then { [800,15,9] spawn mpsf_fnc_ambientTraffic; };
};
if(mpsfCLI) then {
	(findDisplay 46) displayAddEventHandler ["KeyDown","_this call mpsf_fnc_keypress"];
	[] spawn mpsf_fnc_camera_Restrict3rdPerson;
	[] spawn mpsf_fnc_display_init;
	[] spawn mpsf_fnc_grpmark_draw;
	[] spawn mpsf_fnc_interaction_else;
	[] spawn mpsf_fnc_interaction_self;
	player enableFatigue mpsf_param_player_fatigue;
	if(mpsf_param_respawn_halo_allow) then { ["halo"] call mpsf_fnc_addRespawnPosLocal; };
};
