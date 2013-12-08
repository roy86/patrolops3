if !(mpsfSRV) exitWith {};

mpsf_pVAR_skipDateTime = _this;
publicVariable "mpsf_pVAR_skipDateTime";

_this spawn mpsf_fnc_skipTime;