/*
	Author: Eightysix

	Description:
	Create Lightning Strike : Global Broadcast
*/
private["_group"];

_group = _this select 1;
if !([_group,player] call mpsf_fnc_isTeamLeader || [player] call mpsf_fnc_isAdministrator) exitWith { [true,"HINTC","You are not authorised to change the team leader"] call mpsf_fnc_hint };

mpsf_pVAR_changeGroupLeader = _this; publicVariable "mpsf_pVAR_changeGroupLeader";

if(mpsfCLI) then {
	_this call mpsf_fnc_setAsLeader;
};