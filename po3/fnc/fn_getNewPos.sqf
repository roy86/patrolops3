private["_typename","_type","_nextloc","_return","_loc"];

if( isNil "po3_pos_curr" ) then { po3_pos_curr = [0,0,0] };
if( isNil "po3_pos_used" ) then { po3_pos_used = [] };
if( isNil "po3_pos_prev" ) then { po3_pos_prev = [0,0,0] };
if( isNil "po3_pos_allowed" ) then { po3_pos_allowed = call po3_fnc_regLocations };

_type = if( typename _this == typeName [] ) then { _this call mpsf_fnc_getArrayRandom }else{ _this };

if( count po3_pos_allowed <= 0) exitWith { [ [0,0,0], "", 0 ] };
if( count po3_pos_used >= count po3_pos_allowed ) then { po3_pos_used = [] };

_locations = switch (toLower _type) do {
	case "base" : { po3_pos_allowed select 0 };
	case "city" : { po3_pos_allowed select 1 };
	case "hill" : { po3_pos_allowed select 2 };
	case "town" : { po3_pos_allowed select 3 };
	case "bay";
	case "water";
	case "underwater" : { po3_pos_allowed  select 4 };
	case "poi" : { po3_pos_allowed select 5 };
	case "airport" : { po3_pos_allowed select 6 };
	default { po3_pos_allowed select 7 };
};

_worldradius = 1500*Log(po3_worldsize/1000);

po3_pos_curr  = nil;
while { isNil "po3_pos_curr" } do {
	po3_pos_curr = (_locations  call mpsf_fnc_getArrayRandom) select 0;
	if( !(po3_pos_curr IN po3_pos_used) && po3_pos_curr distance po3_pos_prev > (_worldradius/2) ) exitWith { po3_pos_curr };
	po3_pos_curr = nil;
};

po3_pos_used set [count po3_pos_used, po3_pos_curr];

_return = [];
switch (toLower _type) do {
	case "base";
	case "city";
	case "town";
	case "poi" : {
		_pos = [po3_pos_curr,0,0,false] call mpsf_fnc_getPos; _pos set [2,0];
		_return set [0,_pos];
		_return set [1,text po3_pos_curr];
		_return set [2,size po3_pos_curr];
	};
	case "airport" : {
		_pos = [po3_pos_curr,0,0,false] call mpsf_fnc_getPos; _pos set [2,0];
		_return set [0,_pos];
		_return set [1,text po3_pos_curr];
		_return set [2,size po3_pos_curr];
	};
	case "hill" : {
		_loc = [po3_pos_curr,10] call mpsf_fnc_getFlatArea;
		_pos = [_loc,0,0,false] call mpsf_fnc_getPos; _pos set [2,0];
		_return set [0,_pos]; 
		_return set [1,mapGridPosition (_return select 0)];
		_return set [2,50];
	};
	case "water";
	case "bay" : {
		_loc = [po3_pos_curr,0,0,true] call mpsf_fnc_getPos;
		_loc set [2,0];
		_return set [0,_loc];
		_return set [1,mapGridPosition (_return select 0)];
		_return set [2,0];
	};
	case "underwater" : {
		_loc = [po3_pos_curr,0,0,true] call mpsf_fnc_getPos;
		_loc set [2,-15];
		_return set [0,_loc];
		_return set [1,mapGridPosition (_return select 0)];
		_return set [2,0];
	};
	default {
		_loc = [po3_pos_curr,0,0,false] call mpsf_fnc_getPos;
		_loc set [2,0];
		_return set [0,_loc];
		_return set [1,mapGridPosition (_return select 0)];
		_return set [2,0];
	};
};

["PO3",format["po3_fnc_getNewPos: Location retrieved %1",_return],true] spawn mpsf_fnc_log;

po3_pos_prev = _return select 0;

_return