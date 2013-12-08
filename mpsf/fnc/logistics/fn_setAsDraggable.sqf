/*
	Author: Eightysix

	Description:
	Enables an array of object(s) to be dragable

	Syntax:
	<Object(s)> call mpsf_fnc_setDragable

	Returns: Nothing
*/
private["_objects"];

_objects= _this;

if(typeName _objects != typeName []) then { _objects = [_objects] };

{
	_x setVariable ["mpsf_dragable",true,isServer];
	_x setVariable ["mpsf_dragged",objNull,isServer];
}forEach _objects;

true;