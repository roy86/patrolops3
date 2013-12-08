/*
	Author: Eightysix

	Description:
	Returns Marker Type of the type vehicle the unit or group is operating.

	Syntax:
	_Type = (unit/group/vehicle) call mpsf_fnc_getObjectMarkerType;

*/
if(mpsfCLI) then {
	date call mpsf_fnc_setTime; //setDate date;
};

if(mpsf_param_ambient_weather_enable) then {
	if(mpsfSRV) then {
		mpsf_pVAR_weatherCycle = [0.49,0,0,0.1,0.1];	publicVariable "mpsf_pVAR_weatherCycle";
	};

	if(mpsfCLI) then {
		waitUntil {!isnil "mpsf_pVAR_weatherCycle"};
		"mpsf_pVAR_weatherCycle" addPublicVariableEventHandler	{
			(_this select 1) spawn {
				[_this select 0,60] spawn mpsf_fnc_setOvercast;
				[_this select 1,60] spawn mpsf_fnc_setRain;
				[_this select 2,60] spawn mpsf_fnc_setFog;
				[_this select 3,_this select 4] spawn mpsf_fnc_setWind;
			};
		};
	};

	skiptime -24;
	[mpsf_pVAR_weatherCycle select 0,86400] spawn mpsf_fnc_setOvercast;
	[mpsf_pVAR_weatherCycle select 1,86400] spawn mpsf_fnc_setRain;
	[mpsf_pVAR_weatherCycle select 2,86400] spawn mpsf_fnc_setFog;
	[mpsf_pVAR_weatherCycle select 3,mpsf_pVAR_weatherCycle select 4] spawn mpsf_fnc_setWind;
	skipTime 24;

	[] spawn mpsf_fnc_weatherCycle;
};