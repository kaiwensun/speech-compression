% @author Yu Wang
function [ y ] = DeEmphasis( x, alpha )
    if nargin<2
        alpha = 0.9375;
    end
    b = 1;
    a = [1,-alpha];
    y = filter(b,a,x);
end