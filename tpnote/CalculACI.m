function [ W ] = CalculACI( C1, C2 )
%CALCULACI Summary of this function goes here
%   Detailed explanation goes here
    SigmaW = cov(C1)+cov(C2);
    Mu1 = mean(C1);
    Mu2 = mean(C2);
    W = inv(SigmaW)*((Mu1 - Mu2)');
end
