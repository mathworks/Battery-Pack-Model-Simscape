%% Data generation for thermal Lookup Table based approach
% 

% Copyright 2020-2021 The MathWorks, Inc.

BEV_Battery_Plant_Model_paramModule;
coolantPlate_area=battery_cellW*battery_Ns*battery_Np*battery_cellT;
coolantPlate_nChannels=numChannelsOpt;
coolantPlate_diaDistributor=sqrt(coolantPlate_nChannels)*coolantPlate_diaChannels;
coolantPlate_thickness=max(coolantPlate_diaChannels,(pi*0.25*coolantPlate_diaDistributor^2)/min(coolantPlate_distributorWidMax,coolantPlate_diaDistributor));
coolantPlate_mass=(coolantPlate_area*coolantPlate_thickness)*coolantPlate_density-(coolantPlate_nChannels*0.25*battery_cellW*pi*coolantPlate_diaChannels^2)*(coolantPlate_density-1000);
%
numOf_Temp=max(size(vec_dataLUTpts_T)); % number of points for coolant inlet T
numOf_Flow=max(size(vec_dataLUTpts_F)); % number of points for coolant flowrate
%
numOf_Cells=battery_Ns*battery_Np; % Total number of battery cells
mat_cellHeat=zeros(numOf_Temp,numOf_Flow,numOf_Cells);
vec_flowrate=zeros(1,numOf_Flow);
vec_temperature=zeros(1,numOf_Temp);
%
count=0;
disp('Start data generation for Thermal LUT model')
for j=1:numOf_Temp
    coolantPlate_iniT=vec_dataLUTpts_T(1,j);
    vec_temperature(1,j)=coolantPlate_iniT;
    for k=1:numOf_Flow
        count=count+1;
        coolantMassFlowRate=vec_dataLUTpts_F(1,k);
        vec_flowrate(1,k)=coolantMassFlowRate;
        fprintf('*** Simulating for flowrate = %.2f kg/s and Temperature = %.1f K \n',coolantMassFlowRate,coolantPlate_iniT)
        sim('Battery_Module_Design');
        %
        load('Battery_Module_Design_Data.mat');
        module_t=cellEffCooling.Time;
        module_data=cellEffCooling.Data;
        module_delta_t=diff(module_t);
        for i=1:size(module_data,2)
            mat_cellHeat(j,k,i)=abs(module_delta_t'*module_data(2:end,i)/(module_t(end,1)-module_t(1,1)));
        end
    end
end
% Save results to a mat file:
module_LUTthermalData={vec_temperature,vec_flowrate,mat_cellHeat};
save('BEV_Battery_Plant_Model_LUTthermalData.mat','module_LUTthermalData');
disp('Completed data generation for Thermal LUT model')

