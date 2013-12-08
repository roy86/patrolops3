player createDiarySubject ["po3WB","Patrol Ops WIKI"];
player createDiaryRecord ["po3WB",["Ambient Patrols",format ["%1%2",
	if( po3_param_ambientpatrolair ) then { "The enemy have deployed Air Patrols over the area of operations.<br/>Seek out and destroy the enemy JTAC to prevent them from orgainising their AIR FORCES<br/><br/>" }else{""},
	if( po3_param_ambientpatrolinf ) then { "The enemy have deployed Ground Patrols over the area.<br/>Seek out and destroy the enemy COMMANDER to prevent them from orgainising further PATROLS<br/><br/>" }else{""}
	]
]];