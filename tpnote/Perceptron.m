
function [W] = Perceptron (Y, W)
% Y: la matrice preparée pour le perceptron:
%    [MC1, MC2]=createLinearClassMatrices(TestC1,TestC2);
%    M=[MC1 -MC2];
% W : paramètres de la frontière linéaire = vecteur colonne

% recherche des échantillons mal placés relativement à la frontière W
% on voudrait C1 coté positif et C2 coté négatif

Ym = PerceptronMalPlace(Y, W);

% minimisation du critère (somme des distances des mal placés à la frontière)
eta = 0.1;
s = sum(Ym, 2);
Wnext =  W + eta * s;
k = 1;

epsilon = 0.001;

%while(size(Ym, 2) != 0) => Pb si pas séparable!
while (norm(W-Wnext) > epsilon)
W = Wnext;
Ym = PerceptronMalPlace(Y, W);
s = sum(Ym, 2);
k = k+1;
Wnext = W + eta/k * s; % diviser par k ralentit l'évolution pour forcer l'arrêt

end

end
