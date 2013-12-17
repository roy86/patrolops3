// =========================================================================================================
// !!  DO NOT MODIFY THIS FILE  !!
// =========================================================================================================

//class cfgFunctions{
	class MPSF {
		tag = "mpsf";

		class AI {
			file = "mpsf\fnc\ai";
			class groupAmbushPos		{ description = "MPSF COMMAND - Set a group to wait in ambush near a position"; };
			class groupAttackPos		{ description = "MPSF COMMAND - Set a group to attack a position"; };
			class groupDefendPos		{ description = "MPSF COMMAND - Set a group to defend a position"; };
			class groupPatrolArea		{ description = "MPSF COMMAND - Set a group to patrol randomly around a position"; };
			class groupMove				{ description = "(WIP)MPSF COMMAND - Set a group to occupy nearby vehicles and convoy along a path"; };
			class groupOccupyVehicle	{ description = "(WIP)MPSF COMMAND - Set a group to occupy a set vehicle"; };
		};

		class Arrays {
			file = "mpsf\fnc\arrays";
			class addToarray			{ description = "MPSF COMMAND - Add data to an array"; };
			class arrayShuffle			{ description = "MPSF COMMAND - Shuffle a single dimensional array"; };
			class consolidateArray		{ description = "MPSF COMMAND - Finds duplicities in array of strings and consolidates it to the associative array."; };
			class getArrayRandom		{ description = "MPSF COMMAND - Return a random data value from a given array"; };
			class processParams			{ description = "MPSF CORE Engine- Proccess the mission parameters"; };
			class sortBy				{ description = "MPSF COMMAND - Sorts an array according to given algorithm."; };
		};

		class Camera {
			file = "mpsf\fnc\camera";
			class camera_fadein			{ description = "MPSF COMMAND - Set the given camera to fade in from black in a set time and display text"; };
			class camera_fadeout		{ description = "MPSF COMMAND - Set the given camera to fade out to black in a set time and display text"; };
			class camera_path			{ description = "MPSF COMMAND - Create a camera and move along an array of positions, objects or markers with a given target"; };
			class outrosequence			{ description = "MPSF COMMAND - Custom Outro Sequence to end mission"; };
			class camera_Restrict3rdPerson	{ description = "MPSF SYSTEM - Restricts the types of cameras available to units,drivers and crews"; };
		};

		class Configs {
			file = "mpsf\fnc\configs";
			class getCfgIcon			{ description = "MPSF COMMAND - Returns the Icon of an object"; };
			class getCfgMpsf			{ description = "(WIP)MPSF COMMAND - Returns the MPSF Configuration values"; };
			class getCfgMpsfLoadout		{ description = "(WIP)MPSF COMMAND - Returns the MPSF Loadout Configuration values"; };
			class getCfgPicture			{ description = "MPSF COMMAND - Returns the Picture of an object"; };
			class getCfgText			{ description = "MPSF COMMAND - Returns the display name of an object"; };
		};

		class Debug {
			file = "mpsf\fnc\debug";
			class log					{ description = "MPSF CORE Engine - Writes to a log and will display a hint if in debug"; };
		};

		class Display {
			file = "mpsf\fnc\display";
			class drawIcon3D			{ description = "MPSF COMMAND - draw an icon with text in 3D"; };
			class hud_getTeamColour		{ description = "MPSF COMMAND - Return unit team colour"; };
			class hud_getUnitIcon		{ description = "MPSF COMMAND - Return unit icon"; };
			class hud_assignedTeamWatcher	{ description = "MPSF SYSTEM - Syncronises ST_HUD with MPSF_HUD"; };
			class progressbar_display	{ description = "MPSF SYSTEM - Generate the progress bar"; };
			class world2Screen			{ description = "MPSF SYSTEM - Generate 3D Hud"; };
			class crewlist				{ description = "MPSF CORE Engine - WIP"; };
			class display_init			{ description = "MPSF CORE Engine - Initialise Players Huds"; };
			class GUI_display			{ description = "MPSF CORE Engine - Activate Dialogs"; };
			class GUI_settings			{ description = "MPSF CORE Engine - Undefined"; };
			class GUI_settings_slider	{ description = "MPSF CORE Engine - Undefined"; };
			class keypress				{ description = "MPSF CORE Engine - Key-press handler for MPSF functions"; };
		};

		class Effects {
			file = "mpsf\fnc\effects";
			class effectLightningStrike	{ description = "MPSF COMMAND - Creates the effect of Lightning Locally"; };
			class lightningStrike		{ description = "MPSF COMMAND - Creates the effect of Lightning Globally"; };
			class tankCookOff			{ description = "(WIP)MPSF COMMAND - Creates the exploding ammo effect in armour"; };
		};

		class Environment {
			file = "mpsf\fnc\environment";
			class changeDatetime		{ description = "MPSF COMMAND - Broadcast Environment Change of Time"; };
			class changeFogWeather		{ description = "MPSF COMMAND - Broadcast Environment Change of Fog"; };
			class changeOvercastWeather	{ description = "MPSF COMMAND - Broadcast Environment Change of Overcast"; };
			class changeRainWeather		{ description = "MPSF COMMAND - Broadcast Environment Change of Rain"; };
			class changeWindWeather		{ description = "MPSF COMMAND - Broadcast Environment Change of Wind"; };
			class skipDatetime			{ description = "MPSF COMMAND - Broadcast Environment Change of Time"; };
			class syncMPEnv				{ description = "MPSF COMMAND - Synchronises all clients upon start and JIP to the values stored by the server"; };
			class changeTime			{ description = "MPSF CORE Engine - Changes to a given time using fade in an out effects"; };
			class setFog				{ description = "MPSF CORE Engine - Changes the fog settings over a given time"; };
			class setOvercast			{ description = "MPSF CORE Engine - Changes the overcast value over time"; };
			class setRain				{ description = "MPSF CORE Engine - Changes the rain value over time"; };
			class setTime				{ description = "MPSF CORE Engine - Sets the global time"; };
			class setWind				{ description = "MPSF CORE Engine - Changes the wind values over time"; };
			class skipTime				{ description = "MPSF CORE Engine - Skips time ahead using fade in an out effects"; };
			class ambientAnimals		{ description = "MPSF SYSTEM - Creates ambient animals in an area where players are near"; };
		//	class ambientCivs			{ description = "MPSF SYSTEM - Creates ambient civilians in an area where players are near"; };
			class ambientTraffic		{ description = "MPSF SYSTEM - Creates ambient traffic in areas where players are near"; };
			class weatherCycle			{ description = "MPSF SYSTEM - Creates a Weather Cycle"; };
		};

		class EventHandlers {
			file = "mpsf\fnc\eventhandlers";
			class setContactStartEH_CRV	{ description = "MPSF COMMAND - Simple Contact Handler to remove craters"; };
			class setDamageEH			{ description = "MPSF CORE Engine - Injury System Damage Handler"; };
			class setDamageEH_AI		{ description = "MPSF COMMAND - Simple Damage handler that increases damage taken"; };
			class setDamageEH_C4Only	{ description = "MPSF COMMAND - Set damageHandler to only accept damage from C4 etc"; };
			class setFiredEH			{ description = "MPSF CORE Engine - Base Fire Detection"; };
			class setHealEH				{ description = "MPSF CORE Engine - Injury System Heal Handler"; };
			class setKilledEH			{ description = "MPSF CORE Engine - Respawn System Killed and JIP handler"; };
		};

		class Halo {
			file = "mpsf\fnc\halo";
			class halo					{ description = "MPSF COMMAND - Begin Halo sequence of a Unit"; };
			class haloAutoOpen			{ description = "MPSF CORE Engine - Force Open of Chute at <150m"; };
			class haloChemlights		{ description = "MPSF CORE Engine - Attach Chemlight for duration of halo"; };
			class haloEffects			{ description = "MPSF CORE Engine - Run Effects for duration of halo"; };
			class haloLoadout			{ description = "MPSF CORE Engine - Handle Gear for start, during and landing"; };
		};

		class HLC {
			file = "mpsf\fnc\hlc";
			class getHLCID				{ description = "MPSF CORE Engine - Headless Client Get ID (SERVER)"; };
			class initHLC				{ description = "MPSF CORE Engine - Headless Client Server Init (SERVER)"; };
			class setHLCID				{ description = "MPSF CORE Engine - Headless Client Set ID (HLC)"; };
			class setOwner				{ description = "MPSF CORE Engine - Headless Client assign as owner for Server owned AI and Objects (SERVER)"; };
		};

		class Injury {
			file = "mpsf\fnc\injury";
			class aidInjured			{ description = "MPSF COMMAND - Action:Apply First Aid"; };
			class carryInjured			{ description = "MPSF COMMAND - Action:Carry Wounded"; };
			class dragInjured			{ description = "MPSF COMMAND - Action:Drag Injured"; };
			class dropInjured			{ description = "MPSF COMMAND - Action:Drop Dragged Injured"; };
			class injuredIsBeingDragged	{ description = "MPSF COMMAND - Check if injured is being dragged"; };
			class injuredIsBeingHealed	{ description = "MPSF COMMAND - Check if injured is being healed"; };
			class injuredIsDraggable	{ description = "MPSF COMMAND - Check if injured is draggable"; };
			class injuredIsDroppable	{ description = "MPSF COMMAND - Check if injured is droppable"; };
			class injuredIsHealable		{ description = "MPSF COMMAND - Check if injured is healable"; };
			class isMedic				{ description = "MPSF COMMAND - Check if healer is medic"; };
			class useFirstAidKit		{ description = "MPSF COMMAND - Remove First aid kit from Items"; };
			class useMedkit				{ description = "MPSF COMMAND - Remove Medkit from Items"; };
			class handleInjuryDamage	{ description = "MPSF CORE Engine - Injury System Damage Handler"; };
			class injuredBloodloss		{ description = "MPSF SYSTEM - Bloodloss simulation"; ext=".fsm"; };
			class injuredEffects		{ description = "MPSF SYSTEM - Blood Effects"; };
			class unitInAgony			{ description = "MPSF SYSTEM - Unconcious State"; };
		};

		class Interactions {
			file = "mpsf\fnc\interact";
			class checkActionBusy		{ description = "MPSF COMMAND - Check player is currently engaged in another action"; };
			class setActionBusy			{ description = "MPSF COMMAND - Set player is/isn't engaged in an action"; };
			class interaction_else		{ description = "MPSF CORE Engine - Interaction FSM for cursorTarget"; ext=".fsm"; };
			class interaction_self		{ description = "MPSF CORE Engine - Interaction FSM for playable Units"; ext=".fsm"; };
		};

		class Loadout{
			file = "mpsf\fnc\loadout";
			class createAmmobox			{ description = "MPSF COMMAND - Create an Ammobox"; };
			class declareAmmobox		{ description = "MPSF COMMAND - Broadcast a new Ammobox"; };
			class fillAmmobox			{ description = "MPSF COMMAND - Fill an Ammobox"; };
			class getLoadout			{ description = "MPSF COMMAND - Get a Units Loadout"; };
			class handleAmmobox			{ description = "MPSF COMMAND - Handle an Ammobox"; };
			class hasARgear				{ description = "MPSF COMMAND - Check unit has Augmented Reality Gear Equipped"; };
			class hasFirstAidKit		{ description = "MPSF COMMAND - Check if first aid kit in Items"; };
			class hasHelmetCamera		{ description = "MPSF COMMAND - Check unit has Helmet Camera Gear Equipped"; };
			class hasMedKit				{ description = "MPSF COMMAND - Check if medkit in Items"; };
			class saveLoadout			{ description = "MPSF COMMAND - Saves a Units Loadout as mpsf_VAR_savedLoadout"; };
			class setLoadout			{ description = "MPSF COMMAND - Set a Units Loadout"; };
		};

		class Logistics {
			file = "mpsf\fnc\logistics";
			class clearCrater			{ description = "MPSF COMMAND - Undefined"; };
			class containerPack			{ description = "MPSF COMMAND - Action:Pack Object as shipping container"; };
			class containerUnpack		{ description = "MPSF COMMAND - Action:Unpack Shipping container into Object"; };
			class createChute			{ description = "MPSF COMMAND - Creates a chute and attaches the payload for decent"; };
			class createIlluminationFlare	{ description = "MPSF COMMAND - Action:Create a flare at a position/object/marker"; };
			class createSupplybox		{ description = "MPSF COMMAND - Create an Ammobox"; };
			class declareSupplybox		{ description = "MPSF COMMAND - Broadcast a new Ammobox"; };
			class detectLiftable		{ description = "MPSF SYSTEM - Searches for nearby objects and sets logistic parameters"; };
			class displayLogisticsFeatures	{ description = "MPSF COMMAND - Show Logistics parameters of object"; };
			class dragObject			{ description = "MPSF COMMAND - Action:Attaches an object to the dragger"; };
			class dropObject			{ description = "MPSF COMMAND - Action:Releases an object from a dragger"; };
			class fillSupplybox			{ description = "MPSF COMMAND - Fill an Ammobox"; };
			class getAttachPoint		{ description = "MPSF COMMAND - Returns the Attachment point as per the bounding box"; };
			class getloadOffset			{ description = "MPSF COMMAND - Return offset parameter of cargo versus loader"; };
			class handleSupplybox		{ description = "MPSF COMMAND - Handle an Ammobox"; };
			class isDraggable			{ description = "MPSF COMMAND - Checks if an object is draggable"; };
			class isDragged				{ description = "MPSF COMMAND - Checks if an object is being dragged by a dragger"; };
			class isDriver				{ description = "MPSF COMMAND - Checks if a Unit is a Driver, Pilot or Co-Pilot of a vehicle"; };
			class isLiftable			{ description = "MPSF COMMAND - Checks if an object is liftable"; };
			class isLifted				{ description = "MPSF COMMAND - Checks if an object is lifted by a lifter"; };
			class isLoadable			{ description = "MPSF COMMAND - Checks if an object is loadable"; };
			class isLoaded				{ description = "MPSF COMMAND - Checks if an object is loaded by a loader"; };
			class isTowed				{ description = "MPSF COMMAND - Checks if an object is towed by a tower"; };
			class liftCamera			{ description = "MPSF SYSTEM - Enables Lifters Lift Hook and PIP hud"; };
			class liftObject			{ description = "MPSF COMMAND - Action:Attaches an object to a lifter"; };
			class liftRelease			{ description = "MPSF COMMAND - Action:Releases an object from a lifter"; };
			class loadObjectOff			{ description = "MPSF COMMAND - Action:Unloads an Object from its transport"; };
			class loadObjectOn			{ description = "MPSF COMMAND - Loads an Object onto the nearest available transport"; };
			class loadObject_SelectLoader	{ description = "MPSF COMMAND - Action:Select Loader and load sekectedobject"; };
			class loadObject_SelectObject	{ description = "MPSF COMMAND - Action:Select Object for loading"; };
			class logisticsCheck		{ description = "MPSF COMMAND - Check Logistics Criteria"; };
			class rearmVehicle			{ description = "MPSF COMMAND - Rearm a vehicle weapon systems"; };
			class refuelVehicle			{ description = "MPSF COMMAND - Refuel a vehicle"; };
			class repairVehicle			{ description = "MPSF COMMAND - Repair a vehicle"; };
			class resupplyVehicle		{ description = "MPSF COMMAND - Action:Begin a vehicles resupply sequence"; };
			class setAsAmmobox			{ description = "MPSF COMMAND - Set objects as Unit Ammopoint"; };
			class setAsCRV				{ description = "MPSF COMMAND - Set objects as CRV clearance capable"; };
			class setAsDraggable		{ description = "MPSF COMMAND - Set objects as Draggable"; };
			class setAsLiftable			{ description = "MPSF COMMAND - Set objects as Liftable"; };
			class setAsLiftChopper		{ description = "MPSF COMMAND - Set objects as Lift Choppers"; };
			class setAsLoadable			{ description = "MPSF COMMAND - Set Objects as Loadable"; };
			class setAsResupply			{ description = "MPSF COMMAND - Set Objects as Resupply Point"; };
			class setAsTowVeh			{ description = "MPSF COMMAND - Set Objects as Tow Vehicle"; };
			class slingRope				{ description = "MPSF - Undefined"; };
			class towObjectAttach		{ description = "MPSF - Undefined"; };
			class towObjectRelease		{ description = "MPSF - Undefined"; };
			class towRope				{ description = "MPSF - Undefined"; };
			class UAVReplaceBatteries	{ description = "MPSF - Undefined"; };
		};

		class Map {
			file = "mpsf\fnc\map";
			class drawIcon				{ description = "MPSF COMMAND - Undefined"; };
			class getGroupColour		{ description = "MPSF COMMAND - Undefined"; };
			class getGroupSizeMarkerType	{ description = "MPSF COMMAND - Returns marker type of the size of the group."; };
			class getObjectMarkerType	{ description = "MPSF COMMAND - Returns marker type of the type vehicle the unit or group is operating."; };
			class getUnitMarkerColour	{ description = "MPSF COMMAND - Returns marker colour of the side of the unit or group."; };
			class hideGroupMarker		{ description = "MPSF COMMAND - Hides the group marker"; };
			class hideMarkers			{ description = "MPSF COMMAND - Hides markers by setting their alpha as zero"; };
			class worldsize				{ description = "MPSF COMMAND - Return the worldsize based on the configuration"; };
			class grpmark_detectGroups	{ description = "MPSF SYSTEM - Registers groups and creates/removes a group marker"; };
			class grpmark_detectTeam	{ description = "MPSF SYSTEM - Registers units in a players team and creates/removes a marker for each"; };
			class grpmark_detectUAV		{ description = "MPSF SYSTEM - Registers units in a players team and creates/removes a marker for each"; };
			class grpmark_draw			{ description = "MPSF SYSTEM - Displays and updates the map markers for various friendly assets"; };
		};

		class Misc {
			file = "mpsf\fnc\misc";
			class animateUnit			{ description = "MPSF COMMAND - Animate a unit"; };
			class boundingBoxLWH		{ description = "MPSF COMMAND - Get Object Dimensions"; };
			class checkObjCondition		{ description = "MPSF COMMAND - Validate an object or value against a given condition"; };
			class isAdministrator		{ description = "MPSF COMMAND - Check if is Administrator"; };
			class requestOwnership		{ description = "MPSF COMMAND - Request Enitity change ownership"; };
			class change_direction		{ description = "MPSF COMMAND - Change Object Direction"; };
			class diary					{ description = "MPSF CORE Engine - Generate MPSF Credits in the briefing"; };
			class init 					{ description = "MPSF CORE Engine - Initialise MPSF Framework"; preInit = 1; };
			class playActionNow			{ description = "MPSF CORE Engine - Animate a Unit"; };
			class setOwner				{ description = "MPSF CORE Engine - Change Ownership"; };
			class setDir				{ description = "MPSF CORE Engine - Change Object Direction"; };
		};

		class ObjectSpawner {
			file = "mpsf\fnc\objectspawner";
			class cleanup				{ description = ""; };
			class createGroup			{ description = "MPSF COMMAND - Create a group of infantry units"; };
			class createMinefield		{ description = "MPSF COMMAND - Create a minefield in an marked area"; };
			class createObjects			{ description = "MPSF COMMAND - Create objects in an array"; };
			class createStaticDefense	{ description = "MPSF COMMAND - Create Static defences around a position"; };
			class createVehicle			{ description = "MPSF COMMAND - Create a vehicle and if needed; the crew and cargo as well"; };
			class getpreDefinedSquads	{ description = "MPSF COMMAND - Return array from mpsf_CfgSpawner_PreDefinedSquads"; };
			class getpreDefinedVehicles	{ description = "MPSF COMMAND - Return array from mpsf_CfgSpawner_PreDefinedVehicles"; };
			class setObjectRespawn		{ description = "MPSF COMMAND - Set Vehicle respawn parameters"; };
			class objectrespawn			{ description = "MPSF CORE Engine - Vehicle Loop monitor for respawn"; };
			class crewSpawner			{ description = "MPSF CORE Engine - Objectspawner (CREW)"; };
			class squadSpawner			{ description = "MPSF CORE Engine - Objectspawner (SQUAD)"; };
			class objectSpawner			{ description = "MPSF CORE Engine - Objectspawner (OBJECT)"; };
			class objectsSpawner		{ description = "MPSF CORE Engine - Objectspawner (OBJECTS)"; };
			class vehicleSpawner		{ description = "MPSF CORE Engine - Objectspawner (VEHICLE"; };
		};

		class Position {
			file = "mpsf\fnc\position";
			class getflatarea			{ description = "MPSF COMMAND - Return a flat area near a position"; };
			class getNearbyBuildings	{ description = "MPSF COMMAND - Return nearby buildings"; };
			class getNearbyPlayers		{ description = "MPSF COMMAND - Return nearby players of certain criteria"; };
			class getNearbyUnits		{ description = "MPSF COMMAND - Return nearby units of certain criteria"; };
			class getpos				{ description = "MPSF COMMAND - Return the position"; };
			class getSafePos			{ description = "MPSF COMMAND - Return a safe area for an object"; };
			class getNearbylocations	{ description = "MPSF COMMAND - Return nearby locations"; };
			class nearestlocation		{ description = "MPSF COMMAND - Return the nearest location"; };
			class nearestroad			{ description = "MPSF COMMAND - Return the nearest Road"; };
			class findclosestposition	{ description = "MPSF CORE Engine - Undefined"; };
			class getmarkercorners		{ description = "MPSF CORE Engine - Undefined"; };
			class getmarkershape		{ description = "MPSF CORE Engine - Undefined"; };
			class getposarray			{ description = "MPSF CORE Engine - Undefined"; };
			class getposfromcircle		{ description = "MPSF CORE Engine - Undefined"; };
			class getposfromellipse		{ description = "MPSF CORE Engine - Undefined"; };
			class getposfromrectangle	{ description = "MPSF CORE Engine - Undefined"; };
			class getposfromsquare		{ description = "MPSF CORE Engine - Undefined"; };
			class getposmarker			{ description = "MPSF CORE Engine - Undefined"; };
			class getposradius			{ description = "MPSF CORE Engine - Undefined"; };
			class isblacklisted			{ description = "MPSF CORE Engine - Undefined"; };
			class isincircle			{ description = "MPSF CORE Engine - Undefined"; };
			class isinellipse			{ description = "MPSF CORE Engine - Undefined"; };
			class isinrectangle			{ description = "MPSF CORE Engine - Undefined"; };
			class issameposition		{ description = "MPSF CORE Engine - Undefined"; };
			class rotateposition		{ description = "MPSF CORE Engine - Undefined"; };
		};

		class Respawn {
			file = "mpsf\fnc\respawn";
			class addRespawnPos			{ description = "MPSF COMMAND - GLOBAL add a respawn position"; };
			class addRespawnPosLocal	{ description = "MPSF COMMAND - LOCAL add a respawn position"; };
			class createRallypoint		{ description = "MPSF COMMAND - Action:Create a Rallypoint"; };
			class redeploy				{ description = "MPSF COMMAND - Activate Redeploy Menu"; };
			class removeRallypoint		{ description = "MPSF COMMAND - Remove a Rallypoint"; };
			class removeRespawnPos		{ description = "MPSF COMMAND - GLOBAL remove a respawn position"; };
			class removeRespawnPosLocal	{ description = "MPSF COMMAND - LOCAL remove a respawn position"; };
			class redeployByHALO		{ description = "MPSF COMMAND - Action:Halo on a position"; };
			class dead					{ description = "MPSF CORE Engine - Declare unit dead"; };
			class getRespawnPositions	{ description = "MPSF CORE Engine - Return Respawn Positions"; };
			class GUI_acceptRespawnPos	{ description = "MPSF CORE Engine - Respawn Accept selection"; };
			class GUI_respawn			{ description = "MPSF CORE Engine - Handle respawn GUI"; };
			class GUI_selectRespawnPos	{ description = "MPSF CORE Engine - Select a respawn position"; };
			class onkilled				{ description = "MPSF CORE Engine - Respawn System killed handler"; };
			class onkilled_camera		{ description = "MPSF CORE Engine - Killed Camera"; };
			class onkilled_effects		{ description = "MPSF CORE Engine - Killed Effects"; };
			class onkilled_sitrep		{ description = "MPSF CORE Engine - Killed SITREP"; };
		};

		class Screentext {
			file = "mpsf\fnc\screentext";
			class chat					{ description = "MPSF COMMAND - Display various chat text"; };
			class hint					{ description = "MPSF COMMAND - Display various hint types"; };
			class progressbar			{ description = "MPSF COMMAND - Broadcast a progressbar update"; };
			class sendChat				{ description = "MPSF COMMAND - Broadcast a chat message"; };
			class sendHint				{ description = "MPSF COMMAND - Broadcast a hint"; };
			class sendProgressBar		{ description = "MPSF COMMAND - Broadcast a progressBar"; };
			class showTacticalText		{ description = "MPSF COMMAND - Undefined"; };
			class text_cursortarget		{ description = "MPSF COMMAND - Undefined"; };
			class text_sitrep			{ description = "MPSF COMMAND - Undefined"; };
			class text_tactical			{ description = "MPSF COMMAND - Undefined"; };
		};

		class Squad {
			file = "mpsf\fnc\squad";
			class acceptJoinGroup		{ description = "MPSF COMMAND - Unit accepts request/invite to join squad"; };
			class assignGroupLeader		{ description = "MPSF COMMAND - Assign a unit as leader of the squad"; };
			class changeGroupID			{ description = "MPSF COMMAND - Broadcast a change of group ID"; };
			class createNewGroup		{ description = "MPSF COMMAND - Create a new empty group"; };
			class declineJoinGroup		{ description = "MPSF COMMAND - Unit declines request/invite to join squad"; };
			class getGroupName			{ description = "MPSF COMMAND - Returns the groups name."; };
			class getGroupUnits			{ description = "MPSF COMMAND - Returns the groups units."; };
			class inviteJoinGroup		{ description = "MPSF COMMAND - Invite a unit to join a squad"; };
			class isQualified			{ description = "MPSF COMMAND - Checks if unit is qualified"; };
			class isTeamLeader			{ description = "MPSF COMMAND - Checks if unit is the team leader"; };
			class requestJoinGroup		{ description = "MPSF COMMAND - Unit request to join a squad"; };
			class setAsCrewman			{ description = "MPSF COMMAND - Set unit as Crewman"; };
			class setAsLeader			{ description = "MPSF COMMAND - Set a groups leader"; };
			class setAsMedic			{ description = "MPSF COMMAND - Set unit as Medic"; };
			class setAsPilot			{ description = "MPSF COMMAND - Set unit as Pilot"; };
			class setGroupID			{ description = "MPSF COMMAND - Set a groups description"; };
			class setUnqualified		{ description = "MPSF COMMAND - Set unit as nothing"; };
			class showCemLight			{ description = "MPSF COMMAND - Show a chemlight on a unit based on their assigned squad"; };
			class sqdmodFunctions		{ description = "MPSF COMMAND - Functions for Squad Mod"; };
			class unitJoinGroup			{ description = "MPSF COMMAND - Joins a unit to a group"; };
			class unitKickFromGroup		{ description = "MPSF COMMAND - Kick a unit from a squad"; };
			class unitLeaveGroup		{ description = "MPSF COMMAND - Move a unit to an empty group"; };
		};

		class Support {
			file = "mpsf\fnc\support";
			class supportCreateChute	{ description = "MPSF COMMAND - WIP"; };
			class supportCreateUAV		{ description = "MPSF COMMAND - WIP"; };
			class supportCreateUGV		{ description = "MPSF COMMAND - WIP"; };
		};

		class Taskmaster {
			file = "mpsf\fnc\taskmaster";
			class runTaskSequence		{ description = "MPSF COMMAND - Runs a series of ExecVM tasks on the server in a set sequence"; };
			class runTasksRandom		{ description = "MPSF COMMAND - Runs a series of ExecVM tasks on the server in a random order"; };
			class addTask				{ description = "MPSF COMMAND - Add a new task"; };
			class getTaskState			{ description = "MPSF COMMAND - Get Task State"; };
			class hasTaskState			{ description = "MPSF COMMAND - Check if Task is at a specified state"; };
			class isTaskcompleted		{ description = "MPSF COMMAND - Check if Task Complete"; };
			class updateTask			{ description = "MPSF COMMAND - Update a Task"; };
			class addLocalTask			{ description = "MPSF CORE Engine - Undefined"; };
			class addTaskNote			{ description = "MPSF CORE Engine - Undefined"; };
			class assignTask			{ description = "MPSF CORE Engine - Undefined"; };
			class getAssignedTasks		{ description = "MPSF CORE Engine - Undefined"; };
			class handleTaskEvent		{ description = "MPSF CORE Engine - Undefined"; };
			class hasLocalTask			{ description = "MPSF CORE Engine - Undefined"; };
			class hasTask				{ description = "MPSF CORE Engine - Undefined"; };
			class hasTaskStateChanged	{ description = "MPSF CORE Engine - Undefined"; };
			class showTaskHint			{ description = "MPSF CORE Engine - Undefined"; };
			class skipTask				{ description = "MPSF CORE Engine - Undefined"; };
			class taskmaster			{ description = "MPSF CORE Engine - Undefined"; };
			class updateLocalTask		{ description = "MPSF CORE Engine - Undefined"; };
		};

	};

//};
