// =========================================================================================================
// !!  DO NOT MODIFY THIS FILE  !!
// =========================================================================================================

class mpsf_param_AI_title {
	title = $STR_MPSF_PTITLE_AIOPTIONS;
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};
	class param_mpsf_ai_skill {
		title = $STR_MPSF_PARAM_SETAISKILL;
		values[]={1,2,3,4};
		texts[]={$STR_MPSF_TEXT_LOW,$STR_MPSF_TEXT_MED,$STR_MPSF_TEXT_HIGH,$STR_MPSF_TEXT_ULTRA};
		default=1;
		code = "mpsf_param_ai_skill = 0.7 + log((%1)/4)";
	};
	class param_mpsf_ai_Tkill {
		title = $STR_MPSF_PARAM_SETAITKILL;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=1;
		code = "mpsf_param_ai_easyKill = if(%1 > 0)then{true}else{false};";
	};
#ifdef PLAYER_FIREDETECTOR_ENABLED
	class param_mpsf_baseProtection {
		title = $STR_MPSF_PARAM_AIBASEPROTECT;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=1;
		code = "mpsf_param_baseProtection = if(%1 > 0)then{true}else{false};";
	};
#endif

class mpsf_param_injury_title {
	title = $STR_MPSF_PTITLE_INJURY;
	values[]= {0};
	texts[]= {" "};
	default = 0;
#ifdef PLAYER_INJURY_USE_ACEWOUNDS
	code = "ace_sys_wounds_ai_movement_bloodloss=true;ace_sys_wounds_player_movement_bloodloss=true;ace_sys_wounds_auto_assist=true;ace_sys_wounds_auto_assist_any=true;";
#else
	code = "";
#endif
};

#ifdef PLAYER_INJURY_USE_ACEWOUNDS
	class param_ace_wounds_prevtime {
		title = $STR_MPSF_PARAM_ACEWTTL;
		values[]={15,50,100,150,200,250,300,350,400,450,500};
		texts[]={"15","50","100","150","200","250","300","350","400","450","500"};
		default=150;
		code = "ace_wounds_prevtime = %1";
	};
	class param_ace_sys_wounds_leftdam {
		title = $STR_MPSF_PARAM_ACEW1STAIDDMG;
		values[]={0,5,1,15,20,25,30};
		texts[]={"0%","5%","10%","15%","20%","25%","30%"};
		default=5;
		code = "ace_sys_wounds_leftdam = (%1/100)";
	};
	class param_ace_sys_wounds_withSpect {
		title = $STR_MPSF_PARAM_ACEWUNCONSPECT;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=0;
		code = "ace_sys_wounds_withSpect = if(%1 > 0)then{true}else{false};";
	};
	class param_ace_sys_wounds_no_rpunish {
		title = $STR_MPSF_PARAM_ACEWPUNISH;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=0;
		code = "ace_sys_wounds_no_rpunish = if(%1 > 0)then{true}else{false};";
	};
	class param_ace_sys_wounds_no_medical_vehicles {
		title = $STR_MPSF_PARAM_ACEWMOBMEDICVEH;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=0;
		code = "ace_sys_wounds_no_medical_vehicles = if(%1 > 0)then{true}else{false};";
	};
	class param_ace_sys_wounds_all_medics {
		title = $STR_MPSF_PARAM_ACEWALLMEDICS;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=0;
		code = "ace_sys_wounds_all_medics = if(%1 > 0)then{true}else{false};";
	};
	class param_ace_sys_wounds_no_medical_gear {
		title = $STR_MPSF_PARAM_ACEWNOMEDGEAR;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=0;
		code = "ace_sys_wounds_no_medical_gear = if(%1 > 0)then{true}else{false};";
	};
#else
	class param_mpsf_injury_factor {
		title = $STR_MPSF_PARAM_INJURYTOLERANCE;
		values[]={1,2,4,6,8};
		texts[]={$STR_MPSF_TEXT_NONE,$STR_MPSF_TEXT_LOW,$STR_MPSF_TEXT_MED,$STR_MPSF_TEXT_HIGH,$STR_MPSF_TEXT_VHIGH};
		default=4;
		code = "mpsf_param_injury_factor = %1";
	};
	class param_mpsf_injury_down {
		title = $STR_MPSF_PARAM_INJURYDOWN;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=1;
		code = "mpsf_param_injury_down = if(%1 > 0)then{true}else{false};";
	};
#endif

