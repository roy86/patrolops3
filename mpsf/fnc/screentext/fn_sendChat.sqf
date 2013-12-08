/*
	Author: Eightysix

	Description:
	Create Chat Command : Global Broadcast
*/
mpsf_brdcst_chat = _this; publicVariable "mpsf_brdcst_chat";

if(mpsfCLI) then {
	_this call mpsf_fnc_chat;
}