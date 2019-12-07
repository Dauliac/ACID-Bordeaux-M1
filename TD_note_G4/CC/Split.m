function [Train, Test] = Split(Dataset, Percent)

% Separate test and train
% Determine how many rows 10% is.
rows = size(Dataset,1);
% Determine the last row number of the top  (upper) 10% of rows.
lastRow = floor((Percent * rows)/100);
fprintf('lastRow: %i\n', lastRow);

Train = Dataset(1:lastRow, :);
Test = Dataset(lastRow+1:end, :);

end
