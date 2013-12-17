private["_unitInAgony","_firstAider","_offset","_relpos","_time","_damage","_healed"];

_unitInAgony = _this select 0;
_firstAider = _this select 1;

if!([_unitInAgony] call mpsf_fnc_injuredIsHealable) exitWith { [true,"HINT",format["%1 is unable to be healed",name _unitInAgony]] call mpsf_fnc_hint };
if(_firstAider distance _unitInAgony > 4) exitWith{ [true,"HINT",format["%1 is too far away to be healed",name _unitInAgony]] call mpsf_fnc_hint };

if(_firstAider == player) then {
	if( player call mpsf_fnc_checkActionBusy ) exitWith {};
	true call mpsf_fnc_setActionBusy;
	mpsf_VAR_HealingStatus = true; //<!-- HACK JOB
};

_time = time;

// Get the damage of the injured unit
_damage = (((_unitInAgony getVariable ["mpsf_injury_healedDamage",0]) max 0.5) min 1) * 10; // A MIN of 5secs and MAX of 10secs

// Set the variables on the injured unit to state they are being healed
_unitInAgony setVariable ["mpsf_injury_BeingHealed",true,true];
_unitInAgony setVariable ["mpsf_injury_healer",_firstAider,true];

// Move the healer to the side of the injured and begin healing
_offset = [0,0,0]; _dir = 0;
_relpos = _unitInAgony worldToModel position _firstAider;
if( (_relpos select 0) < 0 ) then{
	_offset = [-0.8,0.2,0];
	_dir = 90 + (direction _unitInAgony);
}else{
	_offset = [0.8,0.2,0];
	_dir = 270 + (direction _unitInAgony);
};

_healPos = ([_unitInAgony,0.8,(_dir-180)] call mpsf_fnc_getPos); _healPos set [2,(getPosATL _unitInAgony) select 2];

[_firstAider,"Healer_Start"] call mpsf_fnc_animateUnit;
_firstAider setPosATL _healPos;
_unitInAgony attachTo [_firstAider,_offset];
_unitInAgony setDir _dir;

While{
	time - _time < _damage
	// the healer is alive
	&& alive _firstAider
	// the injured is alive
	&& alive _unitInAgony
	// the healer is neaby the injured
	&& (_firstAider distance _unitInAgony) < 1.25
	// The healer hasn't been shot
	&& !(_firstAider getVariable ["mpsf_injury_inAgony",false])
	// HACK JOB
	&& (mpsf_VAR_HealingStatus)
}do{
	sleep 1;
	[ [_firstAider,_unitInAgony],["Applying First Aid",((time - _time) / (_damage)) min 1]] call mpsf_fnc_progressBar;
};

detach _unitInAgony;
_unitInAgony setVariable ["mpsf_injury_BeingHealed",false,true];

// If the healer is in agony
if( _firstAider getVariable ["mpsf_injury_inAgony",false] ) exitWith { _unitInAgony setVariable ["mpsf_injury_healer",objNull,true] };
// Healer is not in agony so make them not busy
if(_firstAider == player) then { false call mpsf_fnc_setActionBusy; };
// If the healer moved too far away
if( _firstAider distance _unitInAgony >= 1.25 ) exitWith { _unitInAgony setVariable ["mpsf_injury_healer",objNull,true] };
// If the injured died
if !(alive _unitInAgony) exitWith { [true, "HINT", format["%1 has Died",name _unitInAgony] ] call mpsf_fnc_hint };
// If the healer died
if !(alive _firstAider) exitWith {};
// Finish healing Animation
[_firstAider,"Healer_Done"] call mpsf_fnc_animateUnit;
// If they are still in the "healing state" then heal the injured
if(mpsf_VAR_HealingStatus) then {
	_isMedic = _firstAider call mpsf_fnc_isMedic;
	_healed = switch (true) do {
		case ( _isMedic && _firstAider call mpsf_fnc_hasMedKit ) : { 0 };
		case ( _isMedic && _firstAider call mpsf_fnc_hasFirstAidKit ) : { _firstAider spawn mpsf_fnc_useFirstAidKit; 0.25 };
		case ( !(_isMedic) && _firstAider call mpsf_fnc_hasFirstAidKit ) : { _firstAider spawn mpsf_fnc_useFirstAidKit; 0.5 };
		default { 0.7 };
	};
	_unitInAgony setVariable ["mpsf_injury_healedDamage",_healed,true];
	_unitInAgony setVariable ["mpsf_injury_inAgony",false,true];
} else {
	hint "First Aid Canceled!";
};

mpsf_VAR_HealingStatus = false;
