mpsf_logistics_SelectedLoadObject = _this select 0;

[true,"HINT",format[ localize "STR_MPSF_LOGIST_SELETLOADER",[mpsf_logistics_SelectedLoadObject] call mpsf_fnc_getCfgText] ] call mpsf_fnc_hint;

mpsf_logistics_SelectedLoadObject spawn {
	_timeStamp = time + 15;
	waitUntil{ _timeStamp < time };
	if !(isNil "mpsf_logistics_SelectedLoadObject") then {
		if(_this == mpsf_logistics_SelectedLoadObject) then {
			mpsf_logistics_SelectedLoadObject = nil;
			[true,"HINT","Canceled Load of Object"] call mpsf_fnc_hint;
		};

	};
};