function [ nouv ] = perceptron(w,c1,c2,coef )
%RECUPERRORS Summary of this function goes here
% Detailed explanation goes here

[MC1, MC2]=createLinearClassMatrices(c1,c2);
M=[MC1 MC2*-1];

res=transpose(w)*M;
ind=zeros(size(M,1),1);
for i=1:size(res,2)
    if res(i)<0
        ind=[ind+M(:,i)];
    end
end

nouv=w+coef*ind;

end


