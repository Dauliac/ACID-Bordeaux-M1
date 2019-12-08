close all;
clear all;
clc;

load('VTSaumonBar2.mat')
sizeVTSaumon = size(VTSaumon, 1)
sizeVTBar= size(VTBar, 1)


%probas a priori
pBar=sizeVTBar/(sizeVTBar+sizeVTSaumon);
pSaumon=sizeVTSaumon/(sizeVTBar+sizeVTSaumon);


figure(1)
histogram(VTSaumon);
hold on
histogram(VTBar);

nbIter   = 100;
sizeTrain = 400;
errorBarML = zeros(nbIter,1);
errorSaumonML = zeros(nbIter, 1);
errorML = zeros(nbIter, 1);

errorBarMLP = zeros(nbIter,1);
errorSaumonMLP = zeros(nbIter, 1);
errorMLP = zeros(nbIter, 1);

errorBarMLPACI = zeros(nbIter,1);
errorSaumonMLPACI = zeros(nbIter, 1);
errorMLPACI = zeros(nbIter, 1);

for i=1:nbIter
    
        [TrainSaumon,TestSaumon] = extractTestAndTrain(VTSaumon, sizeTrain);
        [TrainBar, TestBar] = extractTestAndTrain(VTBar, sizeTrain);
        
        
        [modelSaumon] = trainModel(TrainSaumon);
        [modelBar] = trainModel(TrainBar);
       
        % ML (maximum de vraissemblance)
        ResBar    =    myClassify(TestBar,modelBar, modelSaumon, 0.5, 0.5, 'B', 'S');
        ResSaumon =    myClassify(TestSaumon,modelBar, modelSaumon, 0.5, 0.5, 'B', 'S');
        SaumonError = computeError(ResSaumon, 'S');
        BarError = computeError(ResBar, 'B');
        
        errorSaumonML(i) = SaumonError*100;
        errorBarML(i) = BarError*100;
        errorML(i) = (length(TestSaumon) * errorSaumonML(i) + length(TestBar) *  errorBarML(i) )/ (length(TestSaumon) + length(TestBar));
        
        %PROJECTION
   
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
        
        errorSaumonMLP(i) = SaumonErrorP*100;
        errorBarMLP(i) = BarErrorP*100;
        errorMLP(i) = (length(projTestSaumon) * errorSaumonMLP(i) + length(projTestBar) *  errorBarMLP(i) )/ (length(projTestSaumon) + length(projTestBar));
        
        % ACI
        
        sw=calculACI(TrainBar,TrainSaumon);
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
        
        errorSaumonMLPACI(i) = SaumonErrorPACI*100;
        errorBarMLPACI(i) = BarErrorPACI*100;
        errorMLPACI(i) = (length(projACITestSaumon) * errorSaumonMLP(i) + length(projACITestBar) *  errorBarMLP(i) )/ (length(projACITestSaumon) + length(projACITestBar));
        
end;

MeanErrorBarML    = mean(errorBarML)
MeanErrorSaumonML = mean(errorSaumonML)
MeanErrorML = mean(errorML)

MeanErrorBarMLP    = mean(errorBarMLP)
MeanErrorSaumonMLP = mean(errorSaumonMLP)
MeanErrorMLP = mean(errorMLP)

MeanErrorBarMLPACI    = mean(errorBarMLPACI)
MeanErrorSaumonMLPACI = mean(errorSaumonMLPACI)
MeanErrorMLPACI = mean(errorMLPACI)

figure('Name', 'ML');
plot(1:nbIter, errorBarML, 'g')
hold on
plot(1:nbIter, errorSaumonML)
plot(1:nbIter, errorML, 'k')
hold off
ylim([0 20])

figure('Name', 'ML_P_ACP');
plot(1:nbIter, errorBarMLP, 'g')
hold on
plot(1:nbIter, errorSaumonMLP)
plot(1:nbIter, errorMLP, 'k')
hold off
ylim([0 20])

figure('Name', 'ML_P_ACI');
plot(1:nbIter, errorBarMLPACI, 'g')
hold on
plot(1:nbIter, errorSaumonMLPACI)
plot(1:nbIter, errorMLPACI, 'k')
hold off
ylim([0 20])


