private["_position","_payload","_chuteType"];

_position = (_this select 0) call mpsf_fnc_getPos;
_payload = _this select 1;
_requestor = _this select 2;

if((_position select 2) < 50 ) exitWith { [true,"HINT",format[localize "STR_MPSF_LOGIST_SUPPLYDROPFAIL0",[_payload] call mpsf_fnc_getCfgText] ] call mpsf_fnc_hint; false };

if!(local _payload) then {
	_local = [_payload, player] call mpsf_fnc_requestOwnership;
	if(!_local) then { ["Unable to assign locality to you"] call mpsf_fnc_hint };
};

[_requestor,_position,_payload] spawn {
	private["_position","_payload","_chuteType","_requestor"];

	_requestor = _this select 0;
	_position = _this select 1;
	_payload = _this select 2;

	_chuteType = ['B_Parachute_02_F', 'O_Parachute_02_F', 'I_Parachute_02_F'] select ([WEST, EAST, RESISTANCE] find side _requestor);

	_chute = createVehicle [_chuteType, _position, [], 0, 'FLY'];
	_chute setPos [_position select 0, _position select 1, (_position select 2) - 50];
	_payload attachTo [_chute, [0, 0, -1.3]];

	sleep 1;
	waitUntil{ ( (position _payload) select 2) < 0.5 || isNull _chute || isTouchingGround _payload };

	detach _payload;
	deleteVehicle _chute;
};

[side (_requestor),"SIDE",format [localize "STR_MPSF_LOGIST_SUPPLYDROP0",name _requestor,[_payload] call mpsf_fnc_getCfgText,mapGridPosition _position] ] call mpsf_fnc_sendChat;

true;
