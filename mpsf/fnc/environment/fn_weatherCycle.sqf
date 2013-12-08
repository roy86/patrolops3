/*
	Author: Eightysix

	Description:
		Inspired by Meatballs weather cycle but re-written and MP compatible

	Syntax:

*/

if !(mpsfSRV) exitWith {};

waitUntil {!isnil "mpsf_pVAR_weatherCycle"};

while {true} do {
	sleep 600;

// Overcast
	_randOvercast = (round((random(0.3)-0.15)*100))/100;
	_forecastOvercast = (mpsf_pVAR_weatherCycle select 0) + _randOvercast;
	if (_forecastOvercast > 1) then {_forecastOvercast = _forecastOvercast - (2*_randOvercast)};
	if (_forecastOvercast < 0) then {_forecastOvercast = _forecastOvercast + (abs(2*_randOvercast))};
	mpsf_pVAR_weatherCycle set [0,_forecastOvercast];

// Rain
	_forecastRain = if( (mpsf_pVAR_weatherCycle select 0) > 0.68) then { random (mpsf_pVAR_weatherCycle select 0) }else{ 0 };
	mpsf_pVAR_weatherCycle set [1,_forecastRain];

// Fog Daily Cycle
	_fog = date select 3;
	if(mpsf_a3) then {
		_v = sin( _fog/2.443 ) * 0.6;		// Value
		_d = sin( _fog/2.443 ) * 0.2;		// Decay/Falloff
		_b = sin( _fog/2.443 ) * 11;		// Base
		_fog = [_v,_d,_b]
	}else{
		if(_fog  > 1 || _fog <= 0 ) then { _fog = abs(0.001 max ((_fog / 10) min 1)) };
	};
	mpsf_pVAR_weatherCycle set [2,_fog];

// East Wind
	_forecastWindE = random (0.4);
	mpsf_pVAR_weatherCycle set [3,_forecastWindE];

// North Wind
	_forecastWindN = random (0.4);
	mpsf_pVAR_weatherCycle set [4,_forecastWindN];


// Configure weather settings on server to match next 10 minute weather forecast.
	publicVariable "mpsf_pVAR_weatherCycle";
	["Weather",format["Weather Cycle change at %1 to %2",date,mpsf_pVAR_weatherCycle ],true] call mpsf_fnc_log;

	[mpsf_pVAR_weatherCycle select 0, 60] spawn mpsf_fnc_setOvercast;
	[mpsf_pVAR_weatherCycle select 1, 60] spawn mpsf_fnc_setRain;
	[mpsf_pVAR_weatherCycle select 2, 60] spawn mpsf_fnc_setFog;
	[mpsf_pVAR_weatherCycle select 3,mpsf_pVAR_weatherCycle select 3] spawn mpsf_fnc_setWind;
};