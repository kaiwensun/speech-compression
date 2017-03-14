%% De-emphasis signal
% @author Yu Wang
% @param x: signal
% @param alpha: parameter of filter H(z) = 1/(1-alpha*z^(-1)). alpha=0.9375
% by default.
% @return y: de-emphasised signal.
function [ y ] = DeEmphasis( x, alpha )
    if nargin<2
        alpha = 0.9375;
    end
    b = 1;
    a = [1,-alpha];
    y = filter(b,a,x);
end