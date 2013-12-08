// =========================================================================================================
// !!  DO NOT MODIFY THIS FILE  !!
// =========================================================================================================
// class CfgNotifications {
	class mpsf_TaskAssigned {
		title = $STR_MPSF_TASK_ASGN;
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIcon_ca.paa";
		description = "%1";
		priority = 5;
		sound = "taskAssigned";
	};

	class mpsf_TaskCanceled {
		title = $STR_MPSF_TASK_CANX;
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_ca.paa";
		color[] = {0.7,0.7,0.7,1};
		description = "%1";
		priority = 5;
		sound = "taskCanceled";
	};

	class mpsf_TaskCreated {
		title = $STR_MPSF_TASK_CREA;
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_ca.paa";
		description = "%1";
		priority = 1;
		sound = "taskCreated";
	};

	class mpsf_TaskFailed {
		title = $STR_MPSF_TASK_FAIL;
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
		color[] = {1,0.3,0.2,1};
		description = "%1";
		priority = 2;
		sound = "taskFailed";
	};

	class mpsf_TaskSucceeded {
		title = $STR_MPSF_TASK_SUCC;
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
		color[] = {0.7,1,0.3,1};
		description = "%1";
		priority = 2;
		sound = "taskSucceeded";
	};

	class mpsf_TaskUpdated {
		title = $STR_MPSF_TASK_UPDT;
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIcon_ca.paa";
		description = "%1";
		priority = 5;
		sound = "taskUpdated";
	};

	class mpsf_notify {
		title = "%1";
		description = "%2";
		iconPicture = "%3";
		sound = "taskCreated";
		priority = 2;
	};

	class mpsf_notify_blue {
		color[] = {0.66,0.66,1.00,1};
		title = "%1";
		description = "%2";
		iconPicture = "%3";
		sound = "taskCreated";
		priority = 2;
	};

	class mpsf_notify_red {
		color[] = {1.00,0.66,0.66,1};
		title = "%1";
		description = "%2";
		iconPicture = "%3";
		sound = "taskCreated";
		priority = 2;
	};

	class mpsf_notify_green {
		color[] = {0.66,1.00,0.66,1};
		title = "%1";
		description = "%2";
		iconPicture = "%3";
		sound = "taskCreated";
		priority = 2;
	};

	class mpsf_notify_yellow {
		color[] = {1.00,1.00,0.66,1};
		title = "%1";
		description = "%2";
		iconPicture = "%3";
		sound = "taskCreated";
		priority = 2;
	};

	class mpsf_notify_white {
		color[] = {1.00,1.00,1.00,1};
		title = "%1";
		description = "%2";
		iconPicture = "%3";
		sound = "taskCreated";
		priority = 2;
	};
// };