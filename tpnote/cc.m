clear all
load ('donnees.mat')

close all
figure('Name', 'Dataset');
hold on

axis equal

scatter3(C1(:, 1), C1(:,2),C1(:, 3))
scatter3(C2(:, 1), C2(:,2),C2(:, 3), 'r')
meshgrid(10, 10, 10);


% Display gaussian
% Display this make linear reg not working
% Uncomment to get gaussian curves
% GaussianClass(C1);
% GaussianClass(C2);
% GaussianCompareClass(C1,C2);
% Laisser sinon GaussianCompareClass ne s'affiche pas correctement
GaussianClass(C1);

sizeC1 = size(C1, 1);
sizeC2 = size(C2, 1);

%probas a priori
pC1=sizeC1/(sizeC1+sizeC2);
pC2=sizeC2/(sizeC1+sizeC2);

nbIter = 20;
% Pourcentage a recuperer pour train
percentTrainLimit = 10; %

sizeTrainC1 = sizeC1*(percentTrainLimit/100);
sizeTrainC2 = sizeC2*(percentTrainLimit/100);

% Setup error matrix with 0
% For MAP
errorC1MAP = zeros(nbIter,1);
errorC2MAP = zeros(nbIter, 1);
errorMAP = zeros(nbIter, 1);

% For MC
errorcC1MC = zeros(nbIter,1);
errorC2MC = zeros(nbIter, 1);
errorMC = zeros(nbIter, 1);
errorMCC1 = zeros(nbIter, 1);
errorMCC2 = zeros(nbIter, 1);
MDataSize = zeros(nbIter, 1);

% For Perceptron
% Not working cf line 195
% Wperceptron = zeros(nbIter,3);
x=[-50 80];

% TP NOTE
for i=1:nbIter
    % fprintf('Iteration numero %i\n', i);
    
    %%%% ACP %%%%
    % On a 3 dimensions on en gardera que 2
    d = 2;

    VT = [C1; C2];

    [OrderedVectsProp indices] = CalculACP(VT);
    WACP = OrderedVectsProp(:, 1:d);
    
    % Uncomment to see what features to observe
    % fprintf('ACP keep features %d\n', indices(1:d));


    ProjectedACP = Projection(WACP, VT);
    % ProjectedACP1 = Projection(WACP, C1);
    % ProjectedACP2 = Projection(WACP, C2);
    % Obligatoire
    ACPC1 = Projection(WACP, C1);
    ACPC2 = Projection(WACP, C2);

    % Scatter to display ACP for  dimension 2
    % scatter(C1(:, indices(1)), C1(:,indices(2)))
    % scatter(C2(:, indices(1)), C2(:,indices(2)))

    pointsACP = droite2DVd(WACP, x);
    plot(x, pointsACP, 'r');

    %%%% ACI %%%%
    % Not used
    % [WACI] = CalculACI(C1, C2)
    % 
    % pointsACI = droite2DVd(WACI, x);
    % 
    % ProjectedACI = Projection(WACI, VT);
    % ProjectedACIC1 = Projection(WACI, C1);
    % ProjectedACIC2 = Projection(WACI, C2);
    
    % Sans ACP
    % [TrainC1,TestC1] = extractTestAndTrain(C1, sizeTrainC1);
    % [TrainC2, TestC2] = extractTestAndTrain(C2, sizeTrainC2);
    % OU Avec ACP
    [TrainC1,TestC1] = extractTestAndTrain(ACPC1, sizeTrainC1);
    [TrainC2, TestC2] = extractTestAndTrain(ACPC2, sizeTrainC2);
    
    % Train Datas
    [modelC1] = trainModel(TrainC1);
    [modelC2] = trainModel(TrainC2);
    
    TestC1Size = length(TestC1);
    TestC2Size = length(TestC2);
    TestSize = TestC2Size + TestC2Size;
    
    
    % A priori (utilisation des proba a priori)
    
    % ResC2 = myClassify(TestC2,modelC2, modelC1, pC2, pC1, '2', '1');
    %         ResC1 = myClassify(TestC1,modelC2, modelC1, pC2, pC1, '2', '1');
    %         
    % % Compute error
    % errNumMAPC1 = computeError(ResC1, '1');
    % errNumMAPC2 = computeError(ResC2, '2');
    % errNumMAP = errNumMAPC1 + errNumMAPC2;
    %         
    % % In percent
    % errorC1MAP(i) = errNumMAPC1*100/TestSize;
    % errorC2MAP(i) = errNumMAPC2*100/TestSize;
    % errorMAP(i) = errNumMAP * 100 / TestSize;
    % A posteriori
        ResC1 = myClassifyMAP(TestC1, modelC1, '1', 0.5, modelC2, '2', 0.5);
        ResC2 = myClassifyMAP(TestC2, modelC2, '2', 0.5, modelC1, '1', 0.5);

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
        plot(x,y);
        
    % PERCEPTRON
    % On utilise le perceptron seulement si les donnes sont
    % lineairement separables.
    % Pour ce faire utiliser la fonction Gaussian
        coef=0.0001;

        % Poid de départ pour le percetron
        % N+1 dimension +1 pour l'ordonnées à l'origine
        WPrcpt=[-10;2;2];
        x=[-5 17];
        %x=[0 7]
        perceptronIter=10;

        y=(-w(1)-w(2)*x)/w(3);
        for j=1:perceptronIter
            % fprintf('Peceptron iteration numero %i\n', j);

            Wprev=WPrcpt;
            WPrcpt=Perceptron(Wprev,TestC1,TestC2,coef);
            if(norm(WPrcpt-Wprev)<=0.01)
                break
            end
            % For plot only
            % YPerceptron=(-Wperceptron(1)-Wperceptron(2)*x)/w(3);
        end
        % Not working
        % Wperceptron(i) = WPrcpt();

end;

hold off

MeanerrorC1MAP    = mean(errorC1MAP);
MeanerrorC2MAP = mean(errorC2MAP);
MeanerrorMAP = mean(errorMAP);

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
hold off
ylim([0 10])%
