private["_group","_requestor","_leader","_requestors"];

_group = _this select 0;
_requestor = _this select 1;

if(_requestor IN (units _group) ) exitWith { [_requestor,"HINT",format[localize "STR_MPSF_DIALOG_ALREADYINGROUP",name _group] ] call mpsf_fnc_hint };

_leader = leader _group;
_requestors = _leader getVariable ["mpsf_squadJoin_requestors",[]];

if(_requestor IN _requestors) exitWith {};

_requestors = _requestors + [_requestor];
_leader setVariable ["mpsf_squadJoin_requestors",_requestors,true];

[_leader,"HINT",format[localize "", name _requestor]] call mpsf_fnc_sendHint;
[_requestor,"HINT",format[localize "",name _group] ] call mpsf_fnc_hint;

true