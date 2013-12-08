if(!mpsf_param_baseProtection) exitWith {};
if(isNil "mpsf__VAR_ETCXH_FITCXRE") then { mpsf__VAR_ETCXH_FITCXRE = true };
if(isNil "mpsf_protector_enable") then { mpsf_param_baseProtection = true };

private["_vehicle "];

_vehicle = _this;

if(typeName _vehicle != typeName objNull) exitWith { ["EventHandler","Fired EH failed to detect Object",true] call mpsf_fnc_log };

if(!isnil {_vehicle getVariable ["mpsf_EH_Fired",nil]}) then {
	_vehicle removeEventHandler ["Fired",_vehicle getVariable ["mpsf_EH_Fired",0] ];
}else{
	_vehicle removeAllEventHandlers "Fired";
};

_ehF = _vehicle addEventHandler ["Fired",{
	if(mpsf_protector_enable) then {
		_p = _this select 6;
		if(
			_p distance (getMarkerPos "respawn_west") < 500 ||
			_p distance (getMarkerPos "respawn_east") < 500 ||
			_p distance (getMarkerPos "respawn_guerrila") < 500
		)then {
				[true,"HINTC",localize "STR_MPSF_DIALOG_CEASEFIRE"] call mpsf_fnc_hint;
				deleteVehicle _p;
		}else{
			_p spawn {
				waitUntil {
					if(
						_this distance (getMarkerPos "respawn_west") < 500 ||
						_this distance (getMarkerPos "respawn_east") < 500 ||
						_this distance (getMarkerPos "respawn_guerrila") < 500
					)then {
						[true,"HINTC",localize "STR_MPSF_DIALOG_CEASEFIRE"] call mpsf_fnc_hint;
						deleteVehicle _this;
					};
					if( isNull _this ) exitWith { true };
					false
				};
			};
		};
	};
}];

_vehicle setVariable ["mpsf_EH_Fired",_ehF,false];