#ifdef PLAYER_RESPAWN_AVAILABLE
	class mpsf_param_respawn_title {
		title = $STR_MPSF_PTITLE_RESPAWN;
		values[]= {0};
		texts[]= {$STR_MPSF_TEXT_ENABLED};
		default = 0;
		code = "";
	};
	class param_mpsf_respawn_playertime {
		title = $STR_MPSF_PARAM_RESPAWNTIME;
		values[]={10,20,30,40,50,60,70,90,120,300};
		texts[]={"10","20","30","40","50","60","70","90","120","300"};
		default=30;
		code = "mpsf_param_respawn_playertime = %1;";
	};
#else
	class mpsf_param_respawn_title {
		title = $STR_MPSF_PTITLE_RESPAWN;
		values[]= {0};
		texts[]= {$STR_MPSF_TEXT_DISABLED};
		default = 0;
		code = "mpsf_param_respawn_halo_allow = false; mpsf_param_respawn_deathcount = 0; mpsf_param_respawn_rallypoint_allow = false; mpsf_param_respawn_playertime = 10;";
	};
	#undef PLAYER_RESPAWN_DEATHCOUNT_OPTION
	#undef PLAYER_RESPAWN_SECUREZONE_OPTION
	#undef PLAYER_RESPAWN_BY_HALO_OPTION
	#undef PLAYER_RESPAWN_RALLYPOINTS_OPTION
#endif
#ifdef PLAYER_RESPAWN_RALLYPOINTS_OPTION
	class param_mpsf_respawn_rallypoint {
		title = $STR_MPSF_PARAM_RESPAWNRALLY;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=1;
		code = "mpsf_param_respawn_rallypoint_allow = if(%1 > 0)then{true}else{false};";
	};
#endif
#ifdef PLAYER_RESPAWN_BY_HALO_OPTION
	class param_mpsf_respawn_halo_allow {
		title = $STR_MPSF_PARAM_RESPAWNHALO;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=1;
		code = "mpsf_param_respawn_halo_allow = if(%1 > 0)then{true}else{false};";
	};
	class param_mpsf_respawn_halo_time {
		title = $STR_MPSF_PARAM_RESPAWNHALOTIME;
		values[]={0,60,300,600,900,1200,1800,3600,7200,86400};
		texts[]={"None","1min","5mins","10mins","15mins","20mins","30mins","60mins","120mins","24hrs"};
		default=60;
		code = "mpsf_param_respawn_halo_time = %1;";
	};
#endif
#ifdef PLAYER_RESPAWN_DEATHCOUNT_OPTION
	class param_mpsf_respawn_deathcount {
		title = $STR_MPSF_PARAM_RESPAWNLIVES;
		values[]={0,1,2,3,5,7,9,25,99};
		texts[]={$STR_MPSF_TEXT_NONE,"One","Two","Three","Five","Seven","Nine","Many","Unlimited"};
		default=99;
		code = "mpsf_param_respawn_deathcount = if(%1 < 99)then{%1}else{-1};";
	};
#endif
#ifdef PLAYER_RESPAWN_SECUREZONE_OPTION
	class param_mpsf_respawn_securezone {
		title = $STR_MPSF_PARAM_SECUREZONE;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=0;
		code = "mpsf_param_respawn_securezone = if(%1 > 0)then{true}else{false};";
	};
#endif

class mpsf_param_gameplay_title {
	title = $STR_MPSF_PTITLE_GAMEOPTIONS;
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};

	class param_mpsf_VASammobox {
		title = "Enable VAS Ammobox";
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_OFF,$STR_MPSF_TEXT_ON};
		default=1;
		code = "if(%1 > 0)then{ mpsf_ammobox_vas_enabled = true; }else{ mpsf_ammobox_vas_enabled = false; };";
	};
	class param_mpsf_ingameradio {
		title = $STR_MPSF_PARAM_GAMERADIO;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_OFF,$STR_MPSF_TEXT_ON};
		default=1;
		code = "if(%1 > 0)then{ enableRadio true; 0 fadeRadio 0; enableSentences true; }else{ 0 fadeRadio 0; enableRadio false; enableSentences false; };";
	};
#ifdef PLAYER_MAP_GROUP_MARKERS_ENABLED
	class param_mpsf_grpmark_icons {
		title = $STR_MPSF_PARAM_GRPMARK_GRP;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=1;
		code = "mpsf_param_grpmark_allow = if(%1 > 0)then{true}else{false};";
	};

	class param_mpsf_grpmark_squadicons {
		title = $STR_MPSF_PARAM_GRPMARK_SQD;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=1;
		code = "mpsf_param_grpmark_squad_allow = if(%1 > 0)then{true}else{false};";
	};
