function [ errorNumber ] = MoindreCarreMalClasse( M )
%NEGATIVEINMATRIX Summary of this function goes here
%   Detailed explanation goes here

    errorNumber=0;

    for i=1:size(M,2)
        if M(i)<0
            errorNumber=errorNumber+1;
        end
    end
end

