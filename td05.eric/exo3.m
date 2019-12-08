%% Exercice 3

x=[0 7];

c1=[2 1;3 2;4 2];
c2=[1 2;1 3;2 3;5 3];
c3=[5 3;0 4];
c4=[5 1;6 3];

close all

figure('Name','C1 & C2');
hold on

scatter(c1(:,1),c1(:,2),'r')
scatter(c2(:,1),c2(:,2),'b')

Z=transpose(createMatrix(c1,c2));
b=ones(size(Z,1),1);
w=Z\b;

y=(-w(1)-w(2)*x)/w(3);
plot(x,y)

xlim([0 7])
ylim([0 5])
hold off

figure('Name','C3 & C4');

x=[-1 7];

hold on

scatter(c3(:,1),c3(:,2),'r')
scatter(c4(:,1),c4(:,2),'b')



Z2=transpose(createMatrix(c3,c4));
b2=ones(size(Z2,1),1);
w2=Z2\b2;

y=(-w2(1)-w2(2)*x)/w2(3);
plot(x,y)


wprec=w2;
bprec=b2;
b2=bprec+2*(Z2*wprec-bprec)
b2(b2<0)=0
w2=Z2\b2;

% while(norm(w2-wprec)<=0.01)
%     wprec=w2;
     while(norm(b2-bprec)<=0.01)
         bprec=b2;
         b2=bprec+2*0.01*(Z2*wprec-bprec);
         b2(b2<0)=0
     end
%     w2=Z2\b2;
%     y=(-w2(1)-w2(2)*x)/w2(3);
%     plot(x,y)
% end

w2=Z2\b2;
y=(-w2(1)-w2(2)*x)/w2(3);
plot(x,y)

xlim([-1 7])
ylim([0 5])
hold off