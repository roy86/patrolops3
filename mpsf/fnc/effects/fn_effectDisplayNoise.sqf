disableSerialization;

private ["_cntrl","_number"];

_cntrl = _this;

for "_i" from 12 to 0 step - 1 do {
	_number = if( _i < 10 ) then { format["0%1",_i] }else{ format["%1",_i] };
	_cntrl ctrlsettext format["a3\ui_f\data\igui\rsctitles\static\feedstatic_%1_ca.paa",_number];
	_cntrl ctrlCommit 0;
	sleep 0.02;
};
