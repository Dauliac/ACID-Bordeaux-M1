function  MostProbable  = map(test, model1, model2, p1, p2, label1, label2)
% Maximum à posteriori
    
    % Bayesian
    % propC1 = P(f=x|C1)P(C1)
    probC1  = mvnpdf(test,model1.mu, model1.var)*p1;
    % propC2 = P(f=x|C2)P(C2)
    probC2  = mvnpdf(test,model2.mu, model2.var)*p2;

    for i=1:size(test,1)
      if probC2(i) >= probC1(i)
        MostProbable(i) = label2;
      else
        MostProbable(i) = label1;
      end
    end
    
end
