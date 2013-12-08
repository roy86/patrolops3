/*
	Author: Eightysix

	Description:

*/
disableSerialization;

if(isnil "mpsf_respawn_positions_list") exitWith { [localize "STR_MPSF_RESPWN_NOPOINT"] call mpsf_fnc_hintc };

onMapSingleClick "";

_select = (_this select 0) lbValue (lbCurSel (_this select 0) );
_text = (_this select 0) lbtext (lbCurSel (_this select 0) );
_picID = (_this select 0) lbPicture (lbCurSel (_this select 0) );

_display = uinamespace getvariable ["mpsf_respawn_gui",objNull];
_ctrlMAP = _display  displayctrl 860011;
_ctrlERR = _display  displayctrl 860013;
_ctrlERR ctrlSetFade 1;
_ctrlERR ctrlCommit 0.5;

_point = mpsf_respawn_positions_list select _select;
_side = _point select 0;
_position = switch (typeName(_point select 1)) do {
	case "STRING" : { if(tolower(_point select 1) != "halo") then { (_point select 1) call mpsf_fnc_getPos }else{ (leader group player) call mpsf_fnc_getPos } };
	case "OBJECT" : { (_point select 1) call mpsf_fnc_getPos };
	default { (_point select 1) call mpsf_fnc_getPos };
};

mpsf_selected_point = _point;

_ctrlMAP ctrlRemoveAllEventHandlers "MouseButtonDblClick";
_ctrlMAP ctrlMapAnimAdd [1,0.05,_position];
ctrlMapAnimCommit _ctrlMAP;

if( typeName(_point select 1) == "STRING") then {
	if( tolower(_point select 1) == "halo") exitWith {
		if!(isNil "mpsf_tempscript_respawnMarker") then {
			terminate mpsf_tempscript_respawnMarker;
			mpsf_tempscript_respawnMarker = nil;
		};

		_text = localize "STR_MPSF_RESPWN_CNTDEPLY5";
		_display = uinamespace getvariable ["mpsf_respawn_gui",objNull];
		_ctrlERR = _display  displayctrl 860013;
		_ctrlERR ctrlSetText format["%1",_text ];
		_ctrlERR ctrlSetFade 0;
		_ctrlERR ctrlCommit 0.5;
		_ctrlMAP ctrlAddEventHandler ["MouseButtonDblClick","[player,((_this select 0) ctrlMapScreenToWorld [_this select 2,_this select 3])] spawn mpsf_fnc_redeployByHALO;"];
	};
};

_color = _side call mpsf_fnc_getUnitMarkerColour;

_fnc_respawnMarker = {
	if(!mpsf_a3) exitWith { "selector_selectedMission" };

	private["_return"];
	_return = switch (typeName _this) do {
		case "OBJECT" : {
			switch (true) do {
				case ( _this isKindof "Man" )		: { "respawn_inf" };
				case ( _this isKindof "Car" )		: { "respawn_motor" };
				case ( _this isKindof "Tracked_APC" )	: { "respawn_armor" };
				case ( _this isKindof "Tank" )		: { "respawn_armor" };
				case ( _this isKindof "Helicopter" )	: { "respawn_air" };
				case ( _this isKindof "Plane" )		: { "respawn_plane" };
				case ( _this isKindof "Ship" )		: { "respawn_naval" };
				default { "respawn_unknown" };
			};
		};
		case "LOCATION";
		case "ARRAY";
		case "STRING" : { "respawn_unknown" };
		default { "respawn_unknown" };
	};

	_return
};

deleteMarkerLocal mpsf_respawn_selectMarker;
mpsf_respawn_selectMarker = createmarkerlocal ["mpsf_respawn_selectedMarker", _position ];
mpsf_respawn_selectMarker setmarkershapelocal "ICON";
mpsf_respawn_selectMarker setmarkertypelocal ( (_point select 1) call _fnc_respawnMarker);
mpsf_respawn_selectMarker setmarkercolorlocal _color;
mpsf_respawn_selectMarker setmarkertextlocal format[" %1",_text];

if(isNil "mpsf_tempscript_respawnMarker" ) then {
	mpsf_tempscript_respawnMarker = [] spawn {
		private["_rad"];

		waitUntil {!isNil "mpsf_respawn_selectMarker"};
		while {!isNil "mpsf_respawn_selectMarker"} do {
			if(isNil "_rad") then { _rad = 0 };
			mpsf_respawn_selectMarker setMarkerDirLocal _rad;
			mpsf_respawn_selectMarker setMarkerPosLocal ((mpsf_selected_point select 1) call mpsf_fnc_getPos);
			_rad = _rad + 3;
			sleep 0.02;
		};
	};
};