/*
	MPSF Function - mpsf_action_isBusy

	Returns BOOLEAN of player action status and hints if TRUE

	Written By: Eightysix

	Params:
	None

	Returns:
	BOOLEAN of player state
*/

if(isNil "mpsf_playerIsBusy") then { mpsf_playerIsBusy = false };

if( mpsf_playerIsBusy ) then { [localize "STR_MPSF_ACTION_BUSY"] call mpsf_fnc_hint };

mpsf_playerIsBusy;