private["_injured","_dragger","_return"];

_injured = _this select 0;
_dragger = _this select 1;

_return = if !(isNull {_injured getVariable ["mpsf_injury_dragger",objNull]}) then { _injured getVariable ["mpsf_injury_dragger",objNull] == _dragger }else{ false };

_return