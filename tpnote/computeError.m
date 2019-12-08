function [nbErrors] = computeError(Res, expectedLabel)
    nbErrors = sum(Res ~= expectedLabel);
end

