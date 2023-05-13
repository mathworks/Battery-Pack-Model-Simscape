% Startup script for Battery Examples
% Copyright 2020-2023 The MathWorks, Inc.

curr_proj = simulinkproject;
cd(curr_proj.RootFolder)
cd('Libraries')

% Build custom library
if(exist('+batteryModule','dir') && ~exist('batteryModule_lib.slx','file'))
    ssc_build batteryModule
end

cd(curr_proj.RootFolder)

