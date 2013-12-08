private["_blackside","_countConnectedPlayers","_factor"];

_blackside = if(!isNil "_this") then { _this }else{ [] };

if(isNil "po3_Sides") then {
	po3_Sides = [];
	if(isNil "po3_side_1") then { po3_side_1 = [civilian] };
	if(isNil "po3_side_2") then { po3_side_2 = [civilian] };
	if(isNil "po3_side_3") then { po3_side_3 = [civilian] };

	{
		if( (_x select 0) IN [east,west,resistance] && !( (_x select 0) IN po3_Sides) ) then {
			po3_Sides set [count po3_Sides, _x select 0];
		};
	}forEach [po3_side_1,po3_side_2,po3_side_3];
};

_countConnectedPlayers = 0;
{
	if !(_x IN _blackside) then {
		_countConnectedPlayers = _countConnectedPlayers + playersNumber _x;
	};
}forEach po3_sides;

_factor = 2 max round( random(_countConnectedPlayers/3) min 8);

[_factor,_countConnectedPlayers];