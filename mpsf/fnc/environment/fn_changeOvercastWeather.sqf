if !(mpsfSRV) exitWith {};

mpsf_pVAR_changeOvercast = _this;
publicVariable "mpsf_pVAR_changeOvercast";

_this spawn mpsf_fnc_setOvercast;