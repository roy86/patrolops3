/*
	Author: Eightysix

	Description:
	
*/
if(!mpsfCLI) exitWith {};

if( player call mpsf_fnc_checkActionBusy ) exitWith {};

private["_pos","_dir","_position","_type","_rallypoint"];

[localize "STR_MPSF_RESPWN_RALLYPLACE"] call mpsf_fnc_hint;
true call mpsf_fnc_setActionBusy;

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 8;
if!(alive player) exitwith {}; 

_pos = player call mpsf_fnc_getPos;
_dir = direction player;
_position = [  (_pos select 0) + (sin _dir * 2), (_pos select 1) + (cos _dir * 2), 0];

_type = if(mpsf_a3) then { if(playerside == west) then { "Land_TentDome_F"}else{ "Land_TentA_F" } }else{ "ACamp" };
_rallypoint = createVehicle [_type, _position, [], 0, "CAN_COLLIDE"];
_rallypoint setDir (_dir - 90);
_rallypoint setVariable ["mpsf_rallypoint",true,true];
_rallypoint setVariable ["mpsf_rallypoint_owner",name player,true];

player reveal _rallypoint;

[ "rally", _position ] call mpsf_fnc_addRespawnPosLocal;
false call mpsf_fnc_setActionBusy;

[true,"HINT","<t color='#ffc600'>Placed Rallypoint</t><br/><br/>You can recover this in the field or at the base flag"] call mpsf_fnc_hint;

mpsf_respawn_rallypoint_active = true;
waitUntil { sleep 1; !(_rallypoint getVariable ["mpsf_rallypoint",false]) || !(alive _rallypoint) };
mpsf_respawn_rallypoint_active = false;

[ "rally" ] call mpsf_fnc_removeRespawnPosLocal;
deleteVehicle _rallypoint;

[localize "STR_MPSF_RESPWN_RALLYREMVE"] call mpsf_fnc_hint;