function [ result ] = myClassifyMAP( data, model1, label1, p1, model2, label2, p2)
%MYCLASSIFYMAP Summary of this function goes here
%   Detailed explanation goes here

    for i=1:size(data)
        if(mvnpdf(data(i,:),model1.mu,model1.var)*p1>=mvnpdf(data(i,:),model2.mu,model2.var)*p2)
            result(i)=label1;
        else
            result(i)=label2;
        end
    end


end

