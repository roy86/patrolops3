/*
	Author: Eightysix

	Description:
	Enables an array of objects to be loadable

	Syntax:
	<array of Objects> call mpsf_fnc_setAsMedic

	Returns: Nothing
*/
private["_objects"];

_objects = _this;

if(typeName _objects != typeName []) then { _objects = [_objects] };

{
	_x setVariable ["mpsf_VAR_roleAttribute","Medic",true];
	_x setVariable ["po3_VAR_crew",true,true];
}forEach _objects;

true;