function [ nouv ] = perceptron(w,c1,c2,coef )
%RECUPERRORS Summary of this function goes here
%   Detailed explanation goes here

mat=createMatrix(c1,c2);

res=transpose(w)*mat;
ind=zeros(size(mat,1),1);
for i=1:size(res,2)
    if res(i)<0
        ind=[ind+mat(:,i)];
    end
end

nouv=w+coef*ind;

end


