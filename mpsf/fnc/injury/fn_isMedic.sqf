private ["_healer","_isMedic"];

_healer = _this;

_isMedic = if( getNumber (configFile >> "CfgVehicles" >> (typeOf _healer) >> "attendant") != 1 || _healer getVariable ["mpsf_attr_isHealer",false] ) then { true }else{ false };

_isMedic;