#define MPSF_BUTTON_ACTIVATE(CTRL) \
	CTRL ctrlSetFade 0; \
	CTRL ctrlEnable true; \
	CTRL ctrlCommit 0.2; \

#define MPSF_BUTTON_DEACTIVATE(CTRL) \
	CTRL ctrlEnable false; \
	CTRL ctrlCommit 0; \


mpsf_fnc_crewlistInit = {
	uiNamespace setVariable ["mpsf_hud_crewlist", _this select 0];
	uiNamespace setVariable ["mpsf_hud_crewlistBG", (_this select 0) displayCtrl 0];
	uiNamespace setVariable ["mpsf_hud_crewlistText", (_this select 0) displayCtrl 1];
};

mpsf_fnc_crewlist_init = {
	uiNamespace setVariable ['mpsf_hud_crewlist', _this select 0];
};

mpsf_fnc_helmetCam_init = {
	uiNamespace setVariable ["hcam_ui_disp", (_this select 0)];
	uiNamespace setVariable ["hcam_ctrl_pip", (_this select 0) displayCtrl 0];
	uiNamespace setVariable ["hcam_ctrl_title", (_this select 0) displayCtrl 1];
	uiNamespace setVariable ["hcam_ctrl_back", (_this select 0) displayCtrl 2];
	uiNamespace setVariable ["hcam_ctrl_front", (_this select 0) displayCtrl 3];
};

mpsf_fnc_liftRadar_init = {
	uiNamespace setVariable ["mpsf_liftChopper_display",	(_this select 0) ];
	uiNamespace setVariable ["mpsf_liftChopper_radarBG",	(_this select 0) displayCtrl 0];
	uiNamespace setVariable ["mpsf_liftChopper_radar",	(_this select 0) displayCtrl 1];
	uiNamespace setVariable ["mpsf_liftChopper_target",	(_this select 0) displayCtrl 2];
};

mpsf_fnc_progressBar_init = {
	uinamespace setvariable ['mpsf_ProgressBar_gui',(_this select 0)];
	uinamespace setvariable ['mpsf_ProgressBar_gui_bg',(_this select 0) displayCtrl 0];
	uinamespace setvariable ['mpsf_ProgressBar_gui_fg',(_this select 0) displayCtrl 1];
	uinamespace setvariable ['mpsf_ProgressBar_gui_txt',(_this select 0) displayCtrl 2];
};

mpsf_fnc_screentext_init = {
	uinamespace setvariable ['mpsf_screentext_sitrep_text',_this select 0];
};

