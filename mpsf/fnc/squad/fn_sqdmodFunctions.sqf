mpsf_fnc_sqdmod_makeLeader = {
	if(typeName mpsf_sqdmod_VAR_selectedUnit != "OBJECT") exitWith {};
	if(typeName mpsf_sqdmod_VAR_selectedGroup != "GROUP") exitWith {};

	[mpsf_sqdmod_VAR_selectedUnit, group mpsf_sqdmod_VAR_selectedUnit] call mpsf_fnc_assignGroupLeader;

	[] call mpsf_fnc_sqdmod_updateGUI;
};

mpsf_fnc_sqdmod_joinGroup = {
	if(typeName mpsf_sqdmod_VAR_selectedUnit != "OBJECT") exitWith {};
	if(typeName mpsf_sqdmod_VAR_selectedGroup != "GROUP") exitWith {};

	[mpsf_sqdmod_VAR_selectedUnit, mpsf_sqdmod_VAR_selectedGroup] call mpsf_fnc_unitJoinGroup;

	[] call mpsf_fnc_sqdmod_updateGUI;

	mpsf_sqdmod_VAR_selectedUnit = mpsf_sqdmod_VAR_unitList select (lbSelection (uinamespace getvariable 'mpsf_hud_squadmod_lb1') select 0);
};

mpsf_fnc_sqdmod_newGroup = {
	[player] call mpsf_fnc_createNewGroup;
	[] call mpsf_fnc_sqdmod_updateGUI;
};

mpsf_fnc_sqdmod_deleteGroup = {
	if(typeName mpsf_sqdmod_VAR_selectedGroup != "GROUP") exitWith {};
	if(count units mpsf_sqdmod_VAR_selectedGroup > 0) exitWith { [true,"HINT","Cannot DELETE Group as the Group is Not Empty."] call mpsf_fnc_hint };

	deleteGroup mpsf_sqdmod_VAR_selectedGroup;
	[] call mpsf_fnc_sqdmod_updateGUI;
};

mpsf_fnc_sqdmod_editGroup = {
	private["_name"];
	_name = ctrlText (uinamespace getvariable 'mpsf_hud_squadmod_ed1');
	[mpsf_sqdmod_VAR_selectedGroup,_name] call mpsf_fnc_changeGroupID;

	[] call mpsf_fnc_sqdmod_updateGUI;
};

mpsf_fnc_sqdmod_selectUnit = {
	mpsf_sqdmod_VAR_selectedUnit = mpsf_sqdmod_VAR_unitList select (_this select 1);

	if(typeName mpsf_sqdmod_VAR_selectedUnit == "GROUP") then {
		(uinamespace getvariable 'mpsf_hud_squadmod_ed1') ctrlSetText (groupID mpsf_sqdmod_VAR_selectedUnit);
		mpsf_sqdmod_VAR_selectedGroup = mpsf_sqdmod_VAR_selectedUnit;
		mpsf_sqdmod_VAR_selectedUnit = objnull;
	}else{
		{
			if( (_x select 0) == (mpsf_sqdmod_VAR_selectedUnit getVariable ["mpsf_VAR_roleAttribute","Rifleman"]) ) then {
				(uinamespace getvariable 'mpsf_hud_squadmod_C01') lbSetCurSel _forEachIndex;
			};
		}forEach mpsf_CfgLogistics_UnitLoadouts;
	};

	[] call mpsf_fnc_sqdmod_updateGUI;
};

mpsf_fnc_sqdmod_selectGroup = {
	mpsf_sqdmod_VAR_selectedGroup = mpsf_sqdmod_VAR_unitList  select ((_this select 0) lbValue (_this select 1));
	(uinamespace getvariable 'mpsf_hud_squadmod_ed1') ctrlSetText (groupID mpsf_sqdmod_VAR_selectedGroup);
	[] call mpsf_fnc_sqdmod_updateGUI;
};

mpsf_fnc_sqdmod_assignRole = {
	if ( !([group mpsf_sqdmod_VAR_selectedUnit,player] call mpsf_fnc_isTeamLeader) && !([player] call mpsf_fnc_isAdministrator) ) exitWith { [true,"HTINTC","You are not authorised to change the team"] call mpsf_fnc_hint };

	_role = (mpsf_CfgLogistics_UnitLoadouts select (_this select 1)) select 0;
	if !([mpsf_sqdmod_VAR_selectedUnit,format["%1",_role]] call mpsf_fnc_isQualified) then {
		mpsf_sqdmod_VAR_selectedUnit setVariable ["mpsf_VAR_roleAttribute",_role,true];
		[ [mpsf_sqdmod_VAR_selectedUnit], "HINT", format[localize "STR_MPSF_DIALOG_ASSIGNROLE",_role]] call mpsf_fnc_sendHint;
		[ (group mpsf_sqdmod_VAR_selectedUnit), "GROUP", format[localize "STR_MPSF_DIALOG_ASSIGNEDROLE", name mpsf_sqdmod_VAR_selectedUnit,_role] ] call mpsf_fnc_sendChat;
	};
	[] call mpsf_fnc_sqdmod_updateGUI;
};

mpsf_fnc_sqdmod_requestUAS = {
	if !(isPlayer mpsf_sqdmod_VAR_selectedUnit) exitWith { [true,"HINT","No Assigned Player to send the UAS to"] call mpsf_fnc_hint };
	if ( !([group mpsf_sqdmod_VAR_selectedUnit,player] call mpsf_fnc_isTeamLeader) && !([player] call mpsf_fnc_isAdministrator) ) exitWith { [true,"HINTC","You are not authorised!"] call mpsf_fnc_hint };

	_type = _this select 0;
	switch (toLower _type) do {
		case "uav" : {
			if !(alive mpsf_support_ActiveUAV) then { [mpsf_sqdmod_VAR_selectedUnit] spawn mpsf_fnc_supportCreateUAV };
		};
		case "ugv" : {
			if !(alive mpsf_support_ActiveUGV) then { [mpsf_sqdmod_VAR_selectedUnit] spawn mpsf_fnc_supportCreateUGV };
		};
	};
	[] call mpsf_fnc_sqdmod_updateGUI;
};
