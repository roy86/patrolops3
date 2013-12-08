if!(mpsfSRV) exitWith {};

private["_return"];

_object = _this select 0;
_requestor = owner (_this select 1);

_return = _object setOwner _requestor;

mpsf_brdcst_SRVCLI = [random 99,_return]; _requestor publicVariableClient "mpsf_brdcst_SRVCLI";