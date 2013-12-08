// ==== PO3 Side Configuration =============================================================================
	po3_side_1 = [ west, "BLU_F", "NATO" ];		// Player Side
	po3_side_2 = [ east, "OPF_F", "CSAT" ];		// AI Side / Player Side 2 (TvT)
	po3_side_3 = [ east, "OPF_F", "CSAT" ];		// AI Side (Tasks and Ambient)

// ==== PO3 Enemy Unit Groups ==============================================================================
po3_preDefinedEnemySquads = call compileFinal preprocessFileLineNumbers "po3\configs\po3_preDefinedEnemySquads_A3_CSAT.sqf";
mpsf_CfgSpawner_PreDefinedSquads = po3_preDefinedEnemySquads;

// ==== PO3 Friendly Unit Groups ===========================================================================
po3_preDefinedFriendlySquads = [
	 ["FR_GroupRescuePilots",	["B_Helipilot_F","B_Helipilot_F"] ]
	,["FR_GroupRescueCrew",		["B_Helipilot_F"] ]
	,["FR_GroupRescueCargo",	["O_Soldier_TL_F","O_Soldier_AR_F","O_Soldier_AT_F","O_Soldier_AA_F","O_soldier_exp_F","O_medic_F"] ]
];
mpsf_CfgSpawner_PreDefinedSquads = mpsf_CfgSpawner_PreDefinedSquads + po3_preDefinedFriendlySquads;

// ==== PO3 Enemy vehicle Spawner ==========================================================================
po3_preDefinedEnemyVehicles = call compileFinal preprocessFileLineNumbers "po3\configs\po3_preDefinedEnemyVehicles_A3_CSAT.sqf";
mpsf_CfgSpawner_PreDefinedVehicles = po3_preDefinedEnemyVehicles;

// ==== PO3 Loadout Classes ================================================================================
po3_preDefinedClassLoadouts = call compileFinal preprocessFileLineNumbers "po3\configs\po3_preDefinedGearLoadouts_A3_NATO.sqf";

// ==== PO3 Task Specific Entities (west/east/resistance) ==================================================
po3_target_officer_types = ["B_officer_F","O_officer_F","I_officer_F"];
po3_target_cache_types = ["B_supplyCrate_F","O_supplyCrate_F","I_supplyCrate_F"];
po3_target_tower_types = [ "Land_TTowerBig_2_F" , "Land_Communication_F" ];
po3_target_intel_types = ["Land_File1_F","Land_FilePhotos_F","Land_File2_F","Land_HandyCam_F","Land_Laptop_F","Land_Laptop_unfolded_F","Land_MobilePhone_smart_F","Land_SatellitePhone_F","Land_Photos_V2_F"];
po3_rescue_heliTypes = ["B_Heli_Attack_01_F","I_Heli_Transport_02_F","B_Heli_Light_01_F","B_Heli_Transport_01_F","B_Heli_Transport_01_camo_F","B_Heli_Light_01_armed_F"];
