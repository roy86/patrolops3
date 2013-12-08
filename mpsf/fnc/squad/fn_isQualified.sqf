private["_unit","_qual","_curr","_return"];

_unit = _this select 0;
_qual = _this select 1;
_curr = _unit getVariable ["mpsf_VAR_roleAttribute","Rifleman"];

_return = switch (toLower _qual) do {
	case "fly";
	case "pilot" : { if( _curr == "Pilot") then { true }else{ false }; };
	case "crew";
	case "crewman" : { if( _curr == "Crewman") then { true }else{ false }; };
	case "healer";
	case "medic" : { if( _curr == "Medic") then { true }else{ false }; };
	default { if( toLower(_qual) == tolower(_curr) ) then { true }else{ false }; };
};

_return;