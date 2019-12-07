close all;
clear all;

load('VTSaumonBar.mat');

%histogram(VTBar);

sizeVTSaumon = size(VTSaumon,1)
sizeVTBar = size(VTBar,1)

nbIter = 100;
sizeTrain = 400;
for i=1:nbIter
%% extraction de l’ensemble d’entrainement
TrainSaumonIndices = randperm(sizeVTSaumon, sizeTrain);
TrainBarIndices = randperm(sizeVTBar,sizeTrain);
TrainSaumon = VTSaumon(TrainSaumonIndices);
TrainBar = VTBar(TrainBarIndices);
%% entrainement
muSaumonTrain = mean(TrainSaumon);
sigmaSaumonTrain = var(TrainSaumon);
muBarTrain = mean(TrainBar);
sigmaBarTrain = var(TrainBar);
%% test - la fonction myClassify renvoie un vecteur de labels ("B" pour bar, "S" pour saumon)
TestBar = VTBar;
TestSaumon = VTSaumon;
ResBar = myClassify(TestBar, muBarTrain, sigmaBarTrain,muSaumonTrain, sigmaSaumonTrain);
ResSaumon = myClassify(TestSaumon, muBarTrain, sigmaBarTrain, muSaumonTrain, sigmaSaumonTrain);
%% récupération des erreurs
nbErrorBar = computeError (ResBar, "B");
nbErrorSaumon = computeError (ResSaumon, "S");
end