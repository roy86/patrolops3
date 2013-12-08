/*
	Author: Eightysix

	Description:

*/
private["_ammobox"];

mpsf_pVAR_declaredAmmobox = _this; publicVariable "mpsf_pVAR_declaredAmmobox";

if(mpsfCLI) then {
	_this call mpsf_fnc_handleAmmobox;
};