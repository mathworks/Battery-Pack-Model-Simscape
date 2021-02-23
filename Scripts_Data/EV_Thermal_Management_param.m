%% Parameters for ev_thermal_management
% 

% Copyright 2020-2021 The MathWorks, Inc.

% Configure scenario (see code):
%     (1) drive cycle,  set <user_selection> == 1
%     (2) cool down,    set <user_selection> == 2
%     (3) cold weather, set <user_selection> == 3

user_selection = 3;

if user_selection == 1
    scenario = 'drive cycle';
elseif user_selection == 2
    scenario = 'cool down';
elseif user_selection == 3
    scenario = 'cold weather';
else
    scenario = 'none';
end
% 
%% Initial conditions

cabin_p_init = 0.101325; % [MPa] Initial air pressure
cabin_T_init = 30; % [degC] Initial air temperature
cabin_RH_init = 0.4; % Initial relative humidity
cabin_CO2_init = 4e-4; % Initial CO2 mole fraction

coolant_p_init = 0.101325; % [MPa] Initial coolant pressure
coolant_T_init = 30; % [degC] Initial coolant temperature

refrigerant_p_init = 0.8; % [MPa] Initial refrigerant pressure
refrigerant_alpha_init = 0.6; % Initial refrigerant vapor void fraction

battery_T_init = 30; % [degC] Initial battery temperature
battery_SOC_init = 0.95; % [-] Initial state of charge of the battery

%% Vehicle Cabin

cabin_duct_area = 0.04; % [m^2] Air duct cross-sectional area

%% Liquid Coolant System

coolant_pipe_D = 0.019; % [m] Coolant pipe diameter
coolant_channel_D = 0.0092; % [m] Coolant jacket channels diameter

coolant_valve_displacement = 0.0063; % [m] Max spool displacement
coolant_valve_offset = 0.001; % [m] Orifice opening offset when spool is neutral
coolant_valve_D_ratio_max = 0.95; % Max orifice diameter to pipe diameter ratio
coolant_valve_D_ratio_min = 1e-3; % Leakage orifice diameter to pipe diameter ratio

pump_displacement = 0.02; % [l/rev] Coolant pump volumetric displacement
pump_speed_max = 1000; % [rpm] Coolant pump max shaft speed

coolant_tank_volume = 2.5 / 2; % [l] Volume of each coolant tank
coolant_tank_area = 0.11^2; % [m^2] Area of one side of coolant tank

%% Refrigeration System

refrigerant_pipe_D = 0.01; % [m] Refrigerant pipe diameter

% Compressor map table
compressor_p_ratio_LUT = [0; 1; 4.28795213348131; 7.57590426696263; 10.8638564004439; 14.1518085339253]; % Pressure ratio
compressor_rpm_LUT = [0, 1800, 3600]; % [rpm] Shaft speed
compressor_mdot_corr_LUT = [
    0, 0, 0;
    0, 0.0114121796814927, 0.0228243593629856;
    0, 0.00855913476111960, 0.0171182695222391;
    0, 0.00570608984074638, 0.0114121796814927;
    0, 0.00285304492037319, 0.00570608984074636; 
    0, 0, 0]; % [kg/s] Corrected mass flow rate

%% Radiator

radiator_L = 0.6; % [m] Overall radiator length
radiator_W = 0.015; % [m] Overall radiator width
radiator_H = 0.2; % [m] Overal radiator height
radiator_N_tubes = 25; % Number of coolant tubes
radiator_tube_H = 0.0015; % [m] Height of each coolant tube
radiator_fin_spacing = 0.002; % Fin spacing
radiator_wall_thickness = 1e-4; % [m] Material thickness
radiator_wall_conductivity = 240; % [W/m/K] Material thermal conductivity

radiator_gap_H = (radiator_H - radiator_N_tubes*radiator_tube_H) / (radiator_N_tubes - 1); % [m] Height between coolant tubes
radiator_air_area_flow = (radiator_N_tubes - 1) * radiator_L * radiator_gap_H; % [m^2] Air flow cross-sectional area
radiator_air_area_primary = 2 * (radiator_N_tubes - 1) * radiator_W * (radiator_L + radiator_gap_H); % [m^2] Primary air heat transfer surface area
radiator_N_fins = (radiator_N_tubes - 1) * radiator_L / radiator_fin_spacing; % Total number of fins
radiator_air_area_fins = 2 * radiator_N_fins * radiator_W * radiator_gap_H; % [m^2] Total fin surface area
radiator_tube_Leq = 2*(radiator_H + 20*radiator_tube_H*radiator_N_tubes); % [m] Additional equivalent tube length for losses due to manifold and splits

fan_area = 0.25 * 2; % [m^2] Fan flow area (2 fans)

%% Condenser

