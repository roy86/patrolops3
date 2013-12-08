private["_lifter","_object"];

_lifter = _this select 0;
_object = _this select 1;

if !([_lifter,_object] call mpsf_fnc_isLiftable) exitWith { ["Lift",format["%1 is not liftable",_object], true] call mpsf_fnc_log; false };

mpsf_logistics_lifthook_active = false;

_attachPointLifter = [_lifter,"BASE"] call mpsf_fnc_getAttachPoint;
_attachPointObject = [_object,"TOP"] call mpsf_fnc_getAttachPoint;
_offset = [0,0,(- 4) max (( (_attachPointLifter select 2) - (_attachPointObject select 2) ) min 10)];

//Make Vehicle Local
if!(local _object) then {
	_local = [_object, player] call mpsf_fnc_requestOwnership;
	if(!_local) then { ["Unable to assign locality to you"] call mpsf_fnc_hint };
};

_object attachTo [ _lifter, _offset ];

_lifter setVariable ["mpsf_lifted",_object,false];
_object setVariable ["mpsf_lifted",_lifter,false];
[_lifter,_object] spawn mpsf_fnc_slingRope;

[ true, "HINT", format["%1 attached to %2",[_object] call mpsf_fnc_getCfgText,[_lifter] call mpsf_fnc_getCfgText] ] call mpsf_fnc_hint;

_action = _lifter addAction ["<t color='#ffc600'>Drop Cargo</t>",{ [(vehicle player)] spawn mpsf_fnc_liftRelease; },[],100,false,true,"","!isNull (_target getVariable [""mpsf_lifted"",objNull])"];

waitUntil {
	!alive _lifter ||
	!alive _object ||
	!([_lifter,_object] call mpsf_fnc_isLifted)
};

detach _object;

_lifter setVariable ["mpsf_lifted",nil,false];
_object setVariable ["mpsf_lifted",nil,false];

_lifter removeAction _action;
[ true, "HINT", format["Released %1 from %2",[_object] call mpsf_fnc_getCfgText,[_lifter] call mpsf_fnc_getCfgText] ] call mpsf_fnc_hint;

if( ((position _object) select 2) > 90 ) then {
	[_lifter,_object] call mpsf_fnc_createChute;
};