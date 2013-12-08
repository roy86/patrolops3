/*
	@version: 1.0
	@file_name: fetch_config.sqf
	@file_author: TAW_Tonic
	@file_edit: 5/9/2013
	@file_description: Fetch information from either binConfig or VAS Config
*/
private["_request","_filter","_list"];

_request = _this select 0;
_filter = if(isNil {_this select 1}) then {nil} else {_this select 1};
_list = [];

switch(_request) do {
	case "guns": {
		_list = ([] call mpsf_fnc_getCfgMpsfLoadout) select 0;
		if(!isNil {_filter}) then {
			_list = [_list,_filter] call VAS_fnc_filter;
		};
	};

	case "mags": {
		_list = ([] call mpsf_fnc_getCfgMpsfLoadout) select 1;
		if(!isNil {_filter}) then {
			_list = [_list,_filter] call VAS_fnc_filter;
		};
	};

	case "items": {
		_list = ([] call mpsf_fnc_getCfgMpsfLoadout) select 2;
		if(!isNil {_filter}) then {
			_list = [_list,_filter] call VAS_fnc_filter;
		};
	};

	case "packs": {
		_list = ([] call mpsf_fnc_getCfgMpsfLoadout) select 3;
		if(!isNil {_filter}) then {
			_list = [_list,_filter] call VAS_fnc_filter;
		};
	};

	case "glass": {
		_list = ([] call mpsf_fnc_getCfgMpsfLoadout) select 4;
		if(!isNil {_filter}) then {
			_list = [_list,_filter] call VAS_fnc_filter;
		};
	};
};

_list;