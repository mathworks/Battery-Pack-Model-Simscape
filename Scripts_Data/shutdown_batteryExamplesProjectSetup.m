% Shutdown script for Battery Examples
% Copyright 2020-2021 The MathWorks, Inc.

curr_proj = simulinkproject;
cd(curr_proj.RootFolder)
cd('Libraries')

bdclose('Battery_Pack_Thermal_Management');

bdclose('EV_Thermal_Management');

bdclose('Battery_Module_Design');
bdclose('Battery_Module_Design_Grouped');
bdclose('Battery_Module_To_FullPack_Grouped');

bdclose('batteryModule_lib');
bdclose('detailedThermalModel_demo');
bdclose('batteryModuleDoc_example');

% Build custom library
if(exist('+batteryModule','dir') && exist('batteryModule_lib.slx','file'))
    ssc_clean batteryModule
end

cd(curr_proj.RootFolder)
