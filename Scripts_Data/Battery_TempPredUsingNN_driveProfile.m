function [plotData01,plotData02,plotData03,p3,Pi3,Ai3,t3] = Battery_TempPredUsingNN_driveProfile(simulationParam,driveProfile_X,alpha)
    neuralNetTS=simulationParam(1,1);
    cellCapacity=simulationParam(1,2);
    nDelay=simulationParam(1,3);
    ambient=simulationParam(1,4);
    numParallelCells=simulationParam(1,5);
    % Read trained model from 'alpha'
    normalizationVar=alpha.trainedNet{3,1};
    useNetwork=alpha.trainedNet{1,1};
    mu_tmp=normalizationVar(1,1);
    sig_tmp=normalizationVar(1,2);
    mu_pow=normalizationVar(1,3);
    sig_pow=normalizationVar(1,4);
    tempRef=normalizationVar(1,5);
    %
    lenSeries=max(size(driveProfile_X.validate_X.Data));
    % Create output array for storing temperature predictions and initialize
    % the first 3 timestep values
    predict_temp=ones(1,lenSeries);
    predict_temp(1,1:nDelay)=ambient;
    % Create an array to store state of charge values from coulomb counting
    predict_soc=ones(1,lenSeries);
    % Input data based on current and voltage sensing
    verifySeries_pow=((driveProfile_X.validate_X.Data(1:lenSeries,1).*...
               driveProfile_X.validate_X.Data(1:lenSeries,4)-mu_pow)./sig_pow)';
    % Coulomb counting
    verifySeries_soc=(driveProfile_X.validate_X.Data(1:lenSeries,1)'.*...
               neuralNetTS)/(3600*numParallelCells);
    cumulativeAhr=zeros(1,lenSeries);
    cumulativeAhr(1,1)=verifySeries_soc(1,1);
    for itr=2:lenSeries
        cumulativeAhr(1,itr)=sum(verifySeries_soc(1,1:itr-1));
    end
    verifySeries_soc=1+cumulativeAhr/cellCapacity;
    % Normalize data
    verifySeries_tmp=predict_temp-tempRef;
    verifySeries_tmp=(verifySeries_tmp-mu_tmp)/mu_tmp;
    verifySeries_pow=(verifySeries_pow-mu_pow)/sig_pow;
    verify_NARX_Y=verifySeries_tmp;
    verify_NARX_X2=[verifySeries_pow;verifySeries_soc];
    % Store data in cell arrays
    verifyNARX_X=con2seq(verify_NARX_X2);
    verifyNARX_Y=con2seq(verify_NARX_Y);
    [p3,Pi3,Ai3,t3]=preparets(useNetwork,verifyNARX_X,{},verifyNARX_Y);
    yp3=useNetwork(p3,Pi3,Ai3);
    % 
    % Plot
    figure(1);
    TS=size(t3,2);
    plotData01=[1:lenSeries;driveProfile_X.validate_X.Data(1:lenSeries,2)'];
    plotData02=[1:TS;cell2mat(yp3).*sig_tmp+mu_tmp+tempRef];
    plotData03=[1:lenSeries;driveProfile_X.validate_X.Data(1:lenSeries,1)'];
end