/*
	Author: Eightysix

	Description:
	
*/
private["_changer","_effsleep"];

if(!isNil "mpsf_effect_video_blur") then { ppEffectDestroy mpsf_effect_video_blur; mpsf_effect_video_blur = nil; };
if(!isNil "mpsf_effect_video_colour") then { ppEffectDestroy mpsf_effect_video_colour; mpsf_effect_video_colour = nil; };
if(!isNil "mpsf_effect_video_grain") then { ppEffectDestroy mpsf_effect_video_grain; mpsf_effect_video_grain = nil; };

if(mpsf_a3) then {
	("BIS_layerEstShot" call BIS_fnc_rscLayer) cutRsc ["RscEstablishingShot", "PLAIN"];
};

mpsf_effect_video_blur = ppEffectCreate ["DynamicBlur", 450];
mpsf_effect_video_blur ppEffectEnable true;
mpsf_effect_video_blur ppEffectAdjust [0.6+random 0.4];
mpsf_effect_video_blur ppEffectCommit 2;

mpsf_effect_video_colour = ppEffectCreate ["ColorCorrections", 1587];
mpsf_effect_video_colour ppEffectEnable true;
mpsf_effect_video_colour ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [0.8, 0.8, 0.8, 0.65], [1, 1, 1, 1.0]];
mpsf_effect_video_colour ppEffectCommit 2;

mpsf_effect_video_grain = ppEffectCreate ["filmGrain", 2012];
mpsf_effect_video_grain ppEffectEnable true;
mpsf_effect_video_grain ppEffectAdjust [0.1, 1, 1, 0, 1];
mpsf_effect_video_grain ppEffectCommit 0;

sleep 2;

_changer = [] spawn {
	while {true} do {
		mpsf_effect_video_blur ppEffectAdjust [0.8+random 0.2];
		mpsf_effect_video_blur ppEffectCommit (random 1.5);
		sleep (1.5+random 2);
	};
};

waitUntil{mpsf_player_respawned};

terminate _changer;

if(mpsf_a3) then {
	("BIS_layerEstShot"call BIS_fnc_rscLayer) cutRsc ["RscStatic", "PLAIN"];
};

ppEffectDestroy mpsf_effect_video_blur;
ppEffectDestroy mpsf_effect_video_colour;
ppEffectDestroy mpsf_effect_video_grain;