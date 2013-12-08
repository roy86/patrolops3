/*
	Author: Eightysix

	Description:
	Returns Marker Colour of the side of the unit or group.

	Syntax:
	_colour = (unit/group) call mpsf_fnc_getUnitMarkerColour;

	Example:
	_colour = (player) call mpsf_fnc_getUnitMarkerColour;
	_colour = (group player) call mpsf_fnc_getUnitMarkerColour;
*/
private["_side","_colour"];

if(isNil "mpsf_a3") then { mpsf_a3 = false };

_side = switch (typename _this) do {
	case "SIDE" : { _this };
	case "GROUP" : { side( _this )  };
	case "OBJECT" : { side( group _this ) };
	default { civilian };
};

_colour = switch (_side) do {
	case east : { if(mpsf_a3) then { "ColorOPFOR" }else{ "ColorRed" } };
	case west : { if(mpsf_a3) then { "ColorBLUFOR" }else{ "ColorBlue" } };
	case resistance : { if(mpsf_a3) then { "ColorIndependent" }else{ "ColorGreen" } };
	case civilian : { "ColorWhite" };
	default { "ColorBlack" };
};

_colour;