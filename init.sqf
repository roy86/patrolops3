diag_log format ["###### %1 ######", missionName];
diag_log [diag_frameno, diag_ticktime, time, "Executing init.sqf"];
[] execVM "mpsf\init.sqf";
[] execVM "po3\Patrol_Operations_3.sqf";
if(!isDedicated) then { Receiving_finish = false; onPreloadFinished { Receiving_finish = true; onPreloadFinished {}; }; WaitUntil{ !(isNull player) && !isNil "mpsf_core_init" && Receiving_finish }; }else{ WaitUntil{!isNil "mpsf_core_init"}; };
if(!isDedicated && !mpsf_debug) then {
	playMusic "LeadTrack01a_F";
	0 fadeMusic 1;
	[5,""] spawn mpsf_fnc_camera_fadein;
	if!(mpsf_debug) then { [270,900,150] call po3_fnc_customIntro };
	[] spawn { sleep 20; 8 fadeMusic 0; };
};
[ ["PO3tasks"], "po3"] call mpsf_fnc_runTaskSequence;
[] call mpsf_fnc_outrosequence;
