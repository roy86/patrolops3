#define HCAM_UI_DISP (uiNamespace getVariable "hcam_ui_disp")
#define HCAM_CTRL_PIP (uiNamespace getVariable "hcam_ctrl_pip")
#define HCAM_CTRL_BACK (uiNamespace getVariable "hcam_ctrl_back")
#define HCAM_CTRL_FRONT (uiNamespace getVariable "hcam_ctrl_front")
#define HCAM_CTRL_TITLE (uiNamespace getVariable "hcam_ctrl_title")
#define RADAR_BG1 (uiNamespace getVariable "mpsf_liftChopper_radarBG")
#define RADAR_BG2 (uiNamespace getVariable "mpsf_liftChopper_radar")
#define RADAR_TGT (uiNamespace getVariable "mpsf_liftChopper_target")
#define MPSF_LIFTRADAR_X ((SafeZoneX+SafeZoneW/2) - (5.6 * (((safezoneW / safezoneH) min 1.2) / 40))/2)
#define MPSF_LIFTRADAR_Y (( SafeZoneY+SafeZoneH ) - (5.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))*3)
#define MPSF_LIFTRADAR_X_MAX (MPSF_LIFTRADAR_X + (5.6*(((safezoneW / safezoneH) min 1.2)/40)) )
#define MPSF_LIFTRADAR_Y_MAX (MPSF_LIFTRADAR_Y + (5.6 * ((( (safezoneW / safezoneH) min 1.2) / 1.2) / 25)))
#define MPSF_LIFTCAMERA_IDD 86100

private["_vehicle","_hookSphere","_targetSphere","_action","_vehiclePos"];

if(mpsf_logistics_lifthook_active) exitWith { mpsf_logistics_lifthook_active = false };
mpsf_logistics_lifthook_active = true;

_vehicle = (vehicle player);
[_vehicle] spawn mpsf_fnc_detectLiftable;

_hookSphere = "Sign_Sphere10cm_F" createVehicleLocal position player;
_hookSphere attachTo [ (vehicle player), [0,0,-2.5] ];
hideObject _hookSphere;
_targetSphere = "Sign_Sphere10cm_F" createVehicleLocal position player;
_targetSphere attachTo [ (vehicle player), [0,2,-4] ];
hideObject _targetSphere;

hcam_cam = "camera" camCreate getPos _vehicle;
waitUntil {hcam_cam != ObjNull};

MPSF_LIFTCAMERA_IDD cutRsc ["mpsf_HcamDialog", "PLAIN"];
HCAM_CTRL_PIP ctrlsettext "#(argb,256,256,1)r2t(rendertarget0,1.0)";
(MPSF_LIFTCAMERA_IDD + 1) cutRsc ["mpsf_LiftChopper_HUD", "PLAIN", 0, false];

hcam_cam attachTo [ _hookSphere, [0,0,0] ];
hcam_cam camSetFov 0.6;
hcam_cam camSetTarget _targetSphere;
hcam_cam camCommit 0.1;
hcam_cam cameraEffect ["INTERNAL", "BACK","rendertarget0"];

"rendertarget0" setPiPEffect [3, 1, 0.8, 1, 0.1, [0.3, 0.3, 0.3, -0.1], [1.0, 0.0, 1.0, 1.0], [0, 0, 0, 0]];

hcam_active = true;
mpsf_logistics_liftableObject = objNull;

