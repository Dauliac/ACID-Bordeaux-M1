function [W] = CalculACI (C1, C2)
    %%%% M?thode 1 %%%%
%     C1
%     C2
%     mu1 = mean(C1);
%     mu2 = mean(C2);
%     mu = mu1 + mu2 ./2;
% 
%     S1 = cov(C1);
%     S2 = cov(C2);
%     Sw =  S1 + S2;
% 
%     n1 = size(C1, 1);
%     n2 = size(C2, 1);
% 
%     Sb1 = n1 .* (mu1-mu)'*(mu1-mu); 
%     Sb2 = n2 .* (mu2-mu)'*(mu2-mu); 
% 
%     Sb = Sb1 + Sb2;
%     invSw = inv(Sw);
%     invSwSb = invSw * Sb;
%     [W, d] = eig(invSwSb);

    %%%% M?thode 2 %%%%
    Sw = cov(C1)+cov(C2);
    m1 = mean(C1);
    m2 = mean(C2);
    W = inv(Sw)*(m1-m2)';

end