/*
	Author: Eightysix

	Description:
	Enables an array of object(s) to be dragable

	Syntax:
	<Object(s)> call mpsf_fnc_setDragable

	Returns: Nothing
*/
private["_objects"];

_CRVs = _this;

if(typeName _CRVs != typeName []) then { _CRVs = [_CRVs] };

_CRVs spawn mpsf_fnc_setAsTowVeh;
_CRVs spawn mpsf_fnc_setContactStartEH_CRV;

true;