# Battery Electric Vehicle (BEV) Battery Pack Design in Simscape
Copyright 2020-2021 The MathWorks, Inc.

This repository shows use of Simscape to model an electric vehicle
battery pack. There are three examples:
1. Battery Pack Thermal Management
   * Shows how to model an automotive battery pack for thermal management tasks. 
2. Full Vehicle Thermal Management
   * Shows a BEV full vehicle thermal management with a detailed battery model.
3. Workflow from Module Design to Full Pack
   * Demonstrates a workflow to go from a detailed battery module design 
     to a real-time pack plant model

Open batteryExamplesProjectSetup.prj to get started up the project path. The 
project shortcut buttons in the toolstrip open these three examples.

All examples have a battery-module custom component that is based on 
Simscape Electrical [Battery (Table-Based)](https://www.mathworks.com/help/physmod/sps/ref/batterytablebased.html)
block for modeling battery behavior. Please visit the [Simscape Electrical](https://www.mathworks.com/products/simscape-electrical.html) 
page to learn more about modeling electrical systems.

[![View Battery Pack Model in Simscape on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/82330-battery-pack-model-in-simscape)


## **Battery Pack Thermal Management**
You will learn how to model an automotive battery pack for
thermal management tasks. The battery pack consists of several
battery modules, which are combinations of cells in series and
parallel. The Battery Controls subsystem defines the logic to 
determine the required level of cooling for the applied current 
load. 

![](Overview/html/Battery_Pack_Thermal_Management_01.png)


## **Full Vehicle Thermal Management**
You will learn how to model the complete thermal management system for 
a battery electric vehicle. The system consists of two coolant loops, a 
refrigeration loop, and a cabin HVAC loop. The thermal load are the 
batteries, the powertrain, and the cabin.

![](Overview/html/EV_Thermal_Management_01.png)


## **Workflow from Module Design to Full Pack**
You will learn how to design a battery module, build a HV pack using 
the module, and run battery plant simulations.

### **BEV Battery Module Detailed Design**
![](Scripts_Data/BEV_Battery_Plant_Model_01.png)

### **BEV Full-Battery Pack Plant Model**
![](Scripts_Data/BEV_Battery_Plant_Model_05.png)

