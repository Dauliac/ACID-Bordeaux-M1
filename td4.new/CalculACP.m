function [ VectPTri ] = CalculACP( Echantillon )
%CALCULACP Summary of this function goes here
%   Detailed explanation goes here
    
    C=cov(Echantillon);
    [V D]=eig(C);
    diagonale=diag(D);
    [ValPtri,ind]=sort(diagonale,'descend');
    VectPTri=V(:,ind);
     

end

