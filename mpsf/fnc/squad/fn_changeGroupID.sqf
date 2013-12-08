/*
	Author: Eightysix

	Description:

*/
private["_group","_newName"];

_group = _this select 0;
_newName = _this select 1;

if ( !([_group,player] call mpsf_fnc_isTeamLeader) && !([player] call mpsf_fnc_isAdministrator) ) exitWith { [true,"HTINTC","You are not authorised to change the team name"] call mpsf_fnc_hint };

mpsf_pVAR_changeGroupID = [_group,_newName]; publicVariable "mpsf_pVAR_changeGroupID";

if(mpsfCLI) then {
	mpsf_pVAR_changeGroupID call mpsf_fnc_setGroupID;
};