private["_injured","_return"];

_injured = _this select 0;

_return = if(
	alive _injured &&
	(_injured getVariable ["mpsf_injury_inAgony",false]) &&
	isNull (_injured getVariable ["mpsf_injury_dragger",objNull]) &&
	isNull (_injured getVariable ["mpsf_injury_healer", objNull])
) then { true }else{ false };

if(mpsfCLI) then {
	if !(alive _injured) then { [ format[localize "STR_MPSF_INJURY_CHECKDEAD",name _injured] ] call mpsf_fnc_hint };
};

_return