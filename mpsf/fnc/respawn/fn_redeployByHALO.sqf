/*
    Author: Eightysix

    Description:

*/
private["_position","_unit"];

if(!mpsf_param_respawn_halo_allow) exitWith { [localize "STR_MPSF_RESPWN_CNTDEPLY6"] call mpsf_fnc_hintc };
if( mpsf_respawn_halo_nextAvailable > (mpsf_param_respawn_halo_time + time) ) exitWith {
    [ format[localize "STR_MPSF_RESPWN_CNTDEPLY7", ceil mpsf_respawn_halo_nextAvailable] ] call mpsf_fnc_hintc;
};

_unit = player;
_position = _this select 1;

[_unit,_position,2000] spawn mpsf_fnc_halo;

mpsf_player_respawned_byHALO = true;
mpsf_player_respawned = true;
true call mpsf_fnc_setActionBusy;

// FREEFALL or Die
waitUntil {animationState _unit == "HaloFreeFall_non" || (getPos _unit select 2) < 1};
mpsf_respawn_halo_nextAvailable = time + mpsf_param_respawn_halo_time;

// PARACHUTE or Die
waitUntil {animationState _unit == "para_pilot" || (getPos _unit select 2) < 1};

// LANDED or Die
waitUntil {isTouchingGround _unit || (getPos _unit select 2) < 1};

false call mpsf_fnc_setActionBusy;
