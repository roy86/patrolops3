// =========================================================================================================
//	1. Define Location
// =========================================================================================================
/*
Pick the type of location you want the task to select from. You can select more than one by adding them into an array.
Types:
	"base" are military bases
	"city" are larger towns and cities
	"hill" are tops of hills
	"town" are small towns
	"bay","water","underwater" are water locations
	"poi" are points of intrest like a stadium or factory etc...
	"airport" are airports
*/
	_location = ["city","town"] call po3_fnc_getNewPos; // Here I'm requesting a location from either a City or Town

	PO3_TASK__DIF	= po3_param_missionskill; // <!-- Returns the mission difficulty as a global VAR
	PO3_TASK__POS	= _location select 0; // <!--  Returns the location name
	PO3_TASK__IDD	= format["%1%2:%3",round(PO3_TASK__POS select 0),round(PO3_TASK__POS select 1),(round random 99)];  // <!-- Creates a UNIQUE TaskID for referenceing this task

	_position = _location select 0; // <!-- Local Variable of the position
	_locaname = _location select 1; // <!-- Local Variable of the location Name
	_locRadis = _location select 2; // <!-- Local Variable of the location Radius

// =========================================================================================================
//	Creating Enemies
// =========================================================================================================
	PO3_TOTAL_UNITS = []; // <!-- Create a global array of total spawned untits. Used for cleanup at the end.
	PO3_TOTAL_VEHICLES = []; // <!-- Create a global array of total spawned vehicles. Used for cleanup at the end.

	/* Making the task dynamic based on difficulty.
		Easy: 4*((1/3)*3) = 4*1 = 4
		Medium: 4*((2/3)*3) = 4*2 = 8
		Hard: 4*((3/3)*3) = 4*3 = 12
	*/
	_difficulty = 4*(PO3_TASK__DIF*3);


// =========================================================================================================
//	Creating a Hostile Squad
// =========================================================================================================
/*
	Spawning a group of Units:

	_position where you will center the spawn location
	_side you will create them on
	_groupName you can get from the po3_preDefinedEnemySquads OR you can directly specify an array of unit types to spawn
	_radius is the radius from the center location that the group will spawn at.

	Full Command
		_grp = [ <position>,<side>,<GroupName/Array of Units>,<radius>] call mpsf_fnc_createGroup;
		_grp = [ [100,100],EAST,["O_soldier_TL_F","O_soldier_F","O_soldier_F","O_soldier_F"],0] call mpsf_fnc_createGroup;

	This also returns the GroupID of the group

	In the below Example a FOR loop is used to create a number of enemy groups based on the difficulty
*/
	// Using the local variable "_i" from 1 to Difficulty Level Defined Earlier....
	for "_i" from 1 to _difficulty do {
		//  Reset _grp
		_grp = nil;
		// Create the group at "_position" defined earlier, for the EAST side base on what was configured, GET a group name between EN_GroupForce_0 and EN_GroupForce_4 and spawn them in somewhere in a radius of 200m from the position
		_grp = [ _position, (po3_side_3 select 0), format["EN_GroupForce_%1",round random 4], 200 ] call mpsf_fnc_createGroup;

		// If the group was successfully created then...
		if !(isNil "_grp") then {

			// Tell the group to begin a PATROL of the location with a max radis of 50 * _i which will be 50*(1->12) depending on difficulty
			[ _position, _grp, (50 * _i) ] spawn mpsf_fnc_groupPatrolArea;
			// OR you can make them DEFEND a location where they will occupy nearby statics and buildings
		//	[ (leader _grp), _grp ] spawn mpsf_fnc_groupDefendPos;

			// ADD all the units created to our total array for cleanup at the end of the task
			PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _grp);

			// Sleep fo a sec
			sleep 1;
		};
	};

