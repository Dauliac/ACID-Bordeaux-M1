load('donnees.mat')
c1=[2 1;3 2;4 2];
c2=[1 2;1 3;2 3;5 3];
coef=0.0001;
%w=[6;1;-3]
w=[-10;2;2];
x=[-5 17];
%x=[0 7]
it=10;

close all

hold on
scatter(C1(:,1),C1(:,2),'r')
scatter(C2(:,1),C2(:,2),'b')
%scatter(C1(:,1),C1(:,2),'r')
%scatter(C2(:,1),C2(:,2),'b')

y=(-w(1)-w(2)*x)/w(3);
plot(x,y)

[TrainC1,TestC1] = extractTestAndTrain(C1, 500);
[TrainC2, TestC2] = extractTestAndTrain(C2, 500);

for i=1:it
    i
    wprec=w;
    %w=perceptron(wprec,c1,c2,coef);
    w=perceptron(wprec,TestC1,TestC2,coef);
    if(norm(w-wprec)<=0.01)
        break
    end
%     if(norm(w-wprec)<=0.1)
%         break
%     end
    y=(-w(1)-w(2)*x)/w(3);
    plot(x,y)
    pause(1)
end

%CLASSIFICATION


xlim([-5 16])
ylim([-5 15])
% xlim([0 7])
% ylim([0 5])
hold off

