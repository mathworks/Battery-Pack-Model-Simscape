%% Parameters for battery_module_design
% 

% Copyright 2020-2024 The MathWorks, Inc.

%% Battery Module : Cell Electrical
battery_vecT=[273.15, 298.15, 323.15]; % [K]
battery_Ahr=20.8;                      % [Ahr]
battery_vecSOC=[0, .25, .75, 1];       % [-]
%
battery_V0=[3.20, 3.10, 3.14; ...
            3.25, 3.27, 3.30;...
            3.28, 3.31, 3.34;...
            3.33, 3.50, 3.59];         % No-load voltage, V0(SOC,T)
battery_R0=2*[.030, .015, .002; ...
            .040, .017, .008; ...
            .039, .012, .006; ...
            .027, .013, .021];         % Terminal resistance, R0(SOC,T)
battery_R1=[.089, .076, .010; ...
            .042, .022, .099; ...
            .019, .007, .002; ...
            .051, .043, .029];         % First polarization resistance, R1(SOC,T)
battery_Tau1=[44, 148, 235; ...
              93, 110, 1000; ...
              19, 27, 133; ...
              .5, 22, 3];              % First time constant, tau1(SOC,T)
battery_R2=[.014, .382, .407; ...
            .028, .006, .007; ...
            .014, .007, .006; ...
            .333, .956, .912];         % Second polarization resistance, R2(SOC,T)
battery_Tau2=[1, 44, 5644; ...
              11, 24, 506; ...
              2, 14, 330; ...
              3310, 13419, 30216];     % Second time constant, tau2(SOC,T)

%% Battery Module : Cell Thermal          
battery_thermalMass=500;               % Battery cell thermal mass
battery_thermalK_thru=0.8;             % Battery cell through-plane thermal conductivity
battery_thermalK_in=20;                % Battery cell in-plane thermal conductivity
          
%% Battery Module : Module Electrical
battery_Np=2;
battery_Ns=15;
battery_cellH=0.65;
battery_cellW=0.20;
battery_cellT=0.02;
battery_extR=0.001;

%% Battery Module : Module Thermal
battery_sidesHTC=1;
battery_extHeat=zeros(1,battery_Np*battery_Ns);

%% Battery Module : Cell-to-Cell Variation
battery_iniT=ambientTemp*ones(1,battery_Np*battery_Ns);
battery_iniSOC=initialSOCvalue*ones(1,battery_Np*battery_Ns);
battery_varAhr=ones(1,battery_Np*battery_Ns);
battery_varR0=ones(1,battery_Np*battery_Ns);

%% Coolant Plate
coolantPlate_iniT=ambientTemp;
coolantPlate_spHeat=447;
coolantPlate_density=2500;
coolantPlate_thermalK=200;
coolantPlate_nChannels=6;
coolantPlate_diaChannels=0.005;
coolantPlate_diaDistributor=sqrt(coolantPlate_nChannels)*coolantPlate_diaChannels;
coolantPlate_thickness=0.003;
coolantPlate_roughness=1e-5;
