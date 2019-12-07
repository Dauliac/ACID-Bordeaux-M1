function [ratio] = computeError(Res, expectedLabel)
    % Sum unexpected label
    nbErrors = sum(Res ~= expectedLabel);
    ratio = nbErrors / length(Res);
end