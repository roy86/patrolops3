private["_group","_title"];

_group = _this select 0;
_title = _this select 1;

_group setGroupId [format["%1",_title] ];

true