condenser_L = 0.63 * 2; % [m] Overall condenser length (2 condensers)
condenser_W = 0.015; % [m] Overall condenser width
condenser_H = 0.39; % [m] Overall condenser height
condenser_N_tubes = 40; % Number of refrigerant tubes
condenser_N_tube_channels = 12; % Number of channels per refrigerant tube
condenser_tube_H = 0.002; % [m] Height of each refrigerant tube
condenser_fin_spacing = 0.0005; % [m] Fin spacing
condenser_wall_thickness = 1e-4; % [m] Material thickness
condenser_wall_conductivity = 240; % [W/m/K] Material thermal conductivity

condenser_gap_H = (condenser_H - condenser_N_tubes*condenser_tube_H) / (condenser_N_tubes - 1); % [m] Height between refrigerant tubes
condenser_air_area_flow = (condenser_N_tubes - 1) * condenser_L * condenser_gap_H; % [m^2] Air flow cross-sectional area
condenser_air_area_primary = 2 * (condenser_N_tubes - 1) * condenser_W * (condenser_L + condenser_gap_H); % [m^2] Primary air heat transfer surface area
condenser_N_fins = (condenser_N_tubes - 1) * condenser_L / condenser_fin_spacing; % Total number of fins
condenser_air_area_fins = 2 * condenser_N_fins * condenser_W * condenser_gap_H; % [m^2] Total fin surface area
condenser_tube_area_webs = 2 * condenser_N_tubes * (condenser_N_tube_channels - 1) * condenser_tube_H * condenser_L; % [m^2] Total surface area of webs in refrigerant tubes
condenser_tube_Leq = 2*(condenser_H + 20*condenser_tube_H*condenser_N_tubes) ...
    + (condenser_N_tube_channels - 1)*condenser_L*condenser_tube_H/(condenser_W + condenser_tube_H); % [m] Additional equivalent tube length for losses due to manifold, splits, and webs

%% Evaporator

evaporator_L = 0.63; % [m] Overall evaporator length
evaporator_W = 0.015; % [m] Overall evaporator width
evaporator_H = 0.2; % [m] Overall evaporator height
evaporator_N_tubes = 20; % Number of refrigerant tubes
evaporator_N_tube_channels = 12; % Number of channels per refrigerant tube
evaporator_tube_H = 0.002; % [m] Height of each refrigerant tube
evaporator_fin_spacing = 0.0005; % Fin spacing
evaporator_wall_thickness = 1e-4; % [m] Material thickness
evaporator_wall_conductivity = 240; % [W/m/K] Material thermal conductivity

evaporator_gap_H = (evaporator_H - evaporator_N_tubes*evaporator_tube_H) / (evaporator_N_tubes - 1); % [m] Height between refrigerant tubes
evaporator_air_area_flow = (evaporator_N_tubes - 1) * evaporator_L * evaporator_gap_H; % [m^2] Air flow cross-sectional area
evaporator_air_area_primary = 2 * (evaporator_N_tubes - 1) * evaporator_W * (evaporator_L + evaporator_gap_H); % [m^2] Primary air heat transfer surface area
evaporator_N_fins = (evaporator_N_tubes - 1) * evaporator_L / evaporator_fin_spacing; % Total number of fins
evaporator_air_area_fins = 2 * evaporator_N_fins * evaporator_W * evaporator_gap_H; % [m^2] Total fin surface area
evaporator_tube_area_webs = 2 * evaporator_N_tubes * (evaporator_N_tube_channels - 1) * evaporator_L * evaporator_tube_H; % [m^2] Total surface area of webs in refrigerant tubes
evaporator_tube_Leq = 2*(evaporator_H + 20*evaporator_tube_H*evaporator_N_tubes); ...
    + (evaporator_N_tube_channels - 1)*evaporator_L*evaporator_tube_H/(evaporator_W + evaporator_tube_H); % [m] Additional equivalent tube length for losses due to manifold, splits, and webs

%% Chiller

chiller_N_tubes = 100; % Number of refrigerant tubes
chiller_tube_L = 0.4; % [m] Length of each refrigerant tube
chiller_tube_D = 0.0035; % [m] Diameter of each refrigerant tube
chiller_wall_thickness = 1e-4; % [m] Material thickness
chiller_wall_conductivity = 240; % [W/m/K] Material thermal conductivity
chiller_N_baffles = 3; % Number of coolant baffles

chiller_area_primary = chiller_N_tubes * pi * chiller_tube_D * chiller_tube_L; % [m^2] Primary heat transfer surface area
chiller_area_baffles = chiller_N_baffles * 0.7 * 2 * chiller_N_tubes*((2*chiller_tube_D)^2 - pi*chiller_tube_D^2/4); % [m^2] Total surface area of coolant baffles
chiller_tube_Leq = 2*0.2*chiller_tube_D*chiller_N_tubes; % [m] Additonal equivalent tube length for losses due to manifold and splits.

