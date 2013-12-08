class po3_gear_dialog {
	idd = MPSFCNTRL_20;
	movingEnable = 0;
	enableSimulation = 1;
	enableDisplay = 1;
	onload = "_this spawn po3_fnc_gearUI;";

	class controlsBackground {
		class po3_loadout_bg0 : 86RText {
			idc = 0;
			x = 0.292719 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.15675 * safezoneW;
			h = 0.462 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
		};
		class po3_loadout_bg1 : 86RText {
			idc = 1;
			x = 0.29272 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.156749 * safezoneW;
			h = 0.3652 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
		};
		class po3_loadout_title : 86RStructuredText {
			idc = 2;
			text = "Inventory System";
			x = 0.292719 * safezoneW + safezoneX;
			y = 0.2184 * safezoneH + safezoneY;
			w = 0.15675 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {GUI_BCG_RGB_R, GUI_BCG_RGB_G, GUI_BCG_RGB_B, GUI_BCG_RGB_A};
		};
	};

	class controls {
		class po3_loadout_button1 : 86RButtonMenu {
			idc = 3;
			text = "Role"; //--- ToDo: Localize;
			onButtonClick = "[0] spawn po3_fnc_gearUI_loadScreen;";
			x = 0.292719 * safezoneW + safezoneX;
			y = 0.2448 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_button2 : 86RButtonMenu {
			idc = 4;
			text = "Uniform"; //--- ToDo: Localize;
			onButtonClick = "[1] spawn po3_fnc_gearUI_loadScreen;";
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.2448 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_button3 : 86RButtonMenu {
			idc = 5;
			text = "Gear"; //--- ToDo: Localize;
			onButtonClick = "[2] spawn po3_fnc_gearUI_loadScreen;";
			x = 0.397906 * safezoneW + safezoneX;
			y = 0.2448 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_button4 : 86RButtonMenu {
			idc = 6;
			text = "Save Loadout"; //--- ToDo: Localize;
			onButtonClick = "[player,true] call mpsf_fnc_getLoadout; [true,""HINT"",""Saved Loadout""] call mpsf_fnc_hint;";
			x = 0.292719 * safezoneW + safezoneX;
			y = 0.7332 * safezoneH + safezoneY;
			w = 0.15675 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_button5 : 86RButtonMenu {
			idc = 7;
			text = "Close"; //--- ToDo: Localize;
			onButtonClick = "closeDialog 0";
			x = 0.292719 * safezoneW + safezoneX;
			y = 0.7574 * safezoneH + safezoneY;
			w = 0.15675 * safezoneW;
			h = 0.022 * safezoneH;
		};


// =========================================================================================================
// Role TAB
// =========================================================================================================
		class po3_loadout_rolelist : 86RListbox {
			idc = 8;
			onLBSelChanged = "_this call po3_fnc_gearUI_RoleList_select;";
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.44 * safezoneH;
		};

// =========================================================================================================
// Uniform TAB
// =========================================================================================================
		class po3_loadout_text_u0 : 86RText {
			idc = 9;
			text = "Uniform"; //--- ToDo: Localize;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_combo_u0 : 86RCombo {
			idc = 10;
			onLBSelChanged = "[""uniform"",_this] call po3_fnc_gearUI_uniform_select;";
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_text_u1 : 86RText {
			idc = 11;
			text = "Vest"; //--- ToDo: Localize;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_combo_u1 : 86RCombo {
			idc = 12;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_text_u2 : 86RText {
			idc = 13;
			text = "Headgear"; //--- ToDo: Localize;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_combo_u2 : 86RCombo {
			idc = 14;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_text_u3 : 86RText {
			idc = 15;
			text = "Backpack"; //--- ToDo: Localize;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_combo_u3 : 86RCombo {
			idc = 16;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_text_u4 : 86RText {
			idc = 17;
			text = "Glasses"; //--- ToDo: Localize;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_combo_u4 : 86RCombo {
			idc = 18;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_button6 : 86RButtonMenu {
			idc = 19;
			text = "View Front"; //--- ToDo: Localize;
			x = 0.292719 * safezoneW + safezoneX;
			y = 0.6364 * safezoneH + safezoneY;
			w = 0.15675 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_button7 : 86RButtonMenu {
			idc = 20;
			text = "View Back"; //--- ToDo: Localize;
			x = 0.292718 * safezoneW + safezoneX;
			y = 0.6606 * safezoneH + safezoneY;
			w = 0.15675 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_button8 : 86RButtonMenu {
			idc = 21;
			text = "View Face"; //--- ToDo: Localize;
			x = 0.292718 * safezoneW + safezoneX;
			y = 0.6848 * safezoneH + safezoneY;
			w = 0.15675 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_button9 : 86RButtonMenu {
			idc = 22;
			text = "View Weapon"; //--- ToDo: Localize;
			x = 0.292718 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.15675 * safezoneW;
			h = 0.022 * safezoneH;
		};

// =========================================================================================================
// Gear TAB
// =========================================================================================================
		class po3_loadout_button10 : 86RButtonMenu {
			idc = 23;
			text = "Weapon"; //--- ToDo: Localize;
			onButtonClick = "[3] spawn po3_fnc_gearUI_loadScreen;";
			x = 0.292719 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_button11 : 86RButtonMenu {
			idc = 24;
			text = "Mags"; //--- ToDo: Localize;
			onButtonClick = "[4] spawn po3_fnc_gearUI_loadScreen;";
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_button12 : 86RButtonMenu {
			idc = 25;
			text = "Items"; //--- ToDo: Localize;
			onButtonClick = "[5] spawn po3_fnc_gearUI_loadScreen;";
			x = 0.397906 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class po3_loadout_gearlist : 86RListbox {
			idc = 26;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class po3_loadout_playergear : 86RListbox {
			idc = 27;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class po3_loadout_button13 : 86RButtonMenu {
			idc = 28;
			text = "Add to Loadout"; //--- ToDo: Localize;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {GUI_BCG_RGB_R, GUI_BCG_RGB_G, GUI_BCG_RGB_B, GUI_BCG_RGB_A};
		};
		class po3_loadout_button14 : 86RButtonMenu {
			idc = 29;
			text = "Remove From Loadout"; //--- ToDo: Localize;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {GUI_BCG_RGB_R, GUI_BCG_RGB_G, GUI_BCG_RGB_B, GUI_BCG_RGB_A};
		};
	};
};
