function [V] = CalculACP(VT)

    %%% Deux m?thodes vues : %%%
    
    % 1ere m?thode :
%     VT = VT - mean(VT); %VT = (VT - mean(VT)./sqrt(var(VT));
%     %ACP%
%     n = size(VT,1);
%     scattern = (n-1)*cov(VT);
%     [VectProp, ValProp] = eigs(scattern);
%  
%     [sortedVectProp, indices] = sort(diag(ValProp), 'descend');
%     V = VectProp(:,indices(1:1));
    
    % 2?me m?thode :
    M = cov(VT);
    [VectProp, ValProp] = eigs (M);
    % trier les valeurs propres de la plus grande a la plus petite
    [SortedLambda, indices] = sort(diag(ValProp), 'descend');
    % renvoyer les vecteurs propres dans le m?me ordre
    V = VectProp(:, indices);
end