clear all
load ('donnees3.mat')

close all
figure(1)
hold on

axis equal

scatter3(C1(:, 1), C1(:,2),C1(:, 3))
scatter3(C2(:, 1), C2(:,2),C2(:, 3), 'r')
hold off

moyenne1_1 = mean(C1(:,1))
moyenne1_2 = mean(C1(:,2))
moyenne1_3 = mean(C1(:,3))

moyenne2_1 = mean(C2(:,1))
moyenne2_2 = mean(C2(:,2))
moyenne2_3 = mean(C2(:,3))

moy_all = cov(C2)
cov_all = cov(C2)