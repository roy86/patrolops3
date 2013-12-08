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
if(isNil "mpsf_HLC_CLI__DATA") exitWith { ["You do not know the Headless Client"] call mpsf_hint };

_hcID	= owner (mpsf_HLC_CLI__DATA select 1);
_list	= if( count _this > 0 ) then { _this select 1 } else { [] };

{
	if( _x setOwner _hcID ) then {
		if(mpsf_debug_log) then { diag_log format["MPSF HLC: %1 setOwner %2 - Done ",_x,_hcID] };
	}else{
		if(mpsf_debug_log) then { diag_log format["MPSF HLC: %1 setOwner %2 - Fail -> Owner is %3",_x,_hcID,owner _x] };
	};
}forEach _list;