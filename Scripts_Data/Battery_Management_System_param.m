%% Parameters for Lithium-Ion Battery Pack cooling example
% Battery cooling example setup and workspace variables
% 
% Copyright 2021 The MathWorks, Inc.
% 
samplingTime=1;   % Sampling time (s)
ambient=300;        % Ambient temperature in K
coolantTemp=300;    % Coolant inlet temperature in K
initialPackSOC=0.9;	% Pack intial SOC (-)
% -------------------------------------------------------------------------
%% Cell Electrical
T_vec=[278 293 313];                 % Temperature vector T [K]
AH_vec=[28.0081 27.6250 27.6392];    % Cell capacity vector AH(T) [Ahr]
SOC_vec=[0 0.1 0.25 0.5 0.75 0.9 1]; % Cell state of charge vector SOC [-]
%
V0_mat=[
    3.4966    3.5057    3.5148
    3.5519    3.5660    3.5653
    3.6183    3.6337    3.6402
    3.7066    3.7127    3.7213
    3.9131    3.9259    3.9376
    4.0748    4.0777    4.0821
    4.1923    4.1928    4.1930]; % [V] Em open-circuit voltage vs SOC rows and T columns
R0_mat=[
    0.0117    0.0085    0.0090
    0.0110    0.0085    0.0090
    0.0114    0.0087    0.0092
    0.0107    0.0082    0.0088
    0.0107    0.0083    0.0091
    0.0113    0.0085    0.0089
    0.0116    0.0085    0.0089]; % [Ohm] R0 resistance vs SOC rows and T columns
R1_mat=[
    0.0109    0.0029    0.0013
    0.0069    0.0024    0.0012
    0.0047    0.0026    0.0013
    0.0034    0.0016    0.0010
    0.0033    0.0023    0.0014
    0.0033    0.0018    0.0011
    0.0028    0.0017    0.0011]; % [Ohm] R1 Resistance vs SOC rows and T columns
C1_mat=[
    1913.6    12447    30609
    4625.7    18872    32995
    23306     40764    47535
    10736     18721    26325
    18036     33630    48274
    12251     18360    26839
    9022.9    23394    30606]; % [F] C1 Capacitance vs SOC rows and T columns
Tau1_mat=R1_mat.*C1_mat;
Ndisc=100;delV0=0;delR0=0;delR1=0;delR2=0;delAH0=0; % No change with cycling, not used in simulation
% -------------------------------------------------------------------------
%% Cell Thermal
MdotCp=100;        % Cell thermal mass (mass times specific heat [J/K])
K_cell=0.8;        % Cell thermal conductivity [W/(m*K)]
h_cell=2;          % Heat transfer coefficient to ambient [W/(m^2*K)]
% -------------------------------------------------------------------------
%% Module Electrical
R12=2e-3;          % Module1-to-module2 connection resistance
cell_H=0.20;       % Cell height [m]
cell_W=0.12;       % Cell width [m]
cell_T=0.02;       % Cell thickness [m]
Ns1=10;             % Module-1 Number of series connected strings
Np1=1;             % Module-1 Number of parallel cells per string
Rext1=1e-3;        % Module-1 Accessory total resistance
Ns2=Ns1;           % Module-2 Number of series connected strings
Np2=Np1;           % Module-2 Number of parallel cells per string
Rext2=Rext1;       % Module-2 Accessory total resistance
% -------------------------------------------------------------------------
%% Module Thermal
Flowrate_vec=[0 0.02 0.04 0.06 0.08 0.10];   % Flowrate vector L [kg/s]
lenF=size(Flowrate_vec,2);lenT=size(T_vec,2);% Temporary variables for size
Q1=1.2*ones(lenT,lenF,Ns1*Np1);              % Module-1 Effective rate of coolant heat transfer from each cell
extQ1=zeros(1,Ns1*Np1);                      % Module-1 Cell-to-Cell External Heat variation          
Q2=Q1;                                       % Module-2 Effective rate of coolant heat transfer from each cell
extQ2=extQ1;                                 % Module-2 Cell-to-Cell External Heat variation          
%% Cell-to-cell variation
iniT1=ambient*ones(1,Ns1*Np1);          % Module-1 Cell-to-Cell initial Temperature variation
iniSOC1=initialPackSOC*ones(1,Ns1*Np1); % Module-1 Cell-to-Cell initial SOC variation
iniR01=ones(1,Ns1*Np1);                 % Module-1 Cell-to-Cell Terminal Resistance variation
iniAH1=ones(1,Ns1*Np1);                 % Module-1 Cell-to-Cell capacity variation vector
iniT2=iniT1;                            % Module-2 Cell-to-Cell initial Temperature variation
iniSOC2=iniSOC1;                        % Module-2 Cell-to-Cell initial SOC variation
iniR02=iniR01;                          % Module-2 Cell-to-Cell Terminal Resistance variation
iniAH2=iniAH1;                          % Module-2 Cell-to-Cell capacity variation vector
% One of the cell (1st cell of the first module) has higher R0 than the other cells
iniR01(1,1)=1.05;
% One of the cell (3rd cell of second module) has lower R0 than other cells
iniR02(1,3)=0.97;
