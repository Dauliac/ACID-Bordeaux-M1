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

% Lois normale
% MU
var: (DataMatrix) calcule la variance d'un jeu de données
% SIGMA
mean: (DataMatrix) calcule la moyenne d'un jeux de données
```

# Select random part from matrix
m=10;
R=rand(n,m)


# Exctract jeu de test et jeu d'entrainement
##Select first 10% from matrix
```matlab
% Determine how many rows 10% is.
[rows, columns] = size(R);
% Determine the last row number of the top  (upper) 10% of rows.
lastRow = int32(floor(0.1 * rows));
% Get first 10% into one array M:
Test = R(1:lastRow, :);
% Get the rest into one array N:
Train = R(lastRow+1:end, :);
```

## Extraire le test pour les `sizeTrain` premiers
```matlab
% Test: jeu de test
% Train: jeu d'entrainement
function [Train,Test] = extractTestAndTrain(GT, sizeTrain)

    sizeGT= size(GT,1);
    
    Indices      = randperm(sizeGT);
    TrainIndices = Indices(1:sizeTrain);
    TestIndices  = Indices(sizeTrain+1:sizeGT);
        
    Train    = GT(TrainIndices,:);
    Test     = GT(TestIndices,:);
end
```

# Lois normale
L'exemple est dans le td04.aurelien: `loisNormale.m`

```matlab
figure('Name', 'Normal distribution');
hold on;
% Sur la premiere dimension:
% Note remplacer X dans VTSaumon(:,X) pour les autres dimensions
[mu,sigma]=normfit(VTSaumon(:,1));
y = normpdf(VTSaumon(:,1),mu, sigma);
fprintf('mu: %s\nsigma: %s\n',mu, sigma)
plot(VTSaumon(:,1),y,'.');
% Connaitre le nombre de dimentions
nbDescripteur = size(VTSaumon,2);
fprintf('Il y a %s descripteur', nbDescripteur)

% Sur toutes les dimensions:
%[muVector,sigmaVector]=normfit(VTSaumon());
% y = normpdf(VTSaumon,muVector,sigmaVector);
%fprintf('mu: %s\n',muVector)
%plot(VTSaumon,y,'.');
```

# Bayesienne
P(A|B)=P(B|A)*P(A)/P(B)

## maximum de vraissemblance
On donne pour P(A) une valeur choisie:
Si y'a 2 choix on prend souvent 0.5: 50/50

## A priori
On utilise la lois normale pour avoir la proportion.

```
Calcul lois normale, et on tri par rapport à P(C1|f=x)
Si P(C1|f=x) >  P(C2|f=x)
    C1
Sinon
    C2
```
