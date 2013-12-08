if !(mpsfSRV) exitWith {};

mpsf_pVAR_changeDateTime = _this;
publicVariable "mpsf_pVAR_changeDateTime";

_this spawn mpsf_fnc_changeTime;