sleep 1;
_action = nil;
while { mpsf_logistics_lifthook_active && _vehicle == (vehicle player)} do {
	if (currentVisionMode player == 1) then { camUseNVG true }else{ camUseNVG false };

	{
		if( [_vehicle,_x] call mpsf_fnc_isLiftable ) exitWith {
			mpsf_logistics_liftableObject = _x;
			hcam_cam camSetTarget _x;
			hcam_cam camCommit 0.1;
			HCAM_CTRL_TITLE ctrlsettext ([mpsf_logistics_liftableObject] call mpsf_fnc_getCfgText);

			_vehiclePos = getPos _vehicle;
			_px = _vehiclePos select 0;
			_py = _vehiclePos select 1;
			_pz = _vehiclePos select 2;

			_targetPos = getPos _x;
			_nx = _targetPos select 0;
			_ny = _targetPos select 1;

			if( (_px <= _nx + 3 && _px >= _nx - 3) && (_py <= _ny + 3 && _py >= _ny - 3) && (_pz > 4 && _pz < 11) ) then {
				if(isNil "_action") then { _action = _vehicle addAction [format["<t color='#ffc600'>Lift %1</t>",[mpsf_logistics_liftableObject] call mpsf_fnc_getCfgText],{ [(vehicle player),mpsf_logistics_liftableObject] spawn mpsf_fnc_liftObject; },[],100,true,true,"","if !(isNull mpsf_logistics_liftableObject) then { !([mpsf_logistics_liftableObject] call mpsf_fnc_isLifted) }else{ true }"] };
			}else{
				if(!isNil "_action") then { _vehicle removeAction _action; _action = nil; };
			};

			if( !([mpsf_logistics_liftableObject] call mpsf_fnc_isLifted) && _vehicle distance mpsf_logistics_liftableObject < 30) then {
				_objectPos	= _vehicle worldToModel (getPosATL mpsf_logistics_liftableObject);
				_cordsX		= _objectPos select 0;
				_cordsY		= _objectPos select 1;
				_iconX		= (MPSF_LIFTRADAR_X + ( (MPSF_LIFTRADAR_X_MAX - MPSF_LIFTRADAR_X)/2 - 0.015) ) + (((MPSF_LIFTRADAR_X_MAX - MPSF_LIFTRADAR_X)/2 - 0.015) * (_cordsX / 10));
				_iconY		= (MPSF_LIFTRADAR_Y + ( (MPSF_LIFTRADAR_Y_MAX - MPSF_LIFTRADAR_Y)/2 - 0.020) ) - (((MPSF_LIFTRADAR_Y_MAX - MPSF_LIFTRADAR_Y)/2 - 0.020) * (_cordsY / 10));

				switch (true) do {
					case ( _pz < 4 ) : { RADAR_TGT ctrlsettext "\A3\ui_f\data\gui\Rsc\RscDisplayArcadeMap\icon_sidebar_hide_up.paa" };
					case ( _pz > 10 ) : { RADAR_TGT ctrlsettext "\A3\ui_f\data\gui\Rsc\RscDisplayArcadeMap\icon_sidebar_show_down.paa" };
					default { RADAR_TGT ctrlsettext "\A3\ui_f\data\gui\Rsc\RscDisplayConfigViewer\bookmark_gs.paa" };
				};

				RADAR_BG1 ctrlShow true;
				RADAR_BG1 ctrlCommit 0;
				RADAR_BG2 ctrlShow true;
				RADAR_BG2 ctrlCommit 0;
				RADAR_TGT ctrlShow true;
				RADAR_TGT ctrlsetposition [_iconX,_iconY];
				RADAR_TGT ctrlCommit 0;
			}else{
				RADAR_BG1 ctrlShow false;
				RADAR_BG1 ctrlCommit 0.2;
				RADAR_BG2 ctrlShow false;
				RADAR_BG2 ctrlCommit 0.2;
				RADAR_TGT ctrlShow false;
				RADAR_TGT ctrlCommit 0;
			};
		};

		if(!isNil "_action") then { _vehicle removeAction _action; _action = nil; };
	}forEach (nearestObjects [_vehicle,['ALL'],30]);

	if(isNull mpsf_logistics_liftableObject ) then {
		RADAR_BG1 ctrlShow false;
		RADAR_BG1 ctrlCommit 0.2;
		RADAR_BG2 ctrlShow false;
		RADAR_BG2 ctrlCommit 0.2;
		RADAR_TGT ctrlShow false;
		RADAR_TGT ctrlCommit 0;
	};
	sleep 1;
};

if(!isNil "_action") then { _vehicle removeAction _action; _action = nil; };
hcam_cam cameraEffect ["TERMINATE", "BACK"];
hcam_active = false;
deleteVehicle _hookSphere;
deleteVehicle _targetSphere;
MPSF_LIFTCAMERA_IDD cutFadeOut 0;
(MPSF_LIFTCAMERA_IDD + 1) cutFadeOut 0;
