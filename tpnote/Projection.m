function [proj] = Projection(W, VT)
% Don't transpose VT
    proj = VT*W;
end