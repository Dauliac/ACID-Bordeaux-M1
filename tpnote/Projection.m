function [proj] = Projection(W, VT)
% Don't transpose VT
    disp(size(W));
    disp(size(VT));

    proj = transpose(VT*W);
end