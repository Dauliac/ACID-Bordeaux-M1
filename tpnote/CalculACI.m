function [ V ] = CalculACI( C1, C2 )
    mu1 = mean(C1)';
    mu2 = mean(C2)';
    mu = (mu1 + mu2) ./2;
    
    S1 = cov(C1);
    S2 = cov(C2);
    Sw =  S1 + S2
    
    n1 = size(C1, 1);
    n2 = size(C2, 1);
    
    sb1 = n1.* (mu1-mu)'*(mu1-mu); 
    sb2 = n2.* (mu2-mu)'*(mu2-mu); 

    Sb = sb1 + sb2;
    invSw = inv(Sw);
    invSwSb = invSw * Sb;
    [V, d] = eig(invSwSb)
end

function [ res ] = calculACI( train1,train2 )
%CALCULACI Summary of this function goes here
%   Detailed explanation goes here

    C1=cov(train1);
    C2=cov(train2);
    res=((C1+C2).^-1)*transpose(mean(train1)-mean(train2));


end
