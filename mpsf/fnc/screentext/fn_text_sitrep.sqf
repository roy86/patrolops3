/*
	Author: Eightysix

	Description:
	Create Sitrep : Local Only
*/
if(isNil "mpsf_text_sitrep_display") then { mpsf_text_sitrep_display = false };
if(mpsf_text_sitrep_display) exitWith {};

disableserialization;

mpsf_text_sitrep_display = true;

_sitrepArray = toarray (_this select 0);
{_sitrepArray set [_foreachindex,tostring [_x]]} foreach _sitrepArray;
_sitrep = "";
_sitrepFormat = "<t align='left' font='EtelkaMonospaceProBold' shadow='1'>%1</t>";

_display = uinamespace getvariable ["mpsf_screentext_sitrep_text",objNull];
if(isNull _display) then {
	if (isnil "mpsf_hudtext_n") then { mpsf_hudtext_n = 2733;};

	mpsf_hudtext_n cutrsc ["mpsf_screentext_sitrep","plain"];
	mpsf_hudtext_n = mpsf_hudtext_n + 1;

	_display = uinamespace getvariable ["mpsf_screentext_sitrep_text",objNull];
};

_control = _display displayctrl 860006;
_control ctrlsetstructuredtext parseText "";
_control ctrlSetFade 0;
_control ctrlCommit 0;

for "_i" from 0 to (count _sitrepArray - 1) do {
	_letter = _sitrepArray select _i;
	_delay = if ( _letter == "|" ) then { _letter = "<br />"; 1 } else { 0.01 };
	_sitrep = _sitrep + _letter;
	_control ctrlsetstructuredtext parsetext format [_sitrepFormat,_sitrep + "_"];
	sleep _delay;
	if (isnull _control) exitwith {};
};

_control ctrlsetstructuredtext parsetext format [_sitrepFormat,_sitrep];
sleep 4;
_control ctrlSetFade 1;
_control ctrlCommit 2;
waitUntil {ctrlCommitted _control};

_control ctrlsetstructuredtext parseText "";

mpsf_text_sitrep_display = false;