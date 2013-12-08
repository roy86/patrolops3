private["_unitList"];

if(isNil "mpsf_CfgSpawner_PreDefinedSquads") then { mpsf_CfgSpawner_PreDefinedSquads = [] };

_unitList = [];
{
	if(_x select 0 == _this) then {
		_unitList = _x select 1;
	};
}forEach mpsf_CfgSpawner_PreDefinedSquads;

_unitList;