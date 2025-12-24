%% Parameters for Lithium-Ion Battery Pack cooling example
% Battery cooling example setup and workspace variables
% 
% Copyright 2020-2025 The MathWorks, Inc.
% 
ambient=300;        % Ambient temperature in K
coolantTemp=300;    % Coolant inlet temperature in K
initialPackSOC=0.9;	% Pack intial SOC (-)
%% Module-to-Module Connections
% Busbar resistances
R12=2e-3;           % Module1-to-module2 connection resistance
R23=2e-3;           % Module2-to-module3 connection resistance
R34=2e-3;           % Module3-to-module4 connection resistance
R45=2e-3;           % Module4-to-module5 connection resistance
R56=2e-3;           % Module5-to-module6 connection resistance
R67=2e-3;           % Module6-to-module7 connection resistance
R78=2e-3;           % Module7-to-module8 connection resistance
% -------------------------------------------------------------------------
%% Lookup Table Points
T_vec=[273.15, 298.15, 323.15];               % Temperature vector T [K]
AH=20;                                        % Cell capacity vector AH(T) [Ahr]
SOC_vec=[0, .25, .75, 1];                     % Cell state of charge vector SOC [-]
Flowrate_vec=[0 0.01 0.02 0.03 0.04 0.05];    % Flowrate vector L [kg/s]
lenF=size(Flowrate_vec,2);lenT=size(T_vec,2); % Temporary variables for size

