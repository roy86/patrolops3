/*
	Author: Eightysix

	Description:

*/
private["_ammobox"];

mpsf_pVAR_declaredSupplybox = _this; publicVariable "mpsf_pVAR_declaredSupplybox";

if(mpsfCLI) then {
	_this call mpsf_fnc_handleSupplybox;
};