#endif
	class param_mpsf_removevehiclewrecks {
		title = $STR_MPSF_PARAM_WRECKSVEH;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_OFF,$STR_MPSF_TEXT_ON};
		default=1;
		code = "mpsf_param_removeVehicleWrecks = if(%1 > 0)then{true}else{false};";
	};

	class param_mpsf_removevehiclebodies {
		title = $STR_MPSF_PARAM_WRECKSBODY;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_OFF,$STR_MPSF_TEXT_ON};
		default=1;
		code = "mpsf_param_removevehiclebodies = if(%1 > 0)then{true}else{false};";
	};

class mpsf_param_playergame_title {
	title = $STR_MPSF_PTITLE_PLAYROPTIONS;
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};
	class param_mpsf_player_fatigue {
		title = $STR_MPSF_PARAM_PLAYRFATIGUE;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_DISABLED,$STR_MPSF_TEXT_ENABLED};
		default=1;
		code = "mpsf_param_player_fatigue = if(%1 > 0)then{true}else{false};";
	};
#ifdef PLAYER_HUD_3DHUD_ENABLED
	class param_mpsf_hud_worldtoscreen {
		title = $STR_MPSF_PARAM_HUD3DWORLD;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_ALLOW,$STR_MPSF_TEXT_FORCEOFF};
		default=0;
		code = "mpsf_param_hud_worldtoscreen = %1";
	};
#endif
#ifdef PLAYER_HUD_SQUADLIST_ENABLED
	class param_mpsf_hud_squadlist {
		title = $STR_MPSF_PARAM_HUDGLASSES;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_ALLOW,$STR_MPSF_TEXT_FORCEOFF};
		default=1;
		code = "mpsf_param_hud_requireGlasses = if(%1 > 0)then{true}else{false};";
	};
#endif
#ifdef PLAYER_HUD_CHANGE_GRASS_ENABLED
	class param_mpsf_hud_grassview {
		title = $STR_MPSF_PARAM_HUDGRASS;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_ALLOW,$STR_MPSF_TEXT_FORCEOFF};
		default=0;
		code = "mpsf_param_hud_grassview = %1";
	};
#endif
#ifdef PLAYER_SYS_3RD_PERSON_OPTION
	class param_mpsf_camera_3dvwalker {
		title = $STR_MPSF_PARAM_3DVWALKER;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=0;
		code = "mpsf_param_camera_restrict_3dvwalker = if(%1 > 0)then{true}else{false};";
	};
	class param_mpsf_camera_3dvdriver {
		title = $STR_MPSF_PARAM_3DVDRIVER;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=0;
		code = "mpsf_param_camera_restrict_3dvdriver = if(%1 > 0)then{true}else{false};";
	};
	class param_mpsf_camera_3dvcrewman {
		title = $STR_MPSF_PARAM_3DVCREWMN;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=0;
		code = "mpsf_param_camera_restrict_3dvcrewmn = if(%1 > 0)then{true}else{false};";
	};
#endif

class mpsf_param_ambient_title {
	title = $STR_MPSF_PTITLE_AMBIENT;
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};
#ifdef DYNAMIC_WEATHER_ENABLED
	class param_mpsf_ambient_weather {
		title = $STR_MPSF_PARAM_AMBWEATHER;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=1;
		code = "mpsf_param_ambient_weather_enable = if(%1 > 0)then{true}else{false};";
	};
#endif
/*	class param_mpsf_ambient_civs {
		title = $STR_MPSF_PARAM_AMBCIVIS;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=0;
		code = "mpsf_param_ambient_civs_enable = if(%1 > 0)then{true}else{false};";
	};
	class param_mpsf_ambient_traffic {
		title = $STR_MPSF_PARAM_AMBVEHICLE;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=0;
		code = "mpsf_param_ambient_civtraffic_enable = if(%1 > 0)then{true}else{false};";
	};
	class param_mpsf_ambient_gaia {
		title = $STR_MPSF_PARAM_AMBGAIA;
		values[]={0,1};
		texts[]={$STR_MPSF_TEXT_NO,$STR_MPSF_TEXT_YES};
		default=0;
		code = "mpsf_param_ambient_gaia_enable = if(%1 > 0)then{true}else{false};";
	};
*/