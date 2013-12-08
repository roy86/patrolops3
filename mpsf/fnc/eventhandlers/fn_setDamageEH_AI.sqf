/*
	Author: Eightysix

	Description:


	Syntax:

*/
private["_unit"];

if !(mpsf_param_ai_easyKill) exitWith {};

_units = _this;
if(typeName _units != typeName []) then { _units = [_units] };

{
	_x removeAllEventHandlers "HandleDamage";
	_x addEventHandler ["HandleDamage",{
		_damage = (_this select 2)*2;
		_damage
	}];
}forEach _units;