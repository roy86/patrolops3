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
if( !mpsfSRV ) exitWith {};

private["_return","_id","_obj"];

_return = if( isNil "mpsf_HLC_CLI__DATA" ) then {
	objNull
}else{
	mpsf_HLC_CLI__DATA set [0, owner (mpsf_HLC_CLI__DATA select 1)];

	_id = mpsf_HLC_CLI__DATA select 0;
	_obj = mpsf_HLC_CLI__DATA select 1;

	if(mpsf_debug_log) then { diag_log format["MPSF HLC ID: %1 Owns %2",_id,_obj]; };
	if( _id != owner _obj ) then {
		diag_log format["MPSF DETECT HLC VIOLATION: Owner '%3' of HLC '%2' is not '%1'",_id,_obj, owner _obj ];
	};

	[ _id , _obj ]
};

_return