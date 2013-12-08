class po3_param_missions_title {
	title = "====== PO3 Mission Options ======";
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};
	class param_po3_missionhour {
		title = "Mission Hour";
		values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
		default=12;
		texts[]={"0000H","0100H","0200H","0300H","0400H","0500H","0600H","0700H","0800H","0900H","1000H","1100H","1200H","1300H","1400H","1500H","1600H","1700H","1800H","1900H","2000H","2100H","2200H","2300H"};
		code = "po3_param_missionhour = %1;";
	};
	class param_po3_missiontype {
		title = "Mission Type";
		values[]={0/*,1*/};
		texts[]={"Task Based"/*,"Campaign Based"*/};
		default=0;
		code = "po3_param_missiontype = %1;";
	};
	class param_po3_missioncount {
		title = "Number of Missions (Task Mode Only)";
		values[]={1,2,3,5,7,9,15,30,99};
		texts[]={"One","Two","Three","Five","Seven","Nine","Fifteen","Thirty","Unlimited"};
		default=3;
		code = "po3_param_missioncount = if(%1 < 99)then{%1}else{-1};";
	};
	class param_po3_missionskill {
		title = "Mission Difficulty";
		values[]={1,2,3};
		texts[]={$STR_MPSF_TEXT_LOW,$STR_MPSF_TEXT_MED,$STR_MPSF_TEXT_HIGH};
		default=1;
		code = "po3_param_missionskill = (%1/3);";
	};
/*	class param_po3_player_deathcount {
		title = "Task Casualty Limitation";
		values[]={1,6,15,30,99};
		texts[]={"No Casualties","Light Casualties","Medium Casualties","Heavy Casualties","Death is Everywhere"};
		default=6;
		code = "po3_param_player_deathcount = if(%1 < 99)then{%1}else{-1};";
	};
*/
class po3_param_ambient_title {
	title = "====== PO3 Ambient Options ======";
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};
	class param_po3_ambientair {
		title = "Ambient Air Patrols";
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_OFF,$STR_MPSF_TEXT_ON};
		default=0;
		code = "po3_param_ambientpatrolair = if(%1 > 0)then{true}else{false};";
	};
	class param_po3_ambientgnd {
		title = "Ambient Ground Patrols";
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_OFF,$STR_MPSF_TEXT_ON};
		default=0;
		code = "po3_param_ambientpatrolgnd = if(%1 > 0)then{true}else{false};";
	};
/*	class param_po3_ambientied {
		title = "Ambient IEDs";
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_OFF,$STR_MPSF_TEXT_ON};
		default=0;
		code = "po3_param_ambientIEDs = if(%1 > 0)then{true}else{false};";
	};
*/