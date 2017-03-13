function [ y ] = preEmphasis( x, alpha )
    if nargin<2
        alpha = 0.9;
    end
    b = 1;
    a = [1,-alpha];
    y = filter(b,a,x);
end