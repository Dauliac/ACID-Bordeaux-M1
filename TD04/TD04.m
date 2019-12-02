%
% % Calcul des valeurs propres / vecteurs propre d'une matrice (eig)
% % Visualisation des vecteurs propres de la matrice de covariance
% % d'un nuage de points
%

mu = [0 0]
sigma = [1 1.5 ; 1.5 3]
X = mvnrnd(mu,sigma,200); 


figure ('Name', 'Vecteurs propres');
axis equal
hold on
scatter(X(:,1), X(:,2));

A= cov(X)

[V D] = eig(A);
D
Vdir1 = V(:,1)
Vdir2 = V(:,2)
x=-2:2;

y1 = droite2DVd(x,Vdir1,mu)

plot(x,y1,'r')

y2 = droite2DVd(x,Vdir2,mu)


plot(x,y2,'g')
hold off 

%%%% ACP %%%%

muSaumon = [8 8]
sigmaSaumon = [ 1,0;0,1]

muBar = [12 12]
sigmaBar = [ 4,0;0,4]

sizeVTSaumon = 1000
sizeVTBar = 1000

VTSaumon = mvnrnd(muSaumon, sigmaSaumon, sizeVTSaumon)
VTBar = mvnrnd(muBar, sigmaBar, sizeVTBar)

figure('Name', 'ACP');
scatter(VTBar(:,1), VTBar(:,2));
hold on;
scatter(VTSaumon(:,1), VTSaumon(:,2));

VT = [VTSaumon; VTBar];
Vacp = CalculACP(VT);

x=0:20;
y=0:0;

pointsACP = droite2DVd(x, Vacp, mu);
plot(x, pointsACP, 'r');

%%%% ACI %%%%

figure('Name', 'ACI');
scatter(VTBar(:,1), VTBar(:,2));
hold on;
scatter(VTSaumon(:,1), VTSaumon(:,2));

Vaci = CalculACI(VTBar, VTSaumon);

pointsACI = droite2DVd(x, Vaci, mu);
plot(x, pointsACI, 'r');