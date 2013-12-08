// = Pre-Defining Logistics Configuration ======================================================

// Vehicle CAPACITY that can TOW, LIFT or LOAD
mpsf_CfgLogistics_Loadable = [
	 ["Cargo_base_F",15200]
	,["B_Truck_01_mover_F",0]
	,["B_Truck_01_transport_F",64000]
	,["O_Truck_02_transport_F",64000]
	,["I_Truck_02_transport_F",64000]
	,["Car_F",250]
	,["Heli_Transport_01_base_F",1980]
	,["Heli_Transport_02_base_F",4620]
	,["Helicopter_Base_H",422]
];

// Liftable/Loadable Object Weight
mpsf_CfgLogistics_Liftable = [
	 ["Cargo_base_F",4280]
	,["B_supplyCrate_F",400]
	,["Quadbike_01_base_F",264]
	,["B_Truck_01_transport_F",18300]
	,["O_Truck_02_transport_F",18300]
	,["I_Truck_02_transport_F",18300]
	,["Wheeled_APC_F",16329]
	,["Car_F",1900]
	,["Tank",64000]
	,["Ship_F",1200]
	,["Heli_Light_01_armed_base_F",1990]
	,["Heli_Light_01_base_F",722]
	,["Heli_Light_02_base_F",3291]
	,["Helicopter_Base_F",8291]
	,["UAV_02_base_F",4980]
];

mpsf_CfgLogistics_TowVehicles = [
	 ["B_Truck_01_mover_F",0]
	,["B_Truck_01_transport_F", 10000]
	,["O_Truck_02_transport_F", 10000]
	,["I_Truck_02_transport_F", 10000]
	,["B_APC_Tracked_01_CRV_F", 64000]
	,["Car_F", 250]
];
mpsf_CfgLogistics_Towable = [
	 ["B_Truck_01_mover_F",0]
	,["B_Truck_01_transport_F", 10000]
	,["O_Truck_02_transport_F", 10000]
	,["I_Truck_02_transport_F", 10000]
	,["Car", 2000]
	,["Tank_F", 64000]
	,["Air", 8291]
];
// Draggable Weight
mpsf_CfgLogistics_Moveable = [
	 ["Items_base_F",5]
	,["B_supplyCrate_F",5]
];