mpsf_fnc_squadmod_init = {
	uiNamespace setVariable ['mpsf_hud_squadmod_gui', _this select 0];
	uinamespace setvariable ['mpsf_hud_squadmod_tx1', (_this select 0) displayCtrl 19]; // Players
	uinamespace setvariable ['mpsf_hud_squadmod_lb1', (_this select 0) displayCtrl 20]; // Player List
	uinamespace setvariable ['mpsf_hud_squadmod_tx2', (_this select 0) displayCtrl 21]; // Groups
	uinamespace setvariable ['mpsf_hud_squadmod_lb2', (_this select 0) displayCtrl 22]; // Group List
	uinamespace setvariable ['mpsf_hud_squadmod_ed1', (_this select 0) displayCtrl 23]; // Edit Squad Name
	uinamespace setvariable ['mpsf_hud_squadmod_b04', (_this select 0) displayCtrl 24]; // Button Edit Squad
	uinamespace setvariable ['mpsf_hud_squadmod_b03', (_this select 0) displayCtrl 25]; // Button New Group
	uinamespace setvariable ['mpsf_hud_squadmod_b02', (_this select 0) displayCtrl 26]; // Button Join Group
	uinamespace setvariable ['mpsf_hud_squadmod_b01', (_this select 0) displayCtrl 27]; // Button Make Leader
	uinamespace setvariable ['mpsf_hud_squadmod_C01', (_this select 0) displayCtrl 28]; // Combo Assign Role
	uinamespace setvariable ['mpsf_hud_squadmod_b08', (_this select 0) displayCtrl 29]; // Button Assign Role
	uinamespace setvariable ['mpsf_hud_squadmod_b05', (_this select 0) displayCtrl 30]; // Button Request UAV
	uinamespace setvariable ['mpsf_hud_squadmod_b06', (_this select 0) displayCtrl 31]; // Button Request UGV
	uinamespace setvariable ['mpsf_hud_squadmod_b09', (_this select 0) displayCtrl 32]; // Button Skip Mission
	uinamespace setvariable ['mpsf_hud_squadmod_b07', (_this select 0) displayCtrl 33]; // Button Close

	mpsf_sqdmod_VAR_selectedUnit = objnull;
	mpsf_sqdmod_VAR_selectedGroup = grpnull;

	mpsf_fnc_sqdmod_updateGUI = {
		{ MPSF_BUTTON_DEACTIVATE(uinamespace getvariable _x); }forEach ['mpsf_hud_squadmod_b01','mpsf_hud_squadmod_b02','mpsf_hud_squadmod_b03','mpsf_hud_squadmod_b04','mpsf_hud_squadmod_b05','mpsf_hud_squadmod_b06','mpsf_hud_squadmod_b07','mpsf_hud_squadmod_b08','mpsf_hud_squadmod_b09','mpsf_hud_squadmod_C01'];

		switch (true) do {
			 case ( [player] call mpsf_fnc_isAdministrator ) : { { MPSF_BUTTON_ACTIVATE(uinamespace getvariable _x); }forEach ['mpsf_hud_squadmod_b01','mpsf_hud_squadmod_b02','mpsf_hud_squadmod_b03','mpsf_hud_squadmod_b04','mpsf_hud_squadmod_b05','mpsf_hud_squadmod_b06','mpsf_hud_squadmod_b07','mpsf_hud_squadmod_b08','mpsf_hud_squadmod_b09','mpsf_hud_squadmod_C01']; };
			 case ( [group player,player] call mpsf_fnc_isTeamLeader ) : { { MPSF_BUTTON_ACTIVATE(uinamespace getvariable _x); }forEach ['mpsf_hud_squadmod_b01','mpsf_hud_squadmod_b02','mpsf_hud_squadmod_b04','mpsf_hud_squadmod_b07','mpsf_hud_squadmod_b08','mpsf_hud_squadmod_C01']; };
		};

		mpsf_sqdmod_VAR_unitList = [];
		{
			if (side _x == side player) then {
				mpsf_sqdmod_VAR_unitList set [count mpsf_sqdmod_VAR_unitList, _x];
				{
					mpsf_sqdmod_VAR_unitList set [count mpsf_sqdmod_VAR_unitList, _x];
				} foreach units _x;
			};
		} forEach allGroups;

		lbClear (uinamespace getvariable 'mpsf_hud_squadmod_C01');
		{
			_index= (uinamespace getvariable 'mpsf_hud_squadmod_C01') lbadd format["%1",_x select 0];
			(uinamespace getvariable 'mpsf_hud_squadmod_C01') lbSetValue [_index,_forEachIndex];
		}forEach mpsf_CfgLogistics_UnitLoadouts;

		lbClear (uinamespace getvariable 'mpsf_hud_squadmod_lb1');
		lbClear (uinamespace getvariable 'mpsf_hud_squadmod_lb2');
		{
			switch (typeName _x) do {
				case "GROUP" : {
					if( {isPlayer _X} count (units _x) > 0 || count (units _x) == 0 || [] call mpsf_fnc_isAdministrator) then {
						(uinamespace getvariable 'mpsf_hud_squadmod_lb1') lbadd (groupID _x);
						_index= (uinamespace getvariable 'mpsf_hud_squadmod_lb2') lbadd format["%1 - %2",groupID _x,(name leader _x)];
						(uinamespace getvariable 'mpsf_hud_squadmod_lb2') lbSetValue [_index,_forEachIndex];
					};
				};
				case "OBJECT" : {
					if( {isPlayer _X} count (units _x) > 0 || count (units _x) == 0 || [] call mpsf_fnc_isAdministrator) then {
						_icon = _x call mpsf_fnc_hud_getUnitIcon;
						(uinamespace getvariable 'mpsf_hud_squadmod_lb1') lbadd format[
							"%1%2",
							(name _x),
							switch (_x getVariable["mpsf_VAR_roleAttribute","Rifleman"]) do {
								case "Leader" :{ " (SQL)" };
								case "Rifleman" : { " (RFL)" };
								case "Grenadier" : { " (GRN)" };
								case "AutoRifleman" : { " (AR)" };
								case "MissileSpecialist" : { " (AT)" };
								case "Medic" : { " (MED)" };
								case "UASOperator" : { " (UAS)" };
								case "Crewman" : { " (CRW)" };
								case "Pilot" : { " (PLT)" };
								case "Recon" : { " (REC)" };
								case "Marksman" : { " (MRK)" };
								default { "" };
							}
						];
						(uinamespace getvariable 'mpsf_hud_squadmod_lb1') lbSetPicture [ (lbSize (uinamespace getvariable 'mpsf_hud_squadmod_lb1')) - 1, _icon];
					};
				};
			};
		} foreach mpsf_sqdmod_VAR_unitList;
	};

	[] call mpsf_fnc_sqdmodFunctions;

	[] call mpsf_fnc_sqdmod_updateGUI;
};

mpsf_fnc_world2Screen_toggle = {
	if( [player] call mpsf_fnc_hasARgear || !(mpsf_param_hud_requireGlasses) ) then {
		if(mpsf_hud_worldtoscreen_display) then {
			mpsf_hud_worldtoscreen_display = false;
			[true,"HINT",localize "STR_MPSF_DIALOG_GRAPHIC_3DDisabled"] call mpsf_fnc_hint;
		}else{
			mpsf_hud_worldtoscreen_display = true;
			[true,"HINT",localize "STR_MPSF_DIALOG_GRAPHIC_3DEnabled"] call mpsf_fnc_hint;
		};
	}else{
		mpsf_hud_worldtoscreen_display = false;
		[true,"HINT",localize "STR_MPSF_DIALOG_GRAPHIC_3DRequire"] call mpsf_fnc_hint;
	};
};

[] spawn mpsf_fnc_world2Screen;
//[] spawn mpsf_fnc_crewlist;
