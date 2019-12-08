function [ ] = GaussianCompareClass( C1, C2 )
%GAUSSIANCOMPARECLASS Summary of this function goes here
%   Detailed explanation goes here

for i=1:size(C1,2)
    C1f = C1(:, i);
    C2f = C2(:, i);
    
    Title = sprintf('Compare C1 and C2 for feature: %i',i);

    figure('Name', Title);
    hold on;
    
    % Sur la premiere dimension:
    [C1mu, C1sigma] = normfit(C1f);
    [C2mu, C2sigma] = normfit(C2f);

    C1y = normpdf(C1f, C1mu, C1sigma);
    C2y = normpdf(C2f, C2mu, C2sigma);

    names{1} = sprintf('C1 feature %i',i);
    names{2} = sprintf('C2 feature %i',i);

    plot(C1f, C1y, '.');
    plot(C2f, C2y, '.');
    legend(names);
    hold off
end

end

