/*
	Author: Eightysix

	Description:
	Enables an array of objects to be loadable

	Syntax:
	<array of Objects> call mpsf_fnc_setAsCrewman

	Returns: Nothing
*/
private["_objects"];

_objects = _this;

if(typeName _objects != typeName []) then { _objects = [_objects] };

{
	_x setVariable ["mpsf_VAR_roleAttribute","Crewman",true];
}forEach _objects;

true;