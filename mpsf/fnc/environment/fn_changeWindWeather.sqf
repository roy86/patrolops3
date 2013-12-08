if !(mpsfSRV) exitWith {};

mpsf_pVAR_changeWind = _this;
publicVariable "mpsf_pVAR_changeWind";

_this spawn mpsf_fnc_setWind;