%% Battery Pack

battery_Np = 2;                          % Number of parallel cells in a string
battery_Ns = 20;                         % Number of series connected strings
battery_N_cells = battery_Np*battery_Ns; % Number of cells per module
% 
battery_cell_mass = 0.125; % [kg] Cell mass
battery_cell_cp = 795; % [J/kg/K] Cell specific heat

battery_SOC_LUT = [0 0.1 0.25 0.5 0.75 0.9 1]';   % State of charge table breakpoints S
battery_temperature_LUT = [278 293 313];          % Temperature table breakpoints T
battery_capacity_LUT = [28.0081 27.6250 27.6392]; % Battery cell capacity at different (T) points [Ahr]
battery_Em_LUT = [
    3.4966    3.5057    3.5148
    3.5519    3.5660    3.5653
    3.6183    3.6337    3.6402
    3.7066    3.7127    3.7213
    3.9131    3.9259    3.9376
    4.0748    4.0777    4.0821
    4.1923    4.1928    4.1930]; % [V] Em open-circuit voltage vs SOC rows and T columns
battery_R0_LUT = [
    0.0117    0.0085    0.0090
    0.0110    0.0085    0.0090
    0.0114    0.0087    0.0092
    0.0107    0.0082    0.0088
    0.0107    0.0083    0.0091
    0.0113    0.0085    0.0089
    0.0116    0.0085    0.0089]; % [Ohm] R0 resistance vs SOC rows and T columns
battery_R1_LUT = [
    0.0109    0.0029    0.0013
    0.0069    0.0024    0.0012
    0.0047    0.0026    0.0013
    0.0034    0.0016    0.0010
    0.0033    0.0023    0.0014
    0.0033    0.0018    0.0011
    0.0028    0.0017    0.0011]; % [Ohm] R1 Resistance vs SOC rows and T columns
battery_C1_LUT = [
    1913.6    12447    30609
    4625.7    18872    32995
    23306     40764    47535
    10736     18721    26325
    18036     33630    48274
    12251     18360    26839
    9022.9    23394    30606]; % [F] C1 Capacitance vs SOC rows and T columns

battery_Tau1_LUT = battery_R1_LUT.*battery_C1_LUT;

battery_cell_H = 0.2;   % Battery cell height [m]
battery_cell_T = 0.012; % Battery cell thickness [m]
battery_cell_W = 0.12;  % Battery cell width [m]

