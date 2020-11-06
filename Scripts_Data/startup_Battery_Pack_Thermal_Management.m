% Startup script for Battery Pack Thermal Management
% Copyright 2020 The MathWorks, Inc.

curr_proj = simulinkproject;
cd(curr_proj.RootFolder)
cd('Libraries')

% Build custom library
if(exist('+batteryModule','dir') && ~exist('batteryModule_lib.slx','file'))
    ssc_build batteryModule
end

cd(curr_proj.RootFolder)
open_system('Battery_Pack_Thermal_Management');