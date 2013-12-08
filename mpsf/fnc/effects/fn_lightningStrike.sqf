/*
	Author: Eightysix

	Description:
	Create Lightning Strike : Global Broadcast
*/
mpsf_pVAR_effectLGHTSTRK = _this; publicVariable "mpsf_pVAR_effectLGHTSTRK";

if(mpsfCLI) then {
	_this call mpsf_fnc_effectLightningStrike;
};