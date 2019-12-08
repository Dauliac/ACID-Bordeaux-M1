function [ res ] = negativeInMatrix( M )
%NEGATIVEINMATRIX Summary of this function goes here
%   Detailed explanation goes here

    res=0;

    for i=1:size(M,2)
        if M(i)<0
            res=res+1;
        end
    end


end

