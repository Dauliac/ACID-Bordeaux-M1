function [ C1Transformed, C2Transformed ] = createLinearClassMatrices(C1, C2)
% Prepare matrix for linear classification
% Pour l'utiliser:
%   [MC1, MC2]=createLinearClassMatrices(TestC1,TestC2);
%   M=[MC1 -MC2];
    
C1T=transpose(C1);
C2T=transpose(C2);
C1Transformed=[ones(1,size(C1T,2));C1T];
C2Transformed=[ones(1,size(C2T,2));C2T];

end

