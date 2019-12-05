```matlab
fprintf: Afficher ex: ('mu: %s\n',muVector)
scatter: afficher un graphique avec des points pour les données (X,Y)
zeros: Créer un tableau de 0 (nb dimensions)
Transpose: '
find:
regress: y X Attention, la première col de x c'est que des 1
eig: Retourne vect propre, valeurs propre de la matrice de cov, la diag de la cov. Pour acp on ne prend que la valeur propre
eigs: prend le nombre de valeurs propre à garder
diag: retrourne la diag d'une matrice
sort: (vect, 'descent') trier par descroissant
```

# Select random part from matrix
m=10;
R=rand(n,m)

# Select first 10% from matrix
```matlab
% Determine how many rows 10% is.
[rows, columns] = size(R);
% Determine the last row number of the top  (upper) 10% of rows.
lastRow = int32(floor(0.1 * rows));
% Get first 10% into one array M:
M = R(1:lastRow, :);
% Get the rest into one array N:
N = R(lastRow+1:end, :);
```

# Lois normale
```matlab
figure('Name', 'Normal distribution');
hold on;
% Sur la premiere dimension:
% Note remplacer X dans VTSaumon(:,X) pour les autres dimensions
[mu,sigma]=normfit(VTSaumon(:,1));
y = normpdf(VTSaumon(:,1),mu, sigma);
fprintf('mu: %s\nsigma: %s\n',mu, sigma)
plot(VTSaumon(:,1),y,'.');

% Sur toutes les dimensions:
%[muVector,sigmaVector]=normfit(VTSaumon());
% y = normpdf(VTSaumon,muVector,sigmaVector);
%fprintf('mu: %s\n',muVector)
%plot(VTSaumon,y,'.');
```
