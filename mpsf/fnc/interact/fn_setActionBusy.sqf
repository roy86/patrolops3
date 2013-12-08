/*
	MPSF Function - mpsf_action_setBusy

	Sets BOOLEAN of player action status. Used to prevent player from performing additional tasks whilst occupied.

	Written By: Eightysix

	Params:
	0 - State of player action (True = Busy, False = Not Busy)

	Returns:
	NIL
*/

if(typeName _this != "BOOL") exitWith { ["Incorrect Parameter for Busy Action"] call mpsf_fnc_hint };

mpsf_playerIsBusy = _this;

if(mpsf_playerIsBusy) then {
	if( !isNil "mpsf_playerBusy_loop") then { terminate mpsf_playerBusy_loop };

	mpsf_playerBusy_loop = [] spawn {
		waitUntil {sleep 0.2; !alive player || !mpsf_playerIsBusy };
		mpsf_playerIsBusy = false;
	};
};

if(!mpsf_playerIsBusy) then {
	if( !isNil "mpsf_playerBusy_loop") then { terminate mpsf_playerBusy_loop };

	mpsf_playerBusy_loop = nil;
};