if(!mpsfSRV) exitWith {};

_hc = call mpsf_HLC_get;

if( typeName _hc == "ARRAY" ) then {
	mpsf_HLC_pubVar_spawn_ary = [_hc,_this,random 999];
	(_hc select 0) publicVariableClient "mpsf_HLC_pubVar_spawn_ary";

	["Object ObjectSpawner",format["Server Detected HLC, Sending %1 to HLC for creation",_this] ] call mpsf_fnc_log;

	waitUntil { !isNil "mpsf_SRV_HLC_grp_recieved" };

	_return = mpsf_SRV_HLC_grp_recieved;
	mpsf_SRV_HLC_grp_recieved = nil;

	["Object ObjectSpawner",format["Server Detected HLC has created %1",_return] ] call mpsf_fnc_log;

	_return;
}else{
	_return = _this call mpsf_fnc_objectsSpawner;

	["Object ObjectSpawner",format["Server created %1",_return] ] call mpsf_fnc_log;

	_return;
};