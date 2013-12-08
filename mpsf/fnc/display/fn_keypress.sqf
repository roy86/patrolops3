/*
	Author: Eightysix

	Description:
		Not to be called directly.

*/
if(!mpsfCLI) exitWith {};

private["_key"];

_key = _this select 1;
_handled = false;

switch (_key) do{
	case 0x16 : { call mpsf_fnc_GUI_display; _handled = true; };
};

/*
	case 0x16;	// Key: U
	case 0xDB;	// Key: Left Windows
	case 0xDC;	// Key: Right Windows
	case 0xDD;	// Key: AppsMenu key
	case 0x37;	// Key: * on numeric keypad
*/

_handled