/*
	Spawning a vehicle:

	_position where you will center the spawn location
	_class is the class type to create
	_direction it will be facing
	_radius is the radius from the center location that the group will spawn at.
	_side its crew will be created for (optional)
	_cargo is optional to create a squad (similar to the above) in the vehicles cargo spaces

	Full Command
		_grp = [ <position>,<class>,<direction>,<radius>,<side>,<GroupName/Array of Units>] call mpsf_fnc_createVehicle;
		_grp = [ [100,100],"O_MRAP_01",45,0,EAST] call mpsf_fnc_createVehicle;

	This also returns the GroupID of the group created and the vehicle [<GROUPID>,<OBJECT>]

	In the below Example a FOR loop is used to create a number of enemy vehicles based on the difficulty
*/
	// Using the local variable "_i" from 1 to Difficulty Level Defined Earlier but Divided by 2....
	for "_i" from 0 to (_difficulty/2) do {
		//  Reset _ret
		_ret = nil;

		// Create the vehicle and crew at "_position" defined earlier, for the EAST side base on what was configured, spawn them in somewhere in a radius of 200m from the position facing a random 360 direction
		_ret = [ _position,"O_MRAP_01",random 360,200,(po3_side_3 select 0)] call mpsf_fnc_createVehicle) select 0;

		// If the group was successfully created then...
		if !(isNil "_ret") then {

			_grp = _ret select 0; // <!-- Get the GroupID
			_veh = _ret select 1; // <!-- Get the Vehicle

			// Tell the group to begin a PATROL of the location with a max radis of 50 * _i which will be 50*(1->12) depending on difficulty
			[ _position, _grp, 100 + round(random 300) ] spawn mpsf_fnc_groupPatrolArea;

			// ADD all the units created to our total array for cleanup at the end of the task
			PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _grp);
			// ADD the vehicle created to our total array for cleanup at the end of the task
			PO3_TOTAL_VEHICLES set [ count PO3_TOTAL_VEHICLES, _veh];
		};
	};

// =========================================================================================================
//	Creating the Task
// =========================================================================================================
	[
		// The Unique TASKID for the task
		format["TASK%1",PO3_TASK__IDD],

		// The Title with the location name in it
		format["Attack : %1",_locaname],

		// The Task Description
		format["%1 has been attacked. Clear out all enemies.",_locaname],

		// The Side/Group/Unit that will recieve the task
		(po3_side_1 select 0), // <!-- WEST/EAST/RESISTANCE or GROUPID

		// Create a marker (Optional). To not create onem just use brackets [],
		[
		// The Unique MARKERID for the marker
			format["MRKR%1",PO3_TASK__IDD],
			// The position it will be created at
			_position,
			// The Marker Type
			"mil_objective",
			// The Marker Colour
			"ColorOPFOR",
			// The Marker Text (Optional)
			format[" %1",_locaname]
		],

		// Assign the task straight away (use "created" to leave it unassigned)
		"assigned",

		// (OPtional) Create a 3D chevron at the position
		(_position),
		// (Optional) Give the Chevron a title
		format[localize "STR_PO3_M01_TITLE",_locaname]

	] call mpsf_fnc_addTask; // <!-- Create the task

// =========================================================================================================
//	WAIT UNTIL COMPLETE/FAIL
// =========================================================================================================

	waitUntil{ sleep 1; !( [_position,200,2,["CAManBase","LandVehicle"],[(po3_side_3 select 0)],false] call po3_fnc_checkNearEntities )};

	sleep 1;
	if( true ) then {
		[format["TASK%1",PO3_TASK__IDD],"succeeded"] call mpsf_fnc_updateTask;
	}else{
		[format["TASK%1",PO3_TASK__IDD],"failed"] call mpsf_fnc_updateTask;
	};

// =========================================================================================================
//	Cleanup
// =========================================================================================================
	[_position,PO3_TOTAL_UNITS,PO3_TOTAL_VEHICLES] spawn {
		private["_target","_units","_vehicles"];

		_target = _this select 0;
		_units = _this select 1;
		_vehicles = _this select 2;

		waitUntil { count ([_target,500,(po3_side_1 select 0),["CAManBase"]] call mpsf_fnc_getNearbyPlayers) == 0 };

		{ if(alive _x) then { _x setDamage 1 }; }forEach _units;
		{ if( {isPlayer _x} count (crew _x) == 0 ) then { _x setDamage 1 }; }forEach _vehicles;
	};