% -------------------------------------------------------------------------
%% Cell Electrical
V0_mat=[3.2, 3.1, 3.14; 3.25, 3.27, 3.3; 3.28, 3.31, 3.34; 3.33, 3.5, 3.59];      % V0=f(SOC,T), cell OCV [V]
R0_mat=3*[.03, .015, .002; .04, .017, .008; .039, .012, .006; .027, .013, .021];  % R0=f(SOC,T), cell Ohmic Resistance [Ohm]
R1_mat=2*[.089, .076, .01; .042, .022, .099; .019, .007, .002; .051, .043, .029]; % R1=f(SOC,T), cell 1st RC pair Resistance [Ohm]
Tau1_mat=[44, 148, 235; 93, 110, 1000; 19, 27, 133; .5, 22, 3];                   % Tau1=f(SOC,T), cell 1st RC pair time constant [s]
R2_mat=2*[.014, .382, .407; .028, .006, .007; .014, .007, .006; .333, .956, .912];% R2=f(SOC,T), cell 2nd RC pair Resistance [Ohm]
Tau2_mat=[1, 44, 5644; 11, 24, 506; 2, 14, 330; 3310, 13419, 30216];              % Tau2=f(SOC,T), cell 2nd RC pair time constant [s]
Ndisc=100;delV0=0;delR0=0;delR1=0;delR2=0;delAH0=0;                               % No change with cycling, not used in simulation
% -------------------------------------------------------------------------
%% Cell Thermal
MdotCp=500;        % Cell thermal mass (mass times specific heat [J/K])
K_cell=0.8;        % Cell thermal conductivity [W/(m*K)]
h_cell=2;          % Heat transfer coefficient to ambient [W/(m^2*K)]
% -------------------------------------------------------------------------
%% Module Electrical
cell_H=0.20;       % Cell height [m]
cell_W=0.12;       % Cell width [m]
cell_T=0.02;       % Cell thickness [m]
% -------------------------------------------------------------------------
%% Module 1-8 
    % Module 1
    Ns1=12;                                 % Module-1 Number of series connected strings
    Np1=3;                                  % Module-1 Number of parallel cells per string
    Rext1=1e-3;                             % Module-1 Accessory total resistance
    Q1=5*ones(lenT,lenF,Ns1*Np1);           % Module-1 Effective rate of coolant heat transfer from each cell
    extQ1=zeros(1,Ns1*Np1);                 % Module-1 Cell-to-Cell External Heat variation          
    iniT1=ambient*ones(1,Ns1*Np1);          % Module-1 Cell-to-Cell initial Temperature variation
    iniSOC1=initialPackSOC*ones(1,Ns1*Np1); % Module-1 Cell-to-Cell initial SOC variation
    iniR01=ones(1,Ns1*Np1);                 % Module-1 Cell-to-Cell Terminal Resistance variation
    iniAH1=ones(1,Ns1*Np1);                 % Module-1 Cell-to-Cell capacity variation vector
    % Module 2 - same as Module 1
    Ns2=Ns1;                                % Module-2 Number of series connected strings
    Np2=Np1;                                % Module-2 Number of parallel cells per string
    Rext2=Rext1;                            % Module-2 Accessory total resistance
    Q2=Q1;                                  % Module-2 Effective rate of coolant heat transfer from each cell
    extQ2=extQ1;                            % Module-2 Cell-to-Cell External Heat variation          
    iniT2=iniT1;                            % Module-2 Cell-to-Cell initial Temperature variation
    iniSOC2=iniSOC1;                        % Module-2 Cell-to-Cell initial SOC variation
    iniR02=iniR01;                          % Module-2 Cell-to-Cell Terminal Resistance variation
    iniAH2=iniAH1;                          % Module-2 Cell-to-Cell capacity variation vector
    % Module 3 - same as Module 1
    Ns3=Ns1;                                % Module-3 Number of series connected strings
    Np3=Np1;                                % Module-3 Number of parallel cells per string
    Rext3=Rext1;                            % Module-3 Accessory total resistance
    Q3=Q1;                                  % Module-3 Effective rate of coolant heat transfer from each cell
    extQ3=extQ1;                            % Module-3 Cell-to-Cell External Heat variation          
    iniT3=iniT1;                            % Module-3 Cell-to-Cell initial Temperature variation
    iniSOC3=iniSOC1;                        % Module-3 Cell-to-Cell initial SOC variation
    iniR03=iniR01;                          % Module-3 Cell-to-Cell Terminal Resistance variation
    iniAH3=iniAH1;                          % Module-3 Cell-to-Cell capacity variation vector
    % Module 4
    Ns4=16;                                 % Module-4 Number of series connected strings
    Np4=3;                                  % Module-4 Number of parallel cells per string
    Rext4=1.3e-3;                           % Module-4 Accessory total resistance
    Q4=4.2*ones(lenT,lenF,Ns4*Np4);         % Module-4 Effective rate of coolant heat transfer from each cell
    extQ4=zeros(1,Ns4*Np4);                 % Module-4 Cell-to-Cell External Heat variation          
    iniT4=ambient*ones(1,Ns4*Np4);          % Module-4 Cell-to-Cell initial Temperature variation
    iniSOC4=initialPackSOC*ones(1,Ns4*Np4); % Module-4 Cell-to-Cell initial SOC variation
    iniR04=ones(1,Ns4*Np4);                 % Module-4 Cell-to-Cell Terminal Resistance variation
    iniAH4=ones(1,Ns4*Np4);                 % Module-4 Cell-to-Cell capacity variation vector
    % Module 5 - same as Module 4
    Ns5=Ns4;                                % Module-5 Number of series connected strings
    Np5=Np4;                                % Module-5 Number of parallel cells per string
    Rext5=Rext4;                            % Module-5 Accessory total resistance
    Q5=Q4;                                  % Module-5 Effective rate of coolant heat transfer from each cell
    extQ5=extQ4;                            % Module-5 Cell-to-Cell External Heat variation          
    iniT5=iniT4;                            % Module-5 Cell-to-Cell initial Temperature variation
    iniSOC5=iniSOC4;                        % Module-5 Cell-to-Cell initial SOC variation
    iniR05=iniR04;                          % Module-5 Cell-to-Cell Terminal Resistance variation
    iniAH5=iniAH4;                          % Module-5 Cell-to-Cell capacity variation vector
    % Module 6 - same as Module 1
    Ns6=Ns1;                                % Module-6 Number of series connected strings
    Np6=Np1;                                % Module-6 Number of parallel cells per string
    Rext6=Rext1;                            % Module-6 Accessory total resistance
    Q6=Q1;                                  % Module-6 Effective rate of coolant heat transfer from each cell
    extQ6=extQ1;                            % Module-6 Cell-to-Cell External Heat variation          
    iniT6=iniT1;                            % Module-6 Cell-to-Cell initial Temperature variation
    iniSOC6=iniSOC1;                        % Module-6 Cell-to-Cell initial SOC variation
    iniR06=iniR01;                          % Module-6 Cell-to-Cell Terminal Resistance variation
    iniAH6=iniAH1;                          % Module-6 Cell-to-Cell capacity variation vector
    % Module 7 - same as Module 1
    Ns7=Ns1;                                % Module-7 Number of series connected strings
    Np7=Np1;                                % Module-7 Number of parallel cells per string
    Rext7=Rext1;                            % Module-7 Accessory total resistance
    Q7=Q1;                                  % Module-7 Effective rate of coolant heat transfer from each cell
    extQ7=extQ1;                            % Module-7 Cell-to-Cell External Heat variation          
    iniT7=iniT1;                            % Module-7 Cell-to-Cell initial Temperature variation
    iniSOC7=iniSOC1;                        % Module-7 Cell-to-Cell initial SOC variation
    iniR07=iniR01;                          % Module-7 Cell-to-Cell Terminal Resistance variation
    iniAH7=iniAH1;                          % Module-7 Cell-to-Cell capacity variation vector
    % Module 8 - same as Module 1
    Ns8=Ns1;                                % Module-8 Number of series connected strings
    Np8=Np1;                                % Module-8 Number of parallel cells per string
    Rext8=Rext1;                            % Module-8 Accessory total resistance
    Q8=Q1;                                  % Module-8 Effective rate of coolant heat transfer from each cell
    extQ8=extQ1;                            % Module-8 Cell-to-Cell External Heat variation          
    iniT8=iniT1;                            % Module-8 Cell-to-Cell initial Temperature variation
    iniSOC8=iniSOC1;                        % Module-8 Cell-to-Cell initial SOC variation
    iniR08=iniR01;                          % Module-8 Cell-to-Cell Terminal Resistance variation
    iniAH8=iniAH1;                          % Module-8 Cell-to-Cell capacity variation vector
