clear all
load ('donnees.mat')

close all
figure(1)
hold on

axis equal

scatter3(C1(:, 1), C1(:,2),C1(:, 3))
scatter3(C2(:, 1), C2(:,2),C2(:, 3), 'r')

sizeC1 = size(C1, 1);
sizeC2 = size(C2, 1);

% Display gaussian
GaussianClass(C1);
GaussianClass(C2);
GaussianCompareClass(C1,C2);
% Laisser sinon GaussianCompareClass ne s'affiche pas correctement
GaussianClass(C1);

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
MDataSize = zeros(nbIter, 1);

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
        
        % Compute error
        errNumMAPC1 = computeError(ResC1, '1');
        errNumMAPC2 = computeError(ResC2, '2');
        errNumMAP = errNumMAPC1 + errNumMAPC2;
        
        % In percent
        errorC1MAP(i) = errNumMAPC1*100/TestSize;
        errorC2MAP(i) = errNumMAPC2*100/TestSize;
        errorMAP(i) = errNumMAP * 100 / TestSize;
        
    % CLASSIFIER LINEAIRES ===============================================
    [MC1, MC2]=createLinearClassMatrices(TestC1,TestC2);
    M=[MC1 -MC2];


    % MOINDRE CARREES
        Z=transpose(M);

        b=ones(size(Z,1),1);
        b=ones(size(Z,1),1);
        w=Z\b;

        res=transpose(w)*M;    
        resC1=transpose(w)*MC1;
        resC2=transpose(w)*(MC2*-1);

        % Compute error
        errNumMCC1 = MoindreCarreMalClasse(resC1);
        errNumMCC2 = MoindreCarreMalClasse(resC2);
        errNumMC = errNumMCC1 + errNumMCC2;
        % In percent
        errorMCC1(i) = errNumMCC1*100/TestSize;
        errorMCC2(i) = errNumMCC2*100/TestSize;
        errorMC(i) = errNumMC * 100 / TestSize;

        y=(-w(1)-w(2)*x)/w(3);
        plot(x,y)
        
    % PERCEPTRON
    % On utilise le perceptron seulement si les donnes sont
    % linéairement separables.
    % Pour ce faire utiliser la fonction Gaussian
        %W = Perceptron(M)
    
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
legend('Error percentage C1', 'Error percentage C2', 'Error percentage total');

hold off
ylim([0 10])

MeanerrorMC = mean(errorMC);

figure('Name', 'Error MC in %');
hold on
PlotMCC1 = plot(1:nbIter, errorMCC1, 'g');
PlotMCC2 = plot(1:nbIter, errorMCC2, 'b');
PlotMCC = plot(1:nbIter, errorMC, 'r');
legend('Error percentage C1', 'Error percentage C2', 'Error percentage total');
ylim([0 10])
hold off