
function [V] = CalculACP (Echantillon)
        Echantillon = [2 4; 6 12; 13 13];

        M = cov(Echantillon);
        [VP, Lambda] = eig (M);
        % trier les valeurs propres de la plus grande a la plus petite
        [SortedLambda, indices] = sort(diag(Lambda), 'descend');
        % renvoyer les vecteurs propres dans le même ordre
        V = VP(:, indices);
end



% on appelle d la dimension réduite 
% pour obtenir la matrice de projection il faut sélectionner 
% les d 1ers vecteurs du résultat de cette fonction avec :
% W = V(:, 1:d);