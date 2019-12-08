function [Ym] = PerceptronMalPlace (Y, W)
%Les exemples sont les colonnes de Y
% W : paramètres de la frontière linéaire = vecteur colonne

found = W'*Y< 0;
Ym = Y (:, found);

end
