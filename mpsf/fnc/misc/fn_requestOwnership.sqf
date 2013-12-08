if!(mpsfCLI) exitWith {};

private["_object","_requestor","_timer","_return"];

_object = _this select 0;
_requestor = _this select 1;

if(local _object) exitWith { true };

mpsf_brdcst_serverRequest = false;
mpsf_brdcst_requestOwnerChange = [_object,_requestor]; publicVariableServer "mpsf_brdcst_requestOwnerChange";

_timer = 3;
waitUntil { _timer = _timer - 1; (_timer <= 0 || mpsf_brdcst_serverRequest) };

_return = if(local _object) then { true }else{ false };

_return;