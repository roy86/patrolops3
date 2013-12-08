private["_types"];

_types = _this;
_array = [];

{ _array = _array + (po3_preDefinedEnemyVehicles select _x) }forEach _types;

["PO3",format["po3_fnc_getVehicleTypes: Returned %1 from %2",_array,_types] ] call mpsf_fnc_log;

_array;