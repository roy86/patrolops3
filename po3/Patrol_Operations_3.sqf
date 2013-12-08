po3_path = "po3\";
#include "PO3cfg.hpp"
if(isNil "po3_param_missionskill") then { po3_param_missionskill = (1/3) };
WaitUntil{!isNil "mpsf_core_init"};
[po3_param_missionhour,0] spawn mpsf_fnc_setTime;
if (mpsf_mod_acre_enabled) then {
	if(mpsfSRV) then {
		acreTower_1 = "ACRE_OE_303" createVehicle ("acreTowerLoc_1" call mpsf_fnc_getPos); publicVariable "acreTower_1";
		acreTower_2 = "ACRE_OE_303" createVehicle ("acreTowerLoc_2" call mpsf_fnc_getPos); publicVariable "acreTower_2";
		acreTower_3 = "ACRE_OE_303" createVehicle ("acreTowerLoc_3" call mpsf_fnc_getPos); publicVariable "acreTower_3";
		acreTower_4 = "ACRE_OE_303" createVehicle ("acreTowerLoc_4" call mpsf_fnc_getPos); publicVariable "acreTower_4";
		acreTower_5 = "ACRE_OE_303" createVehicle ("acreTowerLoc_5" call mpsf_fnc_getPos); publicVariable "acreTower_5";
//		if!(mpsf_ammobox_vas_enabled) then {
			{
				_x addItemCargoGlobal ["ACRE_PRC148",100];
				_x addItemCargoGlobal ["ACRE_PRC148_UHF",100];
				_x addItemCargoGlobal ["ACRE_PRC343",100];
				_x addItemCargoGlobal ["ACRE_PRC117F",100];
			}foreach [box1,box2,box3];
//		};
	};
	if(mpsfCLI) then {
		[] spawn {
			waitUntil{!isNil "acreTower_1" && !isNil "acreTower_2" && !isNil "acreTower_3" && !isNil "acreTower_4" && !isNil "acreTower_5"};
			[[getPosASL acreTower_1 select 0, getPosASL acreTower_1 select 1, (getPosASL acreTower_1 select 2) + 2500], 36.625, 342.675, 20000] spawn acre_api_fnc_createRxmtStatic;
			[[getPosASL acreTower_2 select 0, getPosASL acreTower_2 select 1, (getPosASL acreTower_2 select 2) + 2500], 36.625, 342.675, 20000] spawn acre_api_fnc_createRxmtStatic;
			[[getPosASL acreTower_3 select 0, getPosASL acreTower_3 select 1, (getPosASL acreTower_3 select 2) + 2500], 36.625, 342.675, 20000] spawn acre_api_fnc_createRxmtStatic;
			[[getPosASL acreTower_4 select 0, getPosASL acreTower_4 select 1, (getPosASL acreTower_4 select 2) + 2500], 36.625, 342.675, 20000] spawn acre_api_fnc_createRxmtStatic;
			[[getPosASL acreTower_5 select 0, getPosASL acreTower_5 select 1, (getPosASL acreTower_5 select 2) + 2500], 36.625, 342.675, 20000] spawn acre_api_fnc_createRxmtStatic;
		};
	};
};
WaitUntil{!isNil "mpsf_core_init"};
if(mpsfSRV) then {
	po3_worldsize = call mpsf_fnc_worldsize;
	[] spawn {
		waitUntil { !isNil "po3_pos_allowed" };
		if(po3_param_ambientpatrolair) then { [] spawn po3_fnc_ambientAirPatrols; };
		if(po3_param_ambientpatrolgnd) then { [] spawn po3_fnc_ambientGroundPatrols; };
	//	if(po3_param_ambientIEDs) then { [] call po3_fnc_ambientIEDs; };
	};
	[] call po3_fnc_registerLocations;
};
if(mpsfCLI) then {
	waitUntil {!isNull player};

	switch (true) do {
		case ( leader(player) == player ) : { player setVariable ["mpsf_VAR_roleAttribute","Leader",true] };
//		case ( getNumber(configFile >> "CfgVehicles" >> typeOf player >> "candeactivatemines" ) == 1) : { player setVariable ["mpsf_VAR_roleAttribute","Grenadier",true] };
		case ( getText(configFile >> "CfgWeapons" >> primaryWeapon(player) >> "UIPicture" ) == "\a3\weapons_f\data\ui\icon_mg_ca.paa") : { player setVariable ["mpsf_VAR_roleAttribute","AutoRifleman",true] };
		case ( getText(configFile >> "CfgWeapons" >> secondaryWeapon(player) >> "UIPicture" ) == "\a3\weapons_f\data\ui\icon_at_ca.paa") : { player setVariable ["mpsf_VAR_roleAttribute","MissileSpecialist",true] };
		case ( getNumber(configFile >> "CfgVehicles" >> typeOf(player) >> "attendant") == 1 ) : { player setVariable ["mpsf_VAR_roleAttribute","Medic",true] };
		case ( (typeOf player) IN ["O_soldier_UAV_F","B_soldier_UAV_F","I_soldier_UAV_F"] ) : { player setVariable ["mpsf_VAR_roleAttribute","UASOperator",true] };
		case ( getNumber(configFile >> "CfgVehicles" >> typeOf(player) >> "engineer") == 1 );
		case ( (typeOf player) IN ["O_crew_F","B_crew_F","I_crew_F"] ) : { player setVariable ["mpsf_VAR_roleAttribute","Crewman",true] };
		case ( (typeOf player) IN ["O_helicrew_F","O_Helipilot_F","O_Pilot_F","B_helicrew_F","B_Helipilot_F","B_Pilot_F","I_helicrew_F","I_Helipilot_F","I_Pilot_F"] ) : { player setVariable ["mpsf_VAR_roleAttribute","Pilot",true] };
		default { player setVariable ["mpsf_VAR_roleAttribute","Rifleman",true] };
	};
	[player] spawn po3_fnc_vehicleRestrict;
};
[] call po3_fnc_protector;
po3_core_init = true;