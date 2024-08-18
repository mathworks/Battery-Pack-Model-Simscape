% Code to plot simulation results from EV_Thermal_Management
%% Plot Description:
%
% Copyright 2020-2024 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
if ~exist('simlog_EV_Thermal_Management', 'var') || ...
        pm_simlogNeedsUpdate(simlog_EV_Thermal_Management) 
    sim('EV_Thermal_Management')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_EV_Thermal_Management', 'var') || ...
        ~isgraphics(h1_EV_Thermal_Management, 'figure')
    h1_EV_Thermal_Management = figure('Name', 'EV_Thermal_Management');
end
figure(h1_EV_Thermal_Management)
clf(h1_EV_Thermal_Management)

%% Battery Data
battery_current = simlog_EV_Thermal_Management.Battery.Current_Demand.i.series.values;

battery_Module01_Tmax = max(simlog_EV_Thermal_Management.Battery.Module1.outputCellTemp.series.values,[],2);
battery_Module02_Tmax = max(simlog_EV_Thermal_Management.Battery.Module2.outputCellTemp.series.values,[],2);
battery_Module03_Tmax = max(simlog_EV_Thermal_Management.Battery.Module3.outputCellTemp.series.values,[],2);
battery_Module04_Tmax = max(simlog_EV_Thermal_Management.Battery.Module4.outputCellTemp.series.values,[],2);
battery_Tmax=max(max(battery_Module01_Tmax,battery_Module02_Tmax),max(battery_Module03_Tmax,battery_Module04_Tmax))-273;
%
battery_Module01_Tmin = min(simlog_EV_Thermal_Management.Battery.Module1.outputCellTemp.series.values,[],2);
battery_Module02_Tmin = min(simlog_EV_Thermal_Management.Battery.Module2.outputCellTemp.series.values,[],2);
battery_Module03_Tmin = min(simlog_EV_Thermal_Management.Battery.Module3.outputCellTemp.series.values,[],2);
battery_Module04_Tmin = min(simlog_EV_Thermal_Management.Battery.Module4.outputCellTemp.series.values,[],2);
battery_Tmin=min(min(battery_Module01_Tmin,battery_Module02_Tmin),min(battery_Module03_Tmin,battery_Module04_Tmin))-273;
%
battery_Module01_minSOC = min(simlog_EV_Thermal_Management.Battery.Module1.outputCellSOC.series.values,[],2);
battery_Module02_minSOC = min(simlog_EV_Thermal_Management.Battery.Module2.outputCellSOC.series.values,[],2);
battery_Module03_minSOC = min(simlog_EV_Thermal_Management.Battery.Module3.outputCellSOC.series.values,[],2);
battery_Module04_minSOC = min(simlog_EV_Thermal_Management.Battery.Module4.outputCellSOC.series.values,[],2);
battery_SOCmin=min(min(battery_Module01_minSOC,battery_Module02_minSOC),min(battery_Module03_minSOC,battery_Module04_minSOC));
%
battery_Module01_maxSOC = max(simlog_EV_Thermal_Management.Battery.Module1.outputCellSOC.series.values,[],2);
battery_Module02_maxSOC = max(simlog_EV_Thermal_Management.Battery.Module2.outputCellSOC.series.values,[],2);
battery_Module03_maxSOC = max(simlog_EV_Thermal_Management.Battery.Module3.outputCellSOC.series.values,[],2);
battery_Module04_maxSOC = max(simlog_EV_Thermal_Management.Battery.Module4.outputCellSOC.series.values,[],2);
battery_SOCmax=max(max(battery_Module01_maxSOC,battery_Module02_maxSOC),max(battery_Module03_maxSOC,battery_Module04_maxSOC));
%
%% EV Components
motorT=simlog_EV_Thermal_Management.Motor.Temperature_Sensor.T.series.values-273;
chargerT=simlog_EV_Thermal_Management.Charger.Temperature_Sensor.T.series.values-273;
inverterT=simlog_EV_Thermal_Management.Inverter.Temperature_Sensor.T.series.values-273;
cabinT=simlog_EV_Thermal_Management.Cabin.Measurement_Selector_MA.T.series.values-273;
dcdcT=simlog_EV_Thermal_Management.DCDC.Temperature_Sensor.T.series.values-273;
% 
seriesTime=simlog_EV_Thermal_Management.Battery.Current_Demand.i.series.time;

%
simlog_handles(1) = subplot(3, 1, 1);
plot(seriesTime,battery_Tmax);
hold on
plot(seriesTime,motorT);
hold on
plot(seriesTime,chargerT);
hold on
plot(seriesTime,inverterT);
hold on
plot(seriesTime,dcdcT);
hold off
grid on
title('Component Temperature')
ylabel('Temperature (deg-C)')
xlabel('Time (s)')
legend('Battery','Motor','Charger','Inverter','DC-DC converter','Location','southeast')
%
simlog_handles(2) = subplot(3, 1, 2);
plot(seriesTime,battery_current);
title('DC current')
ylabel('Current (A)')
xlabel('Time (s)')
legend('Battery current')
%
simlog_handles(3) = subplot(3, 1, 3);
plot(seriesTime,battery_SOCmax);
hold on
plot(seriesTime,battery_SOCmin);
hold off
title('Battery charge imbalance')
ylabel('State of Charge (-)')
xlabel('Time (s)')
legend('max','min','Location','northeast')

% Remove temporary variables
clear battery_current battery_Tmin battery_Tmax battery_SOCmin battery_SOCmax
clear seriesTime simlog_handles motorT chargerT inverterT dcdcT cabinT
clear battery_Module01_Tmax battery_Module02_Tmax battery_Module03_Tmax battery_Module04_Tmax
clear battery_Module01_Tmin battery_Module02_Tmin battery_Module03_Tmin battery_Module04_Tmin
clear battery_Module01_minSOC battery_Module02_minSOC battery_Module03_minSOC battery_Module04_minSOC
clear battery_Module01_maxSOC battery_Module02_maxSOC battery_Module03_maxSOC battery_Module04_maxSOC



