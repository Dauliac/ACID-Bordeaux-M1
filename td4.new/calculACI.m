function [ res ] = calculACI( train1,train2 )
%CALCULACI Summary of this function goes here
%   Detailed explanation goes here

    C1=cov(train1);
    C2=cov(train2);
    res=((C1+C2).^-1)*transpose(mean(train1)-mean(train2));


end

