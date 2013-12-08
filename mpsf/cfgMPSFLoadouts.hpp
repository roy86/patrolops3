/*
mpsf_CfgLogistics_UnitLoadouts = [
	["CLASS",
		[WEAPONS],
		[ADDITIONAL MAGS], // Weapon mags are retrieved automatically
		[ITEMS],
		[BACKPACKS]
	]
];
*/
mpsf_CfgLogistics_UnitLoadouts = [] call compile preprocessFileLineNumbers "po3\configs\po3_preDefinedGearLoadouts_A3_NATO.sqf";

mpsf_CfgLogistics_UnitLoadoutBlacklist = [
	 "optic_Nightstalker","optic_tws","optic_tws_mg","optic_NVS"
	,"G_Lady_Blue","G_Lady_Dark","G_Lady_Mirror","G_Lady_Red","G_Shades_Green"
	,"G_Spectacles","G_Spectacles_Tinted"
	,"G_Sport_Blackred","G_Sport_BlackWhite","G_Sport_Blackyellow","G_Sport_Checkered"
	,"G_Sport_Greenblack","G_Sport_Red","G_Squares","G_Squares_Tinted","None"
];