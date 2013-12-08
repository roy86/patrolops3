mpsf_pVAR_directionState = _this; publicVariable "mpsf_pVAR_directionState";

if(mpsfCLI) then {
	_this call mpsf_fnc_setDir;
	sleep 0.1;
};