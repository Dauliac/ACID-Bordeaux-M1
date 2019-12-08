function [y] = droite2DVd(W, x)
% calcul des points d'une droite etant donnes son vecteur directeur
% vd et un point de la droite p
    
%y = (vd(2)/vd(1)) * (x- p(1)) + p(2);
y = -(W(2) * x / W(3)) - (W(1) / W(3));

end


