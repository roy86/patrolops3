private["_pos","_mkr","_set"];

if(isNil "mpsf_grpmark_squadList") then { mpsf_grpmark_squadList = [] };

{
	_set = true;
	if( vehicle _x == vehicle player && _x != player ) then { _set = false };
	if( _x == leader group player ) then { _set = false };
	if!(_x IN (units group player)) then { _set = false };

	if( _set && alive _x && !(_x IN mpsf_grpmark_squadList) ) then {
		_pos = getPos _x;
		_mkr = createMarkerLocal [ format["mark_unit_%1",_x], _pos];
		_mkr setMarkerShapeLocal "ICON";
		_mkr setMarkerTypeLocal "mil_dot";
		_mkr setMarkerColorLocal (_x call mpsf_fnc_getUnitMarkerColour);
		_mkr setMarkerSizeLocal [0.6,0.6];

		mpsf_grpmark_squadList set [count mpsf_grpmark_squadList, _x];
	};

	if(!_set && _x IN mpsf_grpmark_squadList) then {
		deleteMarker format["mark_unit_%1",_x];
		mpsf_grpmark_squadList = mpsf_grpmark_squadList - [_x];
	};
}forEach (playableUnits + switchableUnits + (units group player));

{
	if( !(alive _x) || !(_x IN (units group player)) ) then {
		deleteMarker format["mark_unit_%1",_x];
		mpsf_grpmark_squadList = mpsf_grpmark_squadList - [_x];
	};
}forEach mpsf_grpmark_squadList;

mpsf_grpmark_squadList;