battery_extR = 0;       % Battery Module ascessory resistance (Ohm)
battery_moduleCellR0_ini  = ones(1,battery_N_cells);                   % Cell-to-cell capacity variation (-)
battery_moduleCellSOC_ini = battery_SOC_init*ones(1,battery_N_cells);  % Cell-to-cell initial SOC variation (-)
battery_moduleCellT_ini = (battery_T_init+273)*ones(1,battery_N_cells);% Cell-to-cell initial temperature variation (K)
battery_moduleExtHeat = zeros(1,battery_N_cells);                      % Cell-to-cell external heat flux variation (W)
% Cell-to-cell variation in Resistance R0 
battery_moduleCellAhr_ini01 = ones(1,battery_N_cells);                  % Cell-to-cell resistance variation (-) for 1st Module
battery_moduleCellAhr_ini02 = ones(1,battery_N_cells);                  % Cell-to-cell resistance variation (-) for 2nd Module
battery_moduleCellAhr_ini03 = ones(1,battery_N_cells);                  % Cell-to-cell resistance variation (-) for 3rd Module
battery_moduleCellAhr_ini04 = ones(1,battery_N_cells);                  % Cell-to-cell resistance variation (-) for 4th Module
sampleDistribution160=load('num160Data.txt');
battery_moduleCellAhr_ini01(1:battery_N_cells)=sort(sampleDistribution160(1:battery_N_cells)');
battery_moduleCellAhr_ini02(1:battery_N_cells)=sort(sampleDistribution160(battery_N_cells+1:2*battery_N_cells)');
battery_moduleCellAhr_ini03(1:battery_N_cells)=sort(sampleDistribution160(2*battery_N_cells+1:3*battery_N_cells)');
battery_moduleCellAhr_ini04(1:battery_N_cells)=sort(sampleDistribution160(3*battery_N_cells+1:4*battery_N_cells)');
%
battery_moduleSideHTC = 1; % Heat transfer coefficient on module sides
battery_thermal_K1 = 0.8;  % Battery cell (through-plane) thermal conductivity [W/mK]
battery_thermal_K2 = 800;  % Battery cell (in-plane) thermal conductivity [W/mK]
%
%% Parameter changes as per selected secnario
subsys = [bdroot '/Scenario'];
if user_selection == 1
    % Switch signal builder group
    signalbuilder([subsys '/Vehicle Speed [km//hr]'], 'ActiveGroup', 1) % Drive cycle
    % Update constant block values
    set_param([subsys '/Pressure [MPa]'], 'Value', '0.101325') % [MPa] Environment pressure
    set_param([subsys '/Temperature [degC]'], 'Value', '30') % [degC] Environment temperature
    set_param([subsys '/Relative Humidity'], 'Value', '0.4') % Environment relative humidity
    set_param([subsys '/CO2 Fraction'], 'Value', '4e-4') % Environment CO2 mole fraction
    set_param([subsys '/Temperature Setpoint [degC]'], 'Value', '21') % [degC] Cabin AC setpoint
    set_param([subsys '/AC On//Off'], 'Value', '1') % Cabin AC on or off
    set_param([subsys '/Recirculation On//Off'], 'Value', '0') % Cabin AC recirculation on or off
    set_param([subsys '/Number of Occupants'], 'Value', '1') % Number of occupants in cabin
    % Workspace variables
    cabin_p_init   = 0.101325;
    cabin_T_init   = 30;
    cabin_RH_init  = 0.4;
    cabin_CO2_init = 4e-4;
    coolant_p_init = 0.101325;
    coolant_T_init = 30;
    refrigerant_p_init     = 0.8;
    refrigerant_alpha_init = 0.6;
    battery_T_init   = 30;
    battery_SOC_init = 0.95;
    %
elseif user_selection == 2
    % Switch signal builder group
    signalbuilder([subsys '/Vehicle Speed [km//hr]'], 'ActiveGroup', 2) % Zero speed
    % Update constant block values
    set_param([subsys '/Pressure [MPa]'], 'Value', '0.101325') % [MPa] Environment pressure
    set_param([subsys '/Temperature [degC]'], 'Value', '40') % [degC] Environment temperature
    set_param([subsys '/Relative Humidity'], 'Value', '0.5') % Environment relative humidity
    set_param([subsys '/CO2 Fraction'], 'Value', '4e-4') % Environment CO2 mole fraction
    set_param([subsys '/Temperature Setpoint [degC]'], 'Value', '21') % [degC] Cabin AC setpoint
    set_param([subsys '/AC On//Off'], 'Value', '1') % Cabin AC on or off
    set_param([subsys '/Recirculation On//Off'], 'Value', '1') % Cabin AC recirculation on or off
    set_param([subsys '/Number of Occupants'], 'Value', '1') % Number of occupants in cabin
    % Workspace variables
    cabin_p_init   = 0.101325;
    cabin_T_init   = 40;
    cabin_RH_init  = 0.5;
    cabin_CO2_init = 4e-4;
    coolant_p_init = 0.101325;
    coolant_T_init = 40;
    refrigerant_p_init     = 1;
    refrigerant_alpha_init = 0.76;
    battery_T_init   = 40;
    battery_SOC_init = 0.95;
    %
elseif user_selection == 3
    % Switch signal builder group
    signalbuilder([subsys '/Vehicle Speed [km//hr]'], 'ActiveGroup', 1) % Drive cycle
    % Update constant block values
    set_param([subsys '/Pressure [MPa]'], 'Value', '0.101325') % [MPa] Environment pressure
    set_param([subsys '/Temperature [degC]'], 'Value', '-10') % [degC] Environment temperature
    set_param([subsys '/Relative Humidity'], 'Value', '0.5') % Environment relative humidity
    set_param([subsys '/CO2 Fraction'], 'Value', '4e-4') % Environment CO2 mole fraction
    %set_param([subsys '/Temperature Setpoint [degC]'], 'Value', '21') % [degC] Cabin AC setpoint
    set_param([subsys '/AC On//Off'], 'Value', '0') % Cabin AC on or off
    set_param([subsys '/Recirculation On//Off'], 'Value', '1') % Cabin AC recirculation on or off
    set_param([subsys '/Number of Occupants'], 'Value', '1') % Number of occupants in cabin
    cabin_p_init   = 0.101325;
    cabin_T_init   = -10;
    cabin_RH_init  = 0.5;
    cabin_CO2_init = 4e-4;
    coolant_p_init = 0.101325;
    coolant_T_init = -10;
    refrigerant_p_init     = 0.2;
    refrigerant_alpha_init = 0.15;
    battery_T_init   = -10;
    battery_SOC_init = 0.95;
    %
else
    % Error
end
battery_moduleCellSOC_ini = battery_SOC_init*ones(1,battery_N_cells);
battery_moduleCellT_ini   = (battery_T_init+273)*ones(1,battery_N_cells);
% Update Scenario subsystem tag for annotation
set_param(subsys, 'Tag', scenario)
