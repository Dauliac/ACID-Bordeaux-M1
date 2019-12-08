function  [] = GaussianClass( Class )
% Give me a class i give you a gaussian

figure('Name', inputname(1));
names = {};
hold on;
for i=1:size(Class,2)
    class = Class(:,i);
    % Sur la premiere dimension:
    [mu,sigma] = normfit(class);
    y = normpdf(class,mu, sigma);
    names{i} = sprintf('Feature number: %i',i);

    plot(class, y, '.');
end
legend(names);
hold off
end
