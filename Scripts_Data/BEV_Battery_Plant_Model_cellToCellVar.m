% Define cell-to-cell variations and assign properties (best/worst) based
% on best/worst cooled cells to maximize impact of the variations
% 

% Copyright 2020-2024 The MathWorks, Inc.

disp('Setup cell-to-cell variations')
%
% Find best and worst cells based on cooling data
sum_mat_cellQ=sum(sum(mat_cellQ));
worstCooledCell_indx=min(find(min(sum_mat_cellQ)==sum_mat_cellQ));
bestCooledCell_indx=max(find(max(sum_mat_cellQ)==sum_mat_cellQ));
%
% Cell Ahr variations
battery_varAhr_M1(1,worstCooledCell_indx)=batteryCell_Ahr_fracMin;
battery_varAhr_M1(1,bestCooledCell_indx)=batteryCell_Ahr_fracMax;
battery_varAhr_M2(1,worstCooledCell_indx)=batteryCell_Ahr_fracMax;
battery_varAhr_M2(1,bestCooledCell_indx)=batteryCell_Ahr_fracMin;
battery_varAhr_M3(1,worstCooledCell_indx)=batteryCell_Ahr_fracMin;
battery_varAhr_M3(1,bestCooledCell_indx)=batteryCell_Ahr_fracMax;
battery_varAhr_M4(1,worstCooledCell_indx)=batteryCell_Ahr_fracMax;
battery_varAhr_M4(1,bestCooledCell_indx)=batteryCell_Ahr_fracMin;
battery_varAhr_M5(1,worstCooledCell_indx)=batteryCell_Ahr_fracMin;
battery_varAhr_M5(1,bestCooledCell_indx)=batteryCell_Ahr_fracMax;
battery_varAhr_M6(1,worstCooledCell_indx)=batteryCell_Ahr_fracMax;
battery_varAhr_M6(1,bestCooledCell_indx)=batteryCell_Ahr_fracMin;
%
for i=1:battery_Np*battery_Ns
    if(i~=worstCooledCell_indx && i~=bestCooledCell_indx)
        battery_varAhr_M1(1,i)=batteryCell_Ahr_fracMin+...
                                  i*(batteryCell_Ahr_fracMax-...
                                  batteryCell_Ahr_fracMin)...
                                  /(battery_Np*battery_Ns);
        battery_varAhr_M2(1,i)=batteryCell_Ahr_fracMin+...
                                  i*(batteryCell_Ahr_fracMax-...
                                  batteryCell_Ahr_fracMin)...
                                  /(battery_Np*battery_Ns);  
        battery_varAhr_M3(1,i)=batteryCell_Ahr_fracMin+...
                                  i*(batteryCell_Ahr_fracMax-...
                                  batteryCell_Ahr_fracMin)...
                                  /(battery_Np*battery_Ns);
        battery_varAhr_M4(1,i)=batteryCell_Ahr_fracMin+...
                                  i*(batteryCell_Ahr_fracMax-...
                                  batteryCell_Ahr_fracMin)...
                                  /(battery_Np*battery_Ns); 
        battery_varAhr_M5(1,i)=batteryCell_Ahr_fracMin+...
                                  i*(batteryCell_Ahr_fracMax-...
                                  batteryCell_Ahr_fracMin)...
                                  /(battery_Np*battery_Ns);
        battery_varAhr_M6(1,i)=batteryCell_Ahr_fracMin+...
                                  i*(batteryCell_Ahr_fracMax-...
                                  batteryCell_Ahr_fracMin)...
                                  /(battery_Np*battery_Ns); 
    end
end
% Cell R0 variations
battery_varR0_M1(1,worstCooledCell_indx)=batteryCell_R0_fracMin;
battery_varR0_M1(1,bestCooledCell_indx)=batteryCell_R0_fracMax;
battery_varR0_M2(1,worstCooledCell_indx)=batteryCell_R0_fracMax;
battery_varR0_M2(1,bestCooledCell_indx)=batteryCell_R0_fracMin;
battery_varR0_M3(1,worstCooledCell_indx)=batteryCell_R0_fracMin;
battery_varR0_M3(1,bestCooledCell_indx)=batteryCell_R0_fracMax;
battery_varR0_M4(1,worstCooledCell_indx)=batteryCell_R0_fracMax;
battery_varR0_M4(1,bestCooledCell_indx)=batteryCell_R0_fracMin;
battery_varR0_M5(1,worstCooledCell_indx)=batteryCell_R0_fracMin;
battery_varR0_M5(1,bestCooledCell_indx)=batteryCell_R0_fracMax;
battery_varR0_M6(1,worstCooledCell_indx)=batteryCell_R0_fracMax;
battery_varR0_M6(1,bestCooledCell_indx)=batteryCell_R0_fracMin;
%
for i=1:battery_Np*battery_Ns
    if(i~=worstCooledCell_indx && i~=bestCooledCell_indx)
        battery_varR0_M1(1,i)=batteryCell_R0_fracMin+...
                                 i*(batteryCell_R0_fracMax-...
                                 batteryCell_R0_fracMin)...
                                 /(battery_Np*battery_Ns);
        battery_varR0_M2(1,i)=batteryCell_R0_fracMin+...
                                 i*(batteryCell_R0_fracMax-...
                                 batteryCell_R0_fracMin)...
                                 /(battery_Np*battery_Ns);
        battery_varR0_M3(1,i)=batteryCell_R0_fracMin+...
                                 i*(batteryCell_R0_fracMax-...
                                 batteryCell_R0_fracMin)...
                                 /(battery_Np*battery_Ns);
        battery_varR0_M4(1,i)=batteryCell_R0_fracMin+...
                                 i*(batteryCell_R0_fracMax-...
                                 batteryCell_R0_fracMin)...
                                 /(battery_Np*battery_Ns); 
        battery_varR0_M5(1,i)=batteryCell_R0_fracMin+...
                                 i*(batteryCell_R0_fracMax-...
                                 batteryCell_R0_fracMin)...
                                 /(battery_Np*battery_Ns);
        battery_varR0_M6(1,i)=batteryCell_R0_fracMin+...
                                 i*(batteryCell_R0_fracMax-...
                                 batteryCell_R0_fracMin)...
                                 /(battery_Np*battery_Ns);
    end
end
%
disp('Completed setup for cell-to-cell variations')

