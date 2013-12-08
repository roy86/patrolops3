/*
	Author: Eightysix

	Description:
	
*/
disableSerialization;

_display = uinamespace getvariable ["mpsf_respawn_gui",objNull];
if( isNull _display ) exitWith { ["ERROR IN RESPAWN DIALOG"] call mpsf_fnc_hint };
_control = _display  displayctrl 860012;
_ctrlERR = _display  displayctrl 860013;
_ctrlERR ctrlSetFade 1;
_ctrlERR ctrlCommit 0.2;

while { dialog } do {

	[] call mpsf_fnc_getRespawnPositions;

	lbClear _control;
	{
		_target	= _x select 0;
		_dest = _x select 1;

		if( [player,_target] call mpsf_fnc_checkObjCondition ) then {

			_icon = "";
			_text = "";
			_add = true;
			switch (typeName _dest) do {
				case "OBJECT" : {
					if( !canMove _dest || !alive _dest) then { _add = false };
					_icon = [_dest] call mpsf_fnc_getCfgIcon;
					_text =	if( count _x > 3 ) then { _x select 3 }else{ [_dest] call mpsf_fnc_getCfgText };
				};
				case "LOCATION" : {
					_icon = if( count _x > 2 ) then { [_x select 2] call mpsf_fnc_getCfgIcon }else{ ["mil_flag"] call mpsf_fnc_getCfgIcon };
					_text =	if( count _x > 3 ) then { _x select 3 }else{ [_dest] call mpsf_fnc_getCfgText };
				};
				case "ARRAY" : {
					_icon = if( count _x > 2 ) then { [_x select 2] call mpsf_fnc_getCfgIcon }else{ ["mil_flag"] call mpsf_fnc_getCfgIcon };
					_text =	if( count _x > 3 ) then { _x select 3 }else{ "GRID " + str( mapGridPosition( _dest call mpsf_fnc_getPos ) ) };
				};
				case "STRING" : {
					_icon = if( count _x > 2 ) then { [_x select 2] call mpsf_fnc_getCfgIcon }else{ ["mil_flag"] call mpsf_fnc_getCfgIcon };
					_text =	if( count _x > 3 ) then { _x select 3 }else{ "GRID " + str( mapGridPosition( _dest call mpsf_fnc_getPos ) ) };
				};
			};

			if(_add) then {
				_control lbAdd format["%1",_text];
				_control lbSetPicture [ (lbSize _control) - 1, _icon];
				_control lbSetValue [ (lbSize _control) - 1, _forEachIndex];
			};
		};
	}forEach mpsf_respawn_positions_list;

	if(count mpsf_respawn_positions_list > 8) exitWith {};
	sleep 1;
};

waitUntil{!dialog};

if( !isNil "mpsf_tempscript_respawnMarker" ) then {
	terminate mpsf_tempscript_respawnMarker;
	mpsf_tempscript_respawnMarker = nil;
};