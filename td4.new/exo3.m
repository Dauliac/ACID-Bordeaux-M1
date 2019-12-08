close all;
clear all;
clc;

load('VTSaumonBar3.mat')
sizeVTSaumon = size(VTSaumon, 1)
sizeVTBar= size(VTBar, 1)


nbIter   = 100;
sizeTrain = 400;

errorBarACP_3_1 = zeros(nbIter,1);
errorSaumonACP_3_1 = zeros(nbIter, 1);
errorACP_3_1 = zeros(nbIter, 1);

errorBarACP_3_2 = zeros(nbIter,1);
errorSaumonACP_3_2 = zeros(nbIter, 1);
errorACP_3_2 = zeros(nbIter, 1);

errorBarACI_3_1 = zeros(nbIter,1);
errorSaumonACI_3_1 = zeros(nbIter, 1);
errorACI_3_1 = zeros(nbIter, 1);

for i=1:nbIter
    
        [TrainSaumon,TestSaumon] = extractTestAndTrain(VTSaumon, sizeTrain);
        [TrainBar, TestBar] = extractTestAndTrain(VTBar, sizeTrain);
        
        % ACP 3->1
   
        Train=[TrainBar;TrainSaumon];
        
        w=CalculACP(Train);
        w = w(:,1);
        projTrainBar=projection(w,TrainBar);
        projTrainSaumon=projection(w,TrainSaumon);
        projTestBar=projection(w,TestBar);
        projTestSaumon=projection(w,TestSaumon);
        
        [modelSaumonP] = trainModel(projTrainSaumon);
        [modelBarP] = trainModel(projTrainBar);
       
        % ML (maximum de vraissemblance)
        ResBarP    =    myClassify(projTestBar,modelBarP, modelSaumonP, 0.5, 0.5, 'B', 'S');
        ResSaumonP =    myClassify(projTestSaumon,modelBarP, modelSaumonP, 0.5, 0.5, 'B', 'S');
        SaumonErrorP = computeError(ResSaumonP, 'S');
        BarErrorP = computeError(ResBarP, 'B');
        
        errorSaumonACP_3_1(i) = SaumonErrorP*100;
        errorBarACP_3_1(i) = BarErrorP*100;
        errorACP_3_1(i) = (length(projTestSaumon) * errorSaumonACP_3_1(i) + length(projTestBar) *  errorBarACP_3_1(i) )/ (length(projTestSaumon) + length(projTestBar));
        
        
        
        
        
        % ACP 3->2
        
        w32=CalculACP(Train);
        w32 = w32(:,1:2);
        projTrainBar32=projection(w32,TrainBar);
        projTrainSaumon32=projection(w32,TrainSaumon);
        projTestBar32=projection(w32,TestBar);
        projTestSaumon32=projection(w32,TestSaumon);
        
        [modelSaumonP32] = trainModel(projTrainSaumon32);
        [modelBarP32] = trainModel(projTrainBar32);
       
        % ML (maximum de vraissemblance)
        ResBarP32    =    myClassify(projTestBar32,modelBarP32, modelSaumonP32, 0.5, 0.5, 'B', 'S');
        ResSaumonP32 =    myClassify(projTestSaumon32,modelBarP32, modelSaumonP32, 0.5, 0.5, 'B', 'S');
        SaumonErrorP32 = computeError(ResSaumonP32, 'S');
        BarErrorP32 = computeError(ResBarP32, 'B');
        
        errorSaumonACP_3_2(i) = SaumonErrorP32*100;
        errorBarACP_3_2(i) = BarErrorP32*100;
        errorACP_3_2(i) = (length(projTestSaumon32) * errorSaumonACP_3_2(i) + length(projTestBar32) *  errorBarACP_3_2(i) )/ (length(projTestSaumon32) + length(projTestBar32));
        
        
        
        
        % ACI 3->1
        
        sw=calculACI(TrainBar,TrainSaumon)
        sw = sw(:,1);
        projACITrainBar=projection(sw,TrainBar);
        projACITrainSaumon=projection(sw,TrainSaumon);
        projACITestBar=projection(sw,TestBar);
        projACITestSaumon=projection(sw,TestSaumon);
        
        [modelSaumonP] = trainModel(projACITrainSaumon);
        [modelBarP] = trainModel(projACITrainBar);
       
        % ML (maximum de vraissemblance)
        ResBarPACI    =    myClassify(projACITestBar,modelBarP, modelSaumonP, 0.5, 0.5, 'B', 'S');
        ResSaumonPACI =    myClassify(projACITestSaumon,modelBarP, modelSaumonP, 0.5, 0.5, 'B', 'S');
        SaumonErrorPACI = computeError(ResSaumonPACI, 'S');
        BarErrorPACI = computeError(ResBarPACI, 'B');
        
        errorSaumonACI_3_1(i) = SaumonErrorPACI*100;
        errorBarACI_3_1(i) = BarErrorPACI*100;
        errorACI_3_1(i) = (length(projACITestSaumon) * errorSaumonACI_3_1(i) + length(projACITestBar) *  errorBarACI_3_1(i) )/ (length(projACITestSaumon) + length(projACITestBar));
        
end;

MeanErrorBarACP_3_1    = mean(errorBarACP_3_1)
MeanErrorSaumonACP_3_1 = mean(errorSaumonACP_3_1)
MeanErrorACP_3_1 = mean(errorACP_3_1)

MeanErrorBarACP_3_2    = mean(errorBarACP_3_2)
MeanErrorSaumonACP_3_2 = mean(errorSaumonACP_3_2)
MeanErrorACP_3_2 = mean(errorACP_3_2)

MeanErrorBarACI_3_1    = mean(errorBarACI_3_1)
MeanErrorSaumonACI_3_1 = mean(errorSaumonACI_3_1)
MeanErrorACI_3_1 = mean(errorACI_3_1)

figure('Name', 'ACP_3_1');
plot(1:nbIter, errorBarACP_3_1, 'g')
hold on
plot(1:nbIter, errorSaumonACP_3_1)
plot(1:nbIter, errorACP_3_1, 'k')
hold off
ylim([0 20])

figure('Name', 'ACP_3_2');
plot(1:nbIter, errorBarACP_3_2, 'g')
hold on
plot(1:nbIter, errorSaumonACP_3_2)
plot(1:nbIter, errorACP_3_2, 'k')
hold off
ylim([0 10])

figure('Name', 'ACI_3_1');
plot(1:nbIter, errorBarACI_3_1, 'g')
hold on
plot(1:nbIter, errorSaumonACI_3_1)
plot(1:nbIter, errorACI_3_1, 'k')
hold off
ylim([0 70])