private["_worldradius","_all","_locations","_locBSE","_locCTY","_locHIL","_locPOI","_locTWN","_locWTR"];

{
	_position = _x call mpsf_fnc_getPos;
	if(_position distance [0,0,0] > 10) then {
		_location = createLocation ["NameLocal", _position, 200, 200];
		_location setText "Military Post";
		_location setName "Military Post";
		["PO3",format["po3_fnc_registerLocations: New Location registered %1",_location]] call mpsf_fnc_log;
	};
}forEach [
	 "po3_loc_military_1","po3_loc_military_2","po3_loc_military_3","po3_loc_military_4","po3_loc_military_5"
	,"po3_loc_military_6","po3_loc_military_7","po3_loc_military_8","po3_loc_military_9","po3_loc_military_10"
	,"po3_loc_military_11","po3_loc_military_12","po3_loc_military_13","po3_loc_military_14"
];

{
	_position = _x call mpsf_fnc_getPos;
	if(_position distance [0,0,0] > 10) then {
		_location = createLocation ["NameLocal", _position, 100, 100];
		_location setText "Resupply Base";
		_location setName "Resupply Base";
		["PO3",format["po3_fnc_registerLocations: New Location registered %1",_location]] call mpsf_fnc_log;
	};
}forEach ["po3_loc_resupplybase_1","po3_loc_resupplybase_2","po3_loc_resupplybase_3","po3_loc_resupplybase_4"];

{
	_position = _x call mpsf_fnc_getPos;
	if(_position distance [0,0,0] > 10) then {
		_location = createLocation ["Airport", _position, 300, 300];
		_location setText "Airfield";
		_location setName "Airfield";
		["PO3",format["po3_fnc_registerLocations: New Location registered %1",_location]] call mpsf_fnc_log;
	};
}forEach ["po3_loc_airport_1","po3_loc_airport_2","po3_loc_airport_3","po3_loc_airport_4","po3_loc_airport_5"];

_worldradius = 1500*Log(po3_worldsize/1000);
_all = nearestLocations [[0,0],["Airport","CityCenter","Hill","NameCity","NameCityCapital","NameLocal","NameMarine","NameVillage"],100000];

_locations = [];
_locAIR = [];
_locBSE = [];
_locCTY = [];
_locHIL = [];
_locPOI = [];
_locTWN = [];
_locWTR = [];
_locOTH = [];
_locRSP = [];

{
	if(	position _x distance getMarkerPos "respawn_west" > _worldradius &&
		position _x distance getMarkerPos "respawn_east" > _worldradius
	) then {
		switch (toLower (type _x)) do {
			case "airport"		: { _locAIR set [count _locAIR, [_x,"ColorOrange"] ] };
			case "citycenter";
			case "namecitycaptial"	: { _locCTY set [count _locCTY, [_x,"ColorOrange"] ] };
			case "namecity";
			case "namevillage"	: { if !(toLower(text _x) IN ["sagonisi"]) then { _locTWN set [count _locTWN, [_x,"ColorWhite"]] }; };
			case "namemarine"	: { if !(toLower(text _x) IN ["katalaki bay","melanera bay","pefkas bay","tonos bay"]) then { _locWTR set [count _locWTR, [_x,"ColorBlue" ]] }; };
			case "hill"		: { _locHIL set [count _locHIL, [_x,"ColorGreen"]] };
			case "namelocal"	: {
				switch ( toLower(text _x) ) do {
					case "castle";
					case "factory";
					case "mine";
					case "stadium";
					case "power plant";
					case "quarry";
					case "storage"		: { _locPOI set [count _locPOI, [_x,"ColorIndependent" ] ] };
					case "military post"	: { _locBSE set [count _locBSE, [_x,"ColorOPFOR"] ] };
					case "resupply base"	: { _locRSP set [count _locRSP, [_x,"ColorRed"] ] };
					default { _locOTH set [count _locOTH, [_x,"ColorBlack"] ] };
				};
			};
			default { _locOTH set [count _locOTH, [_x,"ColorBlack"] ] };
		};
	};
} foreach _all;

if(mpsf_debug) then {
	{
		_marker = createMarkerlocal [format["%1",random 999],position (_x select 0)];
		_marker setMarkerShapelocal "ICON";
		_marker setMarkerTypelocal "mil_dot";
		_marker setMarkerColorlocal (_x select 1);
		_marker setMarkerSizeLocal [0.5,0.5];
	//	_marker setMarkerTextLocal format["%1",type (_x select 0),toUpper(text (_x select 0))];
	} foreach (_locPOI+_locTWN+_locCTY+_locBSE+_locHIL+_locWTR+_locRSP);
};

po3_pos_allowed = [_locBSE,_locCTY,_locHIL,_locTWN,_locWTR,_locPOI,_locAIR,_locOTH,_locRSP];
["PO3",format["po3_fnc_registerLocations: Locations %1",po3_pos_allowed]] call mpsf_fnc_log;

po3_pos_allowed;