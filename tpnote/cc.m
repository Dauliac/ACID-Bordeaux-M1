clear all
load ('donnees.mat')

close all
figure(1)
hold on

axis equal

scatter3(C1(:, 1), C1(:,2),C1(:, 3))
scatter3(C2(:, 1), C2(:,2),C2(:, 3), 'r')


meanc1=mean(C1)
meanc2=mean(C2)

varc1=var(C1)
varc2=var(C2)

sizeC1 = size(C1, 1)
sizeC2= size(C2, 1)

%probas a priori
pC1=sizeC1/(sizeC1+sizeC2);
pC2=sizeC2/(sizeC1+sizeC2);

nbIter   = 100;
sizeTrainC1 = sizeC1*0.1;
sizeTrainC2 = sizeC2*0.1;

errorC1MAP = zeros(nbIter,1);
errorC2MAP = zeros(nbIter, 1);
errorMAP = zeros(nbIter, 1);

errorcC1MC = zeros(nbIter,1);
errorC2MC = zeros(nbIter, 1);
errorMC = zeros(nbIter, 1);
errorMCC1 = zeros(nbIter, 1);
errorMCC2 = zeros(nbIter, 1);

x=[-50 60]

for i=1:nbIter
    
    [TrainC1,TestC1] = extractTestAndTrain(C1, sizeTrainC1);
    [TrainC2, TestC2] = extractTestAndTrain(C2, sizeTrainC2);
    
    [modelC1] = trainModel(TrainC1);
    [modelC2] = trainModel(TrainC2);
    
    TestC1Size = length(TestC1);
    TestC2Size = length(TestC2);
    TestSize = TestC2Size + TestC2Size;
    
    % MAP (utilisation des proba a priori)
    
        ResC2 = myClassify(TestC2,modelC2, modelC1, pC2, pC1, '2', '1');
        ResC1 = myClassify(TestC1,modelC2, modelC1, pC2, pC1, '2', '1');
        C1Error = computeError(ResC1, '1');
        C2Error = computeError(ResC2, '2');
        errorC1MAP(i) = C1Error*100;
        errorC2MAP(i) = C2Error*100;
        errorMAP(i) = (TestC1Size * errorC1MAP(i) + TestC2Size *  errorC2MAP(i) )/ TestSize;
        

    % MOINDRE CARREES
    MDataSize(i) = TestC1Size+TestC2Size;

    [MC1 MC2]=createMatrix(TestC1,TestC2);
    M=[MC1 MC2*-1];

    Z=transpose(M);
   
    
    b=ones(size(Z,1),1);
    b=ones(size(Z,1),1);
    w=Z\b;
    
    res=transpose(w)*M;    
    resC1=transpose(w)*MC1;
    resC2=transpose(w)*(MC2*-1);

    errorMCC1(i) = malClasse(resC1)*100/TestC1Size;
    errorMCC2(i) = malClasse(resC2)*100/TestC2Size;
    % errorMC(i) = errorMCC1(i) + errorMCC2(i);
    %errorMC(i) = malClasse(res)*100/TestSize;
    errorMC(i) = (TestC1Size * errorMCC1(i) + TestC2Size *  errorMCC2(i) )/ TestSize;


    %/(size(TestC1,1)+size(TestC2,1));
    
    y=(-w(1)-w(2)*x)/w(3);
    plot(x,y)
    
    
end;

hold off

MeanerrorC1MAP    = mean(errorC1MAP)
MeanerrorC2MAP = mean(errorC2MAP)
MeanerrorMAP = mean(errorMAP)

figure('Name', 'Error MAP in %');
hold on
PlotMAPC1 = plot(1:nbIter, errorC1MAP, 'g');
PlotMAPC2 = plot(1:nbIter, errorC2MAP, 'b');
PlotMAP = plot(1:nbIter, errorMAP, 'r');
legend('Error percentage C2', 'Error percentage C2', 'Error percentage total');

hold off
ylim([0 10])

MeanerrorMC = mean(errorMC);

figure('Name', 'Error MC in %');
hold on
PlotMCC1 = plot(1:nbIter, errorMCC1, 'g');
PlotMCC2 = plot(1:nbIter, errorMCC2, 'b');
PlotMCC = plot(1:nbIter, errorMC, 'r');
legend('Error percentage C2', 'Error percentage C2', 'Error percentage total');
ylim([0 10])
hold off