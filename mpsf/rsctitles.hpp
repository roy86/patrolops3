// =========================================================================================================
// !!  DO NOT MODIFY THIS FILE  !!
// =========================================================================================================

class mpsf_ProgressBar {
	idd = -1;
	movingEnable = 0;
	objects[] = {};
	duration = 1e+011;
	name = "mpsf_ProgressBar";
	onload = "_this call mpsf_fnc_progressBar_init;";

	class controlsBackground {
		class mpsf_progressbar_background : 86RText {
			idc = 0;
			x = "0.298906 * safezoneW + safezoneX";
			y = "0.082 * safezoneH + safezoneY";
			w = "0.407344 * safezoneW";
			h = "0.011 * safezoneH";
			colorBackground[] = {0,0,0,0.7};
		};
	};
	class controls {
		class mpsf_progressbar_foreground : 86RText {
			colorBackground[] = {GUI_BCG_RGB_R, GUI_BCG_RGB_G, GUI_BCG_RGB_B, GUI_BCG_RGB_A};
			idc = 1;
			x = "0.298906 * safezoneW + safezoneX";
			y = "0.082 * safezoneH + safezoneY";
			w = "0.001 * safezoneW";
			h = "0.011 * safezoneH";
		};
		class mpsf_progressbar_text : 86RStructuredText {
			idc = 2;
			colorBackground[] = {0,0,0,0};
			x = "0.298906 * safezoneW + safezoneX";
			y = "0.093 * safezoneH + safezoneY";
			w = "0.407344 * safezoneW";
			h = "0.022 * safezoneH";
			text = "Progress:";
			class Attributes {
				align = "left";
				font = GUI_FONT_MONO;
				shadow = 1;
			};
		};
	};
};

class mpsf_screentext_sitrep {
	idd = -1;
	movingEnable = 0;
	duration = 1e+011;
	fadein = 0;
	fadeout = 0;
	name = "mpsf_screentext_sitrep_ID";
	onload = "_this call mpsf_fnc_screentext_init;";

	class controls {
		class sitrep_0 : 86RStructuredText {
			idc = MPSFCNTRL_06;
			text = "";
			x = (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX);
			y = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY);
			w = 1;
			h = 1;
		};
		class sitrep_1: 86RStructuredText {
			idc = MPSFCNTRL_07;
			text = "";
			size = "( ( ( ( (safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7);";
			x = 0.35;
			y = 0.60;
			w = 0.30;
			h = "( ( ( ( (safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7);";
			class Attributes {
				align = "Center";
				font = GUI_FONT_MONO;
				shadow = 1;
			};
		};
	};
};

class mpsf_hud_crewlist {
	idd = -1;
	movingEnable = 0;
	duration = 1e+011;
	fadein = 0;
	fadeout = 0;
	name="mpsf_hud_crewlist";
	onLoad = "_this call mpsf_fnc_crewlist_init";

	class controlsBackground {
		class mpsf_hud_crewlist_bg : 86RText {
			idc = MPSFCNTRL_08;
			x = "0.84125 * safezoneW + safezoneX";
			y = "0.14 * safezoneH + safezoneY";
			w = "0.1625 * safezoneW";
			h = "0.63 * safezoneH";
			colorBackground[] = {0,0,0,0};
		};
	};

	class controls {
		class mpsf_hud_crewlist_text : 86RStructuredText {
			idc = MPSFCNTRL_09;
			style = ST_RIGHT;
			x = "0.84125 * safezoneW + safezoneX";
			y = "0.14 * safezoneH + safezoneY";
			w = "0.1625 * safezoneW";
			h = "0.63 * safezoneH";
			size = "( ( ( ( (safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7);";
			text ="";
			class Attributes {
				align = "right";
				font = GUI_FONT_MONO;
				shadow = 0;
			};
		};
	};
};

class mpsf_HcamDialog {
	idd = -1;
	onLoad = "_this call mpsf_fnc_helmetCam_init";
	movingEnable = 0;
	enableSimulation = 1;
	enableDisplay = 1;
	duration = 1e+011;
	fadein = 0;
	fadeout = 0;
	class controls { 
		class RscHcamBack : 86RPicture {
			idc = 2;
			type = 0;
			style = 48;
			text = "mpsf\data\helmetcam_back.paa";
			x = 0.78 * safezoneW + safezoneX;
			y = 0.67 * safezoneH + safezoneY;
			w = 0.22 * safezoneW;
			h = 0.17 * safezoneH;
		};
		class RscHcamCam : 86RPicture {
			idc = 0;
			type = 0;
			style = 48;
			text = "";
			x = 0.80 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.18 * safezoneW;
			h = 0.15 * safezoneH;
		};
		class HcamText : 86Rtext {
			idc = 1;
			type  = 0;
			style = 0x01;
			x = 0.80 * safezoneW + safezoneX;
			y = 0.81 * safezoneH + safezoneY;
			w = 0.18 * safezoneW;
			h = 0.02 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1, 1, 1, 0.2};
			sizeEx = 0.02;
			text="";
		};
		class RscHcamFront : 86RPicture {
			idc = 3;
			type = 0;
			style = 48;
			text = "mpsf\data\helmetcam_front.paa";
			x = 0.80 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.18 * safezoneW;
			h = 0.15 * safezoneH;
		};
	};
};

#define MPSF_LIFTRADAR_X "(SafeZoneX+SafeZoneW/2) - (5.6 * (((safezoneW / safezoneH) min 1.2) / 40))/2"
#define MPSF_LIFTRADAR_Y "( SafeZoneY+SafeZoneH ) - (5.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))*3"

class mpsf_LiftChopper_HUD {
	idd = MPSFCNTRL_14;
   	movingEnable=0;
	duration = 1e+011;
   	name = "mpsf_LiftChopper_HUD";
	onLoad = "_this call mpsf_fnc_liftRadar_init";
   	controlsBackground[] = {};
   	objects[] = {};

   	class controls {
		class mpsf_RADAR_bg : 86RPicture {
			idc = 0;
			text = "A3\Ui_f\data\igui\cfg\radar\radarbackground_ca.paa";
			colorText[] = {GUI_BCG_RGB_R, GUI_BCG_RGB_G, GUI_BCG_RGB_B, GUI_BCG_RGB_A};
			x = MPSF_LIFTRADAR_X;
			y = MPSF_LIFTRADAR_Y;
			w = "5.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "5.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

		};
		class mpsf_RADAR : 86RPicture {
			idc = 1;
			text = "A3\Ui_f\data\igui\cfg\radar\radar_ca.paa";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
			x = MPSF_LIFTRADAR_X;
			y = MPSF_LIFTRADAR_Y;
			w = "5.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "5.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class mpsf_RADAR_Target : 86RPicture {
			idc = 2;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			text = "A3\Ui_f\data\IGUI\Cfg\Cursors\board_ca.paa";
			x = MPSF_LIFTRADAR_X;
			y = MPSF_LIFTRADAR_Y;
			w = 0.03;
			h = 0.04;
		};
	};   
 };
