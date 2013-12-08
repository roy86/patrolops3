private["_unit"];

_unit = _this select 0;

_group = group _unit;
_side = side _group;

if(_unit getVariable ["mpsf_injury_inAgony",false]) exitWith {};
if(_unit == player) then {
	true call mpsf_fnc_setActionBusy;
};

//apply a blood effect, this gets over written by the setdamage later
_unit setHit ["hands",1];
_unit setHit ["legs",1];

if (vehicle _unit != _unit) then {
	unAssignVehicle _unit;
	_unit action ["eject", vehicle _unit];
	sleep 2;
	waitUntil{ _unit == vehicle _unit && ((position _unit) select 2) < 1 };
	_unit setVelocity [0,0,0];
};

[_side,"SIDE",format[localize "STR_MPSF_INJURY_ISDOWN",name _unit,mapGridPosition _unit] ] call mpsf_fnc_sendChat;

_unit setVariable ["mpsf_injury_healedDamage",_unit getVariable ["mpsf_injury_totalDamage",0],true];
_unit setVariable ["mpsf_injury_inAgony",true,true];
[_unit,"Injured_AgonyStart"] call mpsf_fnc_animateUnit;//_unit switchMove "AinjPpneMstpSnonWrflDnon";

[_unit] spawn mpsf_fnc_injuredEffects;
[_unit] spawn mpsf_fnc_injuredBloodLoss;

[] spawn {
	while {player getVariable "mpsf_injury_inAgony"} do {
		waitUntil{ sleep 1; !(player getVariable "mpsf_injury_inAgony") || !(alive player) || (vehicle player != player) };
		if !(player getVariable "mpsf_injury_inAgony") exitwith {};

		if(vehicle player != player) then {
			unAssignVehicle player;
			player action ["eject", vehicle player];
			sleep 2;
			player setVelocity [0,0,0];
			[player,"Injured_AgonyStart"] call mpsf_fnc_animateUnit;
			[true,"HINT","You are to injured to be transported"] call mpsf_fnc_hint;
		};
	};
};

[] spawn {
	while {player getVariable ["mpsf_injury_inAgony",false]} do
	{
		waitUntil{sleep 1; !(stance player == "PRONE")};
		if(player getVariable ["mpsf_injury_inAgony",false]) then
		{
			hint "You are too injured to stand!";
			[player,"Injured_AgonyStart"] call mpsf_fnc_animateUnit;
		};
	};
};

sleep 1;
_unit allowDamage false;
waitUntil{
	!(alive _unit) || !(_unit getVariable ["mpsf_injury_inAgony",false])
};

_unit allowDamage true;
sleep 1;

_unit setVariable ["mpsf_injury_inAgony",false,true];
[_unit,"Injured_AgonyEnd"] call mpsf_fnc_animateUnit;

if(_unit == player) then {
	false call mpsf_fnc_setActionBusy;
};

if(alive _unit) then {
	_unit setVariable ["mpsf_injury_totalDamage",_unit getVariable ["mpsf_injury_healedDamage",0],false];
	_unit setDamage (_unit getVariable ["mpsf_injury_healedDamage",0]);
	if !(isNull (_unit getVariable ["mpsf_injury_healer",objNull])) then {
		[_group,"SIDE",format[localize "STR_MPSF_INJURY_ISUP1",name _unit,name (_unit getVariable ["mpsf_injury_healer",objNull])] ] call mpsf_fnc_sendChat;
	}else{
		[_group,"SIDE",format[localize "STR_MPSF_INJURY_ISUP2",name _unit] ] call mpsf_fnc_sendChat;
	};
}else{
	[_group,"GROUP",format[localize "STR_MPSF_INJURY_ISNOTUP",name _unit] ] call mpsf_fnc_sendChat;
};

_unit setVariable ["mpsf_injury_dragger",objNull,true];
_unit setVariable ["mpsf_injury_healer",objNull,true];
