/*
	Author: Eightysix

	Description:
	Create Hint : Global Broadcast
*/
mpsf_brdcst_hint = _this; publicVariable "mpsf_brdcst_hint";

if(mpsfCLI) then {
	_this call mpsf_fnc_hint;
};