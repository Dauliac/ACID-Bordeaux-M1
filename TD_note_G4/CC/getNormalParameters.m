function [model] = getNormalParameters(Train)

model.mu = mean(Train);
model.var = cov(Train);

end
