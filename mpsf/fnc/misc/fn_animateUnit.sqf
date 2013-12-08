mpsf_pVAR_animationState = _this; publicVariable "mpsf_pVAR_animationState";

if(mpsfCLI) then {
	_this call mpsf_fnc_playActionNow;
	sleep 0.1;
};