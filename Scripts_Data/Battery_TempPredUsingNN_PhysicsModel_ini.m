%% Parameters for Lithium-Ion Battery Pack cooling example
% Battery cooling example setup and workspace variables

% Copyright 2020 The MathWorks, Inc.

coolantTemp=298.15;   % Coolant inlet T in K
ambient=298.15;       % Ambient temperature in K
FlwT=coolantTemp-ambient;
initialPackSOC=0.995; % Pack intial SOC (-)
FlwR=1; 
%% Lookup Table Points
T_vec=[273.15, 298.15, 323.15];             % Temperature vector T [K]
AH_vec=[14, 20, 21];                        % Cell capacity vector AH(T) [Ahr]
SOC_vec=[0, .25, .75, 1];                   % Cell state of charge vector SOC [-]
Flowrate_vec=[0 0.01 0.02 0.03 0.04 0.05];  % Flowrate vector L [kg/s]
%
%% Cell Electrical
V0_mat=[3.2, 3.1, 3.14; 3.25, 3.27, 3.3; 3.28, 3.31, 3.34; 3.33, 3.5, 3.59];    % V0=f(SOC,T), cell OCV [V]
R0_mat=[.03, .015, .002; .04, .017, .008; .039, .012, .006; .027, .013, .021];  % R0=f(SOC,T), cell Ohmic Resistance [Ohm]
Ndisc=100;delV0=0;delR0=0;delAH=0;                                              % No change with cycling, not used in simulation
%
%% Cell Thermal
MdotCp=500; % Cell thermal mass (mass times specific heat [J/K])
K_cell=0.8; % Cell thermal conductivity [W/(m*K)]
h_cell=2.5;   % Heat transfer coefficient to ambient [W/(m^2*K)]
%
%% Module Electrical
cell_H=0.20;       % Cell height [m]
cell_W=0.12;       % Cell width [m]
cell_T=0.02;       % Cell thickness [m]
%% Module 1,2,3 : same in construction
% Module Electrical
Ns=5;              % Number of series connected strings
Np=2;              % Number of parallel cells in string
Rext=1e-3;         % Additional resistance - busbars, cables, cell tabs [Ohm]
coolantQ=zeros(3,6,Ns*Np); % Module A cooling [W/K]; vector of size (T,L,Ns*Np)
for i=1:Ns*Np
    coolantQ(:,:,i)=(1+0.2*(i-Ns*Np/2)/(Ns*Np/2))*[0 .3 .6 .9 1.2 1.5;0 .3 .6 .9 1.2 1.5;0 .3 .6 .9 1.2 1.5]; 
end
extHeat=zeros(1,Ns*Np);
% Cell-to-Cell Variation
AhrVar=ones(1,Ns*Np);                      % No variation
R0Var=ones(1,Ns*Np);                       % No variation
cellT_ini=ambient*ones(1,Ns*Np);           % Initial cell temperature [K]
cellSOC_ini=initialPackSOC*ones(1,Ns*Np);  % Initial cell SOC (-)
%
%% Module 4 : it is different from Modules 1,2,3
% Module Electrical - module 4
Ns4=6;                        % Number of series connected strings
Np4=2;                        % Number of parallel cells in string
Rext4=2.3e-3;                 % Additional resistance - busbars, cables, cell tabs [Ohm]
coolantQ4=zeros(3,6,Ns4*Np4); % Module A cooling [W/K]; vector of size (T,L,Ns*Np)
for i=1:Ns4*Np4
    coolantQ4(:,:,i)=(1+0.1*(i-Ns4*Np4/2)/(Ns4*Np4/2))*[0 .3 .6 .9 1.2 1.5;0 .3 .6 .9 1.2 1.5;0 .3 .6 .9 1.2 1.5];
end
extHeat4=zeros(1,Ns4*Np4);
% Cell-to-Cell Variation - module 4
AhrVar4=ones(1,Ns4*Np4);                      % No variation
R0Var4=ones(1,Ns4*Np4);                       % No variation
cellT_ini4=ambient*ones(1,Ns4*Np4);           % Initial cell temperature [K]
cellSOC_ini4=initialPackSOC*ones(1,Ns4*Np4);  % Initial cell SOC (-)
