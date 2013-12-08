if !(mpsfSRV) exitWith {};

mpsf_pVAR_changeFog = _this;
publicVariable "mpsf_pVAR_changeFog";

_this spawn mpsf_fnc_setfog;