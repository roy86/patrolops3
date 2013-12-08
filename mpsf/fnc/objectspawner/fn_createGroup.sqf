/*
	Author: Eightysix

	Description:
	Creates a Group of Units

	Syntax:
	[<position>,<side>,<type>,<radius>,<stance>,<strength>] spawn mpsf_fnc_createGroup

		position - ARRAY/OBJECT/STRING - the same requirements supplied to mpsf_fnc_getPos
		side	 - SIDE - the side the units will be created for (west/east/resistance)
		type	 - ARRAY/STRING - An array of unit types or a string referencing a PreConfigured unit array
		radius	 - Number - (OPTIONAL) The maximum radius from the position they will be spawned at.
		stance	 - STRING - (OPTIONAL) The stance of the group (Aware/Combat/Safe)
		strength - NUMBER - (OPTIONAL) The maximum units in that squad ( default is the count of the array of types)

	Returns: Group ID of units
*/
if(!mpsfSRV) exitWith {};

_hc = call mpsf_fnc_getHLCID;

if( typeName _hc == "ARRAY" ) then {
	mpsf_HLC_pubVar_spawn_inf = [_hc,_this,random 999];
	(_hc select 0) publicVariableClient "mpsf_HLC_pubVar_spawn_inf";

	["Infantry ObjectSpawner",format["Server Detected HLC, Sending %1 to HLC for creation",_this] ] call mpsf_fnc_log;

	waitUntil { !isNil "mpsf_SRV_HLC_grp_recieved" };

	_return = mpsf_SRV_HLC_grp_recieved;
	mpsf_SRV_HLC_grp_recieved = nil;

	["Infantry ObjectSpawner",format["Server Detected HLC has created %1",_return] ] call mpsf_fnc_log;

	_return;
}else{
	_return = _this call mpsf_fnc_squadSpawner;

	["Infantry ObjectSpawner",format["Server created %1",_return] ] call mpsf_fnc_log;

	_return;
};