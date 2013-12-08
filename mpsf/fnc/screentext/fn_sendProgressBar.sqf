/*
	Author: Eightysix

	Description:
	Create Chat Command : Global Broadcast
*/
mpsf_brdcst_progressBar = _this; publicVariable "mpsf_brdcst_progressBar";

if(mpsfCLI) then {
	_this call mpsf_fnc_progressbar;
};