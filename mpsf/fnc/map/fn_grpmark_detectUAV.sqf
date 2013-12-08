private["_pos","_mkr","_set"];

if(isNil "mpsf_grpmark_UAVList") then { mpsf_grpmark_UAVList = [] };

{
	_set = false;
	_operator = (uavControl _x) select 0;

	if( (side _operator) getFriend PlayerSide > 0.6 ) then { _set = true };
	if( side(group _x) getFriend PlayerSide > 0.6 ) then { _set = true };

	if( _set && alive _x && !(_x IN mpsf_grpmark_UAVList) ) then {
		_pos = getPos _x;
		_mkr = createMarkerLocal [ format["mark_UAV_%1",_x], _pos];
		_mkr setMarkerShapeLocal "ICON";
		_mkr setMarkerTypeLocal (_x call mpsf_fnc_getObjectMarkerType);
		_mkr setMarkerColorLocal (_x call mpsf_fnc_getUnitMarkerColour);

		mpsf_grpmark_UAVList set [count mpsf_grpmark_UAVList, _x];
	};

	if(!_set && _x IN mpsf_grpmark_UAVList) then {
		deleteMarker format["mark_UAV_%1",_x];
		mpsf_grpmark_UAVList = mpsf_grpmark_UAVList - [_x];
	};
}forEach allUnitsUav;

mpsf_grpmark_UAVList;