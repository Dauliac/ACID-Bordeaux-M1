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