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
if(!mpsfSRV) exitWith{};

while {true} do {
	_list = [];
	{
		if( owner _x == 0 ) then {
			_list set [count _list, _x];
		};
	}forEach allunits;

	_list call mpsf_fnc_setowner;

	sleep 30;
};