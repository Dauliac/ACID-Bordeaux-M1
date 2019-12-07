clear all;
close all;
clc

load('donnees3.mat')


%visualisation des echantillons 
figure(1)
axis equal
scatter(C1(:, 1), C1(:, 2));
hold on
scatter(C2(:, 1), C2(:, 2) ,'g');
hold off

sizeVTC1 = size(C1, 1)
sizeVTC2= size(C2, 1)
%probas a priori
pC2=sizeVTC2/(sizeVTC2+sizeVTC1);
pC1=sizeVTC1/(sizeVTC2+sizeVTC1);

nbIter   = 100;
sizeTrain = 100;
errorC1L = zeros(nbIter,1);
errorC2L = zeros(nbIter, 1);
errorL = zeros(nbIter, 1);

errorC2MAP = zeros(nbIter,1);
errorC1MAP = zeros(nbIter, 1);
errorMAP = zeros(nbIter, 1);

for i=1:nbIter
        
        [TrainC1,TestC1] = extractTestAndTrain(C1, sizeTrain);
        [TrainC2,TestC2] = extractTestAndTrain(C2, sizeTrain);
        [modelC1] = trainModel(TrainC1);
        [modelC2] = trainModel(TrainC2);
        %linéaire
        W = [6; 1; -3];
        [W] = Perceptron(TrainC1', TrainC2',W);
        %MAP
        MapResC2    = myClassify(TestC2,modelC2, modelC1, pC2, pC1, "B", "S");
        MapResC1 =    myClassify(TestC1,modelC2, modelC1, pC2, pC1, "B", "S");
        MapC1Error = computeError(MapResC1, "S");
        MapC2Error = computeError(MapResC2, "B");
        errorC1MAP(i) = MapC1Error*100;
        errorC2MAP(i) = MapC2Error*100;
        errorMAP(i) = (length(TestC1) * errorC1MAP(i) + length(TestC2) *  errorC2MAP(i) )/ (length(TestC1) + length(TestC2));
   
        LResC1 = myClassify2(TestC1',W, "1", "2");
        LResC2 = myClassify2(TestC2',W, "1", "2");
        LC1Error = computeError(LResC1, "1");
        LC2Error = computeError(LResC2, "2");
        errorC1L(i) = LC1Error*100;
        errorC2L(i) = LC2Error*100;
        errorL(i) = (length(TestC1) * errorC1L(i) + length(TestC2) *  errorC2L(i) )/ (length(TestC1) + length(TestC2));
          
end;

MeanErrorC2L = mean(errorC2L)
MeanErrorC1L = mean(errorC1L)
MeanErrorL = mean(errorL)

figure(2);

plot(1:nbIter, errorC1L, 'g')
hold on
plot(1:nbIter, errorC2L)
plot(1:nbIter, errorL, 'k')
plot(1:nbIter, MeanErrorL*ones(size(errorL)), 'k-')
hold off
legend('Error for C1 class', 'Error for C2 class', 'Mean Error')
title('Errors')
xlabel('Iteration')
ylabel('Error in %')
ylim([0 30])

