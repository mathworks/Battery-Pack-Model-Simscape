%% Design Iterations for finding optimum number of channels for cooling
% 

% Copyright 2020-2021 The MathWorks, Inc.

iterSize=max(size(nChannel_options));
battery_result=zeros(iterSize,4);  
disp('Start module design iterations')
for i=1:iterSize
    BEV_Battery_Plant_Model_paramModule;
    coolantPlate_area=battery_cellW*battery_Ns*battery_Np*battery_cellT;
    coolantPlate_nChannels=nChannel_options(i);
    coolantPlate_diaDistributor=sqrt(coolantPlate_nChannels)*coolantPlate_diaChannels;
    % Coolant plate thickness = f(distributor pipe thickness)
    coolantPlate_thickness=max(coolantPlate_diaChannels,(pi*0.25*coolantPlate_diaDistributor^2)/min(coolantPlate_distributorWidMax,coolantPlate_diaDistributor));
    coolantPlate_mass=(coolantPlate_area*coolantPlate_thickness)*coolantPlate_density-(coolantPlate_nChannels*0.25*battery_cellW*pi*coolantPlate_diaChannels^2)*(coolantPlate_density-1000);
    fprintf('*** Simulating for a cooling plate with %i channels \n',coolantPlate_nChannels)
    sim('Battery_Module_Design');
    battery_cellT=simlog_Battery_Module_Design.BatteryModule.outputCellTemp.series.values;
    battery_cellTavg=sum(battery_cellT,2)/size(battery_cellT,2);
    battery_deltaTmean=abs(max(battery_cellTavg)-ambientTemp);
    battery_deltaT=max(max(battery_cellT,[],2)-min(battery_cellT,[],2));
    battery_deltaP=max(simlog_Battery_Module_Design.CoolantPlate.presSensor.series.values);
    battery_result(i,1)=battery_deltaT; 
    battery_result(i,2)=battery_deltaTmean; 
    battery_result(i,3)=battery_deltaP;     
    battery_result(i,4)=coolantPlate_mass; 
end
battery_plot=zeros(iterSize,max(size(weightFraction))+1);
for i=1:max(size(weightFraction))
    battery_plot(1:end,i)=battery_result(1:end,i)/max(battery_result(1:end,i));
end
battery_plot5_tmp=zeros(iterSize,1);
for i=1:max(size(weightFraction))
    battery_plot5_tmp(1:end,1)=battery_plot5_tmp(1:end,1)+battery_plot(1:end,i)*weightFraction(1,i);
end
battery_plot(1:end,max(size(weightFraction))+1)=battery_plot5_tmp(1:end,1)/max(battery_plot5_tmp(1:end,1));
%
indx=find(min(battery_plot(1:end,5))==battery_plot(1:end,5));
numChannelsOpt=nChannel_options(1,indx);
fprintf('Module design iterations Completed \n *** Optimum number of channels = %i \n',numChannelsOpt)

