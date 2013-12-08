private["_injured"];

_injured = if(count _this > 2) then { _this select 3 }else{ _this select 0 };
_injured setVariable ["mpsf_injury_dragger",objNull,true];