% -------------------------------------------------------------------------  
% Cell-to-Cell variation in Cell-Terminal-Resistance R0, modeled assuming a
% normal distribution (below)
% % Data already stored in file (*.mat)
% %     num312Data = NORMINV(RAND(),1,0.09) - in MS-Excel
% %     Data generated saved in file 'num312Data.txt'
% % 
sampleDistribution312=load('num312Data.txt');
totalCellsInFile=max(size(sampleDistribution312));
totalCells=Ns1*Np1+Ns2*Np2+Ns3*Np3+Ns4*Np4+Ns5*Np5+Ns6*Np6+Ns7*Np7+Ns8*Np8;
cellCount=[Ns1*Np1, Ns2*Np2, Ns3*Np3, Ns4*Np4, Ns5*Np5, Ns6*Np6, Ns7*Np7, Ns8*Np8];
if totalCells == totalCellsInFile
    iniR01=sort(sampleDistribution312(1:Ns1*Np1)');
    iniR02=sort(sampleDistribution312(Ns1*Np1+1:sum(cellCount(1:2)))');
    iniR03=sort(sampleDistribution312(sum(cellCount(1:2))+1:sum(cellCount(1:3)))');
    iniR04=sort(sampleDistribution312(sum(cellCount(1:3))+1:sum(cellCount(1:4)))');
    iniR05=sort(sampleDistribution312(sum(cellCount(1:4))+1:sum(cellCount(1:5)))');
    iniR06=sort(sampleDistribution312(sum(cellCount(1:5))+1:sum(cellCount(1:6)))');
    iniR07=sort(sampleDistribution312(sum(cellCount(1:6))+1:sum(cellCount(1:7)))');
    iniR08=sort(sampleDistribution312(sum(cellCount(1:7))+1:sum(cellCount(1:8)))');
end



