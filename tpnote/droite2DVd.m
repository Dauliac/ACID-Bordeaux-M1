function [y] = droite2DVd(W, x)
% calcul des points d'une droite etant donnes son vecteur directeur
% W est le vecteur directeur
% 

% y = (W(2)/W(1)) * (x- p(1)) + p(2);
% a = W(2)/W(1);
% b = p(2) - a * p(1)
% y = a * x + b;

y = -(W(2) * x / W(3)) - (W(1) / W(3));

end


