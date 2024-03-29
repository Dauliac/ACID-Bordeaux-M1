Dataset = load ('donnees.mat')
C1 = Dataset.C1;
C2 = Dataset.C2;

spliter = 10; %

[ C1Train, C1Test ] = Split(C1, spliter);
[ C2Train, C2Test ] = Split(C2, spliter);

nbIter = size(C1Train,1);

errorC1ML = zeros(nbIter,1);
errorC2ML = zeros(nbIter, 1);
errorML = zeros(nbIter, 1);
errorC1 = zeros(nbIter,1);
errorC2 = zeros(nbIter, 1);
errorMAP = zeros(nbIter, 1);


% MAP
for i=1:nbIter
    [C1model] = getNormalParameters(C1Train)
    [C2model] = getNormalParameters(C2Train);

    % ML (maximum a posteriori)
    MostProbableC1 = map(C1Test,C1model, C2model, 0.5, 0.5, '1', '2');
    MostProbableC2 = map(C2Test,C1model, C2model, 0.5, 0.5, '1', '2');
    C1Error = computeError(MostProbableC1, '1');
    C2Error = computeError(MostProbableC2, '2');
    errorC1(i) = C1Error*100;
    errorC2(i) = C2Error*100;
    errorMAP(i) = (length(C2Test) * errorC2(i) + length(C1Test) *  errorC1(i) )/ (length(C1Test) + length(C2Test));
    
end

MeanErrorC1   = mean(errorC1)
MeanErrorC2 = mean(errorC2)
MeanError = mean(errorMAP)

% Display
close all

figure('Name', 'MAP');
plot(1:nbIter, errorC1, 'g')
hold on
plot(1:nbIter, errorC2)
plot(1:nbIter, errorMAP, 'k')
hold off

figure(1)   
hold on

axis equal

scatter3(C1(:, 1), C1(:,2),C1(:, 3))
scatter3(C2(:, 1), C2(:,2),C2(:, 3), 'r')
hold off