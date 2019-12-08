function [ m ] = createMatrix( c1,c2 )
%CREATEMATRIX Summary of this function goes here
%   Detailed explanation goes here
    
tc1=transpose(c1);
tc2=transpose(c2);
fc1=[ones(1,size(tc1,2));tc1];
fc2=[ones(1,size(tc2,2));tc2];

m=[fc1 fc2*-1];

end

