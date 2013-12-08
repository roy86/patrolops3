/*
	Author: Eightysix

	Description:
	Returns Marker Type of the type vehicle the unit or group is operating.

	Syntax:
	_Type = (unit/group/vehicle) call mpsf_fnc_getObjectMarkerType;

	Example:
	_Type = (player) call mpsf_fnc_getObjectMarkerType;
	_Type = (vehicle player) call mpsf_fnc_getObjectMarkerType;
*/
if( !mpsfHLC ) exitWith {};
waitUntil { !isNull player && time > 1 };

mpsf_HLC_CLI__ID = owner player;
mpsf_HLC_CLI__OBJ = player;

mpsf_HLC_CLI__DATA = [mpsf_HLC_CLI__ID,mpsf_HLC_CLI__OBJ];
publicVariableServer "mpsf_HLC_CLI__DATA";

"mpsf_HLC_pubVar_spawn_ary" addPublicVariableEventHandler { ((_this select 1) select 1) call mpsf_fnc_objectsSpawner };
"mpsf_HLC_pubVar_spawn_veh" addPublicVariableEventHandler { ((_this select 1) select 1) call mpsf_fnc_vehicleSpawner };
"mpsf_HLC_pubVar_spawn_inf" addPublicVariableEventHandler { ((_this select 1) select 1) call mpsf_fnc_squadSpawner };
"mpsf_HLC_pubVar_spawn_crw" addPublicVariableEventHandler { ((_this select 1) select 1) call mpsf_fnc_crewSpawner };

diag_log format["MPSF HLC INIT Brdcst: %1",mpsf_HLC_CLI__DATA];