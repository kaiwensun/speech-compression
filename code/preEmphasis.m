%% Pre-emphasis signal.
% @author Kaiwen Sun
% @param x: signal
% @param alpha: parameter of filter H(z) = 1-alpha*z^(-1). alpha=0.9 by
% default.
% @return y: pre-emphasised signal.
function [ y ] = preEmphasis( x, alpha )
    if nargin<2
        alpha = 0.9;
    end
    b = 1;
    a = [1,-alpha];
    y = filter(b,a,x);
end