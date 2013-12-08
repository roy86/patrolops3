private["_injured","_healer","_offset","_relpos","_time","_damage","_healed"];

_injured = _this select 0;
_healer = _this select 1;

if!([_injured] call mpsf_fnc_injuredIsHealable) exitWith { [true,"HINT",format["%1 is unable to be healed",name _injured]] call mpsf_fnc_hint };
if(_healer distance _injured > 4) exitWith{ [true,"HINT",format["%1 is too far away to be healed",name _injured]] call mpsf_fnc_hint };

if(_healer == player) then {
	if( player call mpsf_fnc_checkActionBusy ) exitWith {};
	true call mpsf_fnc_setActionBusy;
	mpsf_VAR_HealingStatus = true; //<!-- HACK JOB
};

_time = time;
_damage = (_injured getVariable ["mpsf_injury_healedDamage",0])*15;
_injured setVariable ["mpsf_injury_BeingHealed",true,true];
_injured setVariable ["mpsf_injury_healer",_healer,true];

_offset = [0,0,0]; _dir = 0;
_relpos = _injured worldToModel position _healer;
if((_relpos select 0) < 0) then{ _offset=[-0.8,0.2,0]; _dir=90+(direction _injured); } else{ _offset=[0.8,0.2,0]; _dir=270+(direction _injured); };

[_healer,"Healer_Start"] call mpsf_fnc_animateUnit;
_healer setPosATL ([_injured,0.8,(_dir-180)] call mpsf_fnc_getPos);
_injured attachTo [_healer,_offset];
_injured setDir _dir;

While{
	time - _time < _damage
	&& alive _healer
	&& alive _injured
	&& (_healer distance _injured) < 1.25
	&& !(_healer getVariable ["mpsf_injury_inAgony",false])
	&& (mpsf_VAR_HealingStatus)
}do{
	sleep 2;
	[ [_healer,_injured],["Applying First Aid",((time - _time) / (_damage)) min 1]] call mpsf_fnc_progressBar;
};

detach _injured;
_injured setVariable ["mpsf_injury_BeingHealed",false,true];

if(_healer == player) then { false call mpsf_fnc_setActionBusy; };
if(_healer getVariable ["mpsf_injury_inAgony",false]) exitWith { _injured setVariable ["mpsf_injury_healer",objNull,true]; mpsf_VAR_HealingStatus = false;/*<!-- HACK JOB*/ };
if(_healer == player) then {
	if !(mpsf_VAR_HealingStatus) exitWith {}; //<!-- HACK JOB
	mpsf_VAR_HealingStatus = false; //<!-- HACK JOB
};

if !(alive _injured) exitWith { [true, "HINT", format["%1 has Died",name _injured] ] call mpsf_fnc_hint };
if !(alive _healer) exitWith {};

if((time - _time) >= _damage) then
{
	[_healer,"Healer_Done"] call mpsf_fnc_animateUnit;
	_isMedic = _healer call mpsf_fnc_isMedic;
	_healed = switch (true) do {
		case ( _isMedic && _healer call mpsf_fnc_hasMedKit ) : { 0 };
		case ( _isMedic && _healer call mpsf_fnc_hasFirstAidKit ) : { _healer spawn mpsf_fnc_useFirstAidKit; 0.25 };
		case ( !(_isMedic) && _healer call mpsf_fnc_hasFirstAidKit ) : { _healer spawn mpsf_fnc_useFirstAidKit; 0.5 };
		default { 0.7 };
	};
	_injured setVariable ["mpsf_injury_healedDamage",_healed,true];
	_injured setVariable ["mpsf_injury_inAgony",false,true];
} else {
	hint "First Aid Canceled!";	
};