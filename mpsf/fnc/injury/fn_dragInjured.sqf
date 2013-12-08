if(!mpsfCLI) exitWith {};
if( player call mpsf_fnc_checkActionBusy ) exitWith {};

private["_injured","_dragger"];

_injured = _this select 0;
_dragger = _this select 1;

if( _injured getVariable ["mpsf_injury_BeingHealed",false] ) exitWith { [ format["%1 is being assisted. You cannot move them.",name _injured] ] call mpsf_fnc_hint };
if( _injured getVariable ["mpsf_injury_BeingDragged",false] ) exitWith { [ format["%1 is being assisted. You cannot move them.",name _injured] ] call mpsf_fnc_hint };

true call mpsf_fnc_setActionBusy;

_injured attachTo [_dragger, [0, 1.1, 0.092]];
_injured setDir 180;

[_injured,"Draggee_Start"] call mpsf_fnc_animateUnit;
[_dragger,"Dragger_Start"] call mpsf_fnc_animateUnit;
_injured setVariable ["mpsf_injury_dragger",_dragger, true];

_dragAction = _dragger addAction [format["<t color=""#FFC600"">Drop %1</t>",name _injured],{ _this call mpsf_fnc_dropInjured }, _injured, 1, true, true, "", "true"];

sleep 1;
waitUntil{
	!(alive _injured) ||
	!(alive _dragger) ||
	!([_injured] call mpsf_fnc_injuredIsBeingDragged)
};

detach _injured;
[_injured,"Draggee_End"] call mpsf_fnc_animateUnit;//_injured playMoveNow "AinjPpneMstpSnonWrflDb_release";
_injured setVariable ["mpsf_injury_dragger",objNull,true];

[_dragger,"Dragger_End"] call mpsf_fnc_animateUnit;//_dragger playMove "amovpknlmstpsraswrfldnon";
_dragger removeAction _dragAction;

false call mpsf_fnc_setActionBusy;