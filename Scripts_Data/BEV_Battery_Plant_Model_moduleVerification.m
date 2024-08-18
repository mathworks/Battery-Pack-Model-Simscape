% Module verification between the Betailed and the Thermal Lookup Table 
% based approach
% 

% Copyright 2020-2024 The MathWorks, Inc.

disp('Start Detailed to Grouped model verification')
vec_coolant_T=module_LUTthermalData{1};
vec_coolant_F=module_LUTthermalData{2};
mat_cellQ=module_LUTthermalData{3};

BEV_Battery_Plant_Model_paramModule;
coolantPlate_area=battery_cellW*battery_Ns*battery_Np*battery_cellT;
coolantPlate_nChannels=numChannelsOpt;
coolantPlate_diaDistributor=sqrt(coolantPlate_nChannels)*coolantPlate_diaChannels;
coolantPlate_thickness=max(coolantPlate_diaChannels,(pi*0.25*coolantPlate_diaDistributor^2)/min(coolantPlate_distributorWidMax,coolantPlate_diaDistributor));
coolantPlate_mass=(coolantPlate_area*coolantPlate_thickness)*coolantPlate_density-(coolantPlate_nChannels*0.25*battery_cellW*pi*coolantPlate_diaChannels^2)*(coolantPlate_density-1000);
%
tic
sim('Battery_Module_Design');
runtime_detailedModel=toc;
bmd_t=simlog_Battery_Module_Design.Current_Source.i.series.time;
bmd_I=simlog_Battery_Module_Design.Current_Source.i.series.values;
bmd_T=simlog_Battery_Module_Design.BatteryModule.outputCellTemp.series.values;
bmd_SOC=simlog_Battery_Module_Design.BatteryModule.outputCellSOC.series.values;
bmd_Tmax=max(bmd_T,[],2);
bmd_Tmin=min(bmd_T,[],2);
bmd_SOCmax=max(bmd_SOC,[],2);
bmd_SOCmin=min(bmd_SOC,[],2);
%
FlwR=coolantMassFlowRate/max(vec_coolant_F);
FlwT=coolantTemp-ambientTemp; 
%
tic
sim('Battery_Module_Design_Grouped');
runtime_groupedModel=toc;
fprintf('Runtime comparison \n *** Detailed Model = %.1f seconds \n *** Grouped Model = %.1f seconds \n',runtime_detailedModel,runtime_groupedModel)
%
bmp_t=simlog_Battery_Module_Design_Grouped.Current_Source.i.series.time;
bmp_I=simlog_Battery_Module_Design_Grouped.Current_Source.i.series.values;
bmp_T=simlog_Battery_Module_Design_Grouped.BatteryModule.outputCellTemp.series.values;
bmp_SOC=simlog_Battery_Module_Design_Grouped.BatteryModule.outputCellSOC.series.values;
bmp_Tmax=max(bmp_T,[],2);
bmp_Tmin=min(bmp_T,[],2);
bmp_SOCmax=max(bmp_SOC,[],2);
bmp_SOCmin=min(bmp_SOC,[],2);
%
figure(1)
simlog_handles(1) = subplot(3, 1, 1);
plot(bmd_t,bmd_SOCmax,'r')
hold on
plot(bmd_t,bmd_SOCmin,'b')
hold on
plot(bmp_t,bmp_SOCmax,'r--')
hold on
plot(bmp_t,bmp_SOCmin,'b--')
hold off
legend('SOC max - Detailed Thermal','SOC min - Detailed Thermal',...
       'SOC max - LUT based Thermal','SOC min - LUT based Thermal',...
       'Location','southeast')
%
title('Battery Module : Detailed Model vs. Grouped Model')
simlog_handles(2) = subplot(3, 1, 2);
plot(bmd_t,bmd_Tmax,'r')
hold on
plot(bmd_t,bmd_Tmin,'b')
hold on
plot(bmp_t,bmp_Tmax,'r--')
hold on
plot(bmp_t,bmp_Tmin,'b--')
hold off
legend('Tmax - Detailed Thermal','Tmin - Detailed Thermal',...
       'Tmax - LUT based Thermal','Tmin - LUT based Thermal',...
       'Location','northeast')
simlog_handles(3) = subplot(3, 1, 3);
plot(bmd_t,bmd_I,'b')
hold on
plot(bmp_t,bmp_I,'b--')
hold off
legend('Detailed Thermal','LUT based Thermal')
%
disp('Completed model verification')

