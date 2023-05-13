% Code to plot simulation results from Battery_Management_System
%% Plot Description:
%
% Copyright 2021-2023 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
if ~exist('simlog_Battery_Management_System', 'var') || ...
        pm_simlogNeedsUpdate(simlog_Battery_Management_System) 
    sim('Battery_Management_System')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_Battery_Management_System', 'var') || ...
        ~isgraphics(h1_Battery_Management_System, 'figure')
    h1_Battery_Management_System = figure('Name', 'Battery_Management_System');
end
figure(h1_Battery_Management_System)
clf(h1_Battery_Management_System)

% Get simulation results
simlog_t=simlog_Battery_Management_System.DC.Current_Source.i.series.time;
simlog_I=simlog_Battery_Management_System.DC.Current_Source.i.series.values;
simlog_minSOC_error=Battery_Management_System_Scope{5}.Values.Data(:,1)...
                    -Battery_Management_System_Scope{5}.Values.Data(:,2);
simlog_maxSOC_error=Battery_Management_System_Scope{6}.Values.Data(:,1)...
                    -Battery_Management_System_Scope{6}.Values.Data(:,2);

% Plot results
simlog_handles(1) = subplot(3, 1, 1);
plot(simlog_t, simlog_I, 'LineWidth', 1)
title('Battery Pack Current')
ylabel('Current (A)')
xlabel('Time (s)')
%
simlog_handles(2) = subplot(3, 1, 2);
plot(simlog_t, abs(simlog_minSOC_error),'r')
title('Error in min. State of Charge (actual~prediction) prediction')
ylabel('actual~prediction')
xlabel('Time (s)')
ylim([-0.05 0.05])
%
simlog_handles(3) = subplot(3, 1, 3);
plot(simlog_t, abs(simlog_maxSOC_error),'r')
title('Error in max. State of Charge (actual~prediction) prediction')
ylabel('actual~prediction')
xlabel('Time (s)')
ylim([-0.05 0.05])

% Remove temporary variables
clear simlog_t simlog_SOC simlog_I simlog_minSOC_error simlog_maxSOC_error
clear simlog_handles Battery_Management_System_Scope
