/*
	Author: Eightysix

	Description:

*/
if( player call mpsf_fnc_checkActionBusy ) exitWith {};

[player,"HINT",localize "STR_MPSF_RESPWN_RALLYREMVI"] call mpsf_fnc_hint;
true call mpsf_fnc_setActionBusy;

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 8;
if!(alive player) exitwith {};

false call mpsf_fnc_setActionBusy;

(_this select 0) setVariable ["mpsf_rallypoint",false,true];
(_this select 0) setDamage 1;
