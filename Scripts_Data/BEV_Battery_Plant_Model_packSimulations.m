% Module verification between the Betailed and the Thermal Lookup Table 
% based approach
% 

% Copyright 2020-2023 The MathWorks, Inc.

disp('Start battery pack simulations')
%
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
sim('Battery_Module_To_FullPack_Grouped');
packSim_runtime=toc;
fprintf('*** Pack simulation runtime = %.1f s for %.1f s \n',packSim_runtime)
% 
packSim_t=simlog_Battery_Module_To_FullPack_Grouped.Current_Source.i.series.time;
packSim_I=simlog_Battery_Module_To_FullPack_Grouped.Current_Source.i.series.values;
%
packSim_M1_SOC=simlog_Battery_Module_To_FullPack_Grouped.BatteryPlantModel.Module1.outputCellSOC.series.values;
packSim_M2_SOC=simlog_Battery_Module_To_FullPack_Grouped.BatteryPlantModel.Module2.outputCellSOC.series.values;
packSim_M3_SOC=simlog_Battery_Module_To_FullPack_Grouped.BatteryPlantModel.Module3.outputCellSOC.series.values;
packSim_M4_SOC=simlog_Battery_Module_To_FullPack_Grouped.BatteryPlantModel.Module4.outputCellSOC.series.values;
packSim_M5_SOC=simlog_Battery_Module_To_FullPack_Grouped.BatteryPlantModel.Module5.outputCellSOC.series.values;
packSim_M6_SOC=simlog_Battery_Module_To_FullPack_Grouped.BatteryPlantModel.Module6.outputCellSOC.series.values;
%
packSim_M1_T=simlog_Battery_Module_To_FullPack_Grouped.BatteryPlantModel.Module1.outputCellTemp.series.values;
packSim_M2_T=simlog_Battery_Module_To_FullPack_Grouped.BatteryPlantModel.Module2.outputCellTemp.series.values;
packSim_M3_T=simlog_Battery_Module_To_FullPack_Grouped.BatteryPlantModel.Module3.outputCellTemp.series.values;
packSim_M4_T=simlog_Battery_Module_To_FullPack_Grouped.BatteryPlantModel.Module4.outputCellTemp.series.values;
packSim_M5_T=simlog_Battery_Module_To_FullPack_Grouped.BatteryPlantModel.Module5.outputCellTemp.series.values;
packSim_M6_T=simlog_Battery_Module_To_FullPack_Grouped.BatteryPlantModel.Module6.outputCellTemp.series.values;
%
packSim_max_SOC=max(max(max(max(packSim_M1_SOC,[],2),max(packSim_M2_SOC,[],2)), max(max(packSim_M3_SOC,[],2),max(packSim_M4_SOC,[],2))), max(max(packSim_M5_SOC,[],2),max(packSim_M6_SOC,[],2)));
packSim_min_SOC=min(min(min(min(packSim_M1_SOC,[],2),min(packSim_M2_SOC,[],2)), min(min(packSim_M3_SOC,[],2),min(packSim_M4_SOC,[],2))), min(min(packSim_M5_SOC,[],2),min(packSim_M6_SOC,[],2)));
packSim_max_T=max(max(max(max(packSim_M1_T,[],2),max(packSim_M2_T,[],2)), max(max(packSim_M3_T,[],2),max(packSim_M4_T,[],2))), max(max(packSim_M5_T,[],2),max(packSim_M6_T,[],2)));
packSim_min_T=min(min(min(min(packSim_M1_T,[],2),min(packSim_M2_T,[],2)), min(min(packSim_M3_T,[],2),min(packSim_M4_T,[],2))), min(min(packSim_M5_T,[],2),min(packSim_M6_T,[],2)));
%
figure(2)
simlog_handles(1) = subplot(3, 1, 1);
plot(packSim_t,packSim_max_SOC,'r-')
hold on
plot(packSim_t,packSim_min_SOC,'m-')
hold off
legend('Pack cell max SOC','Pack cell min SOC')
xlabel('Time (s)')
ylabel('SOC [-]')
%
title('Battery Pack Simulation Results')
%
simlog_handles(2) = subplot(3, 1, 2);
plot(packSim_t,packSim_max_T,'r-')
hold on
plot(packSim_t,packSim_min_T,'m-')
hold off
legend('Pack cell max T','Pack cell min T')
xlabel('Time (s)')
ylabel('Temperature [K]')
%
simlog_handles(3) = subplot(3, 1, 3);
plot(packSim_t,packSim_I,'r-')
xlabel('time (s)')
ylabel('Pack Current [A]')
%
disp('End simulations')

