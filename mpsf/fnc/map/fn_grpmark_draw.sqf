private["_pos","_type","_displayIcon"];

if(isNil "mpsf_param_grpmark_allow") then { mpsf_param_grpmark_allow = true };
if(isNil "mpsf_param_grpmark_squad_allow") then { mpsf_param_grpmark_squad_allow = true };

if(mpsf_param_grpmark_allow || mpsf_param_grpmark_squad_allow) then { ace_sys_tracking_markers_enabled = false };

while {true} do {
	_displayIcon = if( ([player] call mpsf_fnc_hasARgear || !(mpsf_param_hud_requireGlasses)) && mpsf_hud_worldtoscreen_display ) then { true }else{ false };
	setGroupIconsVisible [true,_displayIcon];
	if(mpsf_param_grpmark_allow) then { call mpsf_fnc_grpmark_detectGroups };

	if(alive player && mpsf_param_grpmark_squad_allow) then {
		call mpsf_fnc_grpmark_detectTeam;

		{
			_pos = if(vehicle _x == vehicle player || driver vehicle _x != _x ) then { [-1000,-1000] }else{ _x call mpsf_fnc_getPos };
			_type = _x call mpsf_fnc_getObjectMarkerType;
			format["mark_unit_%1",_x] setMarkerPosLocal _pos;
			format["mark_unit_%1",_x] setMarkerTypeLocal _type;
		}forEach mpsf_grpmark_squadList;
	};
	sleep 0.1;
};