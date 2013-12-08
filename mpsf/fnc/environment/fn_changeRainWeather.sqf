if !(mpsfSRV) exitWith {};

mpsf_pVAR_changeRain = _this;
publicVariable "mpsf_pVAR_changeRain";

_this spawn mpsf_fnc_setRain;