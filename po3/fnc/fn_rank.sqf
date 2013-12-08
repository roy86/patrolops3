private["_values","_score","_cr","_nr"];

mpsf_fnc_rankUpdate = {
	private["_id","_new_rank"];

	_id = _this select 0;
	_new_rank = _this select 1;

	_id setRank _new_rank;
};

"mpsf_pVAR_rankUpdate" addpublicVariableEventHandler { (_this select 1) spawn mps_rank_update };

_values = [0,500,1500,2500,3500,5000,7500];

while {true} do {
	_score = rating player;
	_cr = toUpper(rank player);
	_nr = toUpper(rank player);

	waitUntil {(rating player) != _score || (rating player) < 0};
	waitUntil { alive player };

	if((rating player <  (_values select 1)) ) then { _nr = "PRIVATE"	};
	if((rating player >= (_values select 1)) ) then { _nr = "CORPORAL"	};
	if((rating player >= (_values select 2)) ) then { _nr = "SERGEANT"	};
	if((rating player >= (_values select 3)) ) then { _nr = "LIEUTENANT"	};
	if((rating player >= (_values select 4)) ) then { _nr = "CAPTAIN"	};
	if((rating player >= (_values select 5)) ) then { _nr = "MAJOR"		};
	if((rating player >= (_values select 6)) ) then { _nr = "COLONEL"	};

	if( rating player < 0 ) then {
		_score = (-1*_score);
		player addrating _score;
		_score = rating player;
	};

	if( rating player > _score && _nr != _cr && mps_rank_sys_enabled ) then {
		mpsf_pVAR_rankUpdate = [player,_nr]; publicVariable "mpsf_pVAR_rankUpdate";
		mps_rank_chg spawn mps_rank_update;
		mission_sidechat = format["%1 was promoted to %2",name player,_nr]; publicVariable "mission_sidechat";

		_score = rating player;
		_cr = _nr;

		sleep 1;
	}else{
		if( rating player < _score && _nr != _cr && mps_rank_sys_enabled ) then {
			mpsf_pVAR_rankUpdate = [player,_nr]; publicVariable "mpsf_pVAR_rankUpdate";
			mps_rank_chg spawn mps_rank_update;
			mission_sidechat = format["%1 was demoted to %2",name player,_nr]; publicVariable "mission_sidechat";

			_score = rating player;
			_cr = _nr;

			sleep 1;
		};
	};
};
