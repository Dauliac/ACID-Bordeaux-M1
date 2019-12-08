function [ m ] = matMC( c1,c2 )
%MATMC Summary of this function goes here
%   Detailed explanation goes here

fc1=[ones(size(c1,1),1) c1];
fc2=[ones(size(c2,1),1) c2];

m=[fc1; fc2*-1];

end

