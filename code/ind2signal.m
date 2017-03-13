%% Extend frame bitmap-index to signal-length.
% @author Kaiwen Sun
% @param ind: frame bitmap-index. row vector. For example, [0,1,1]
% indicates the second and third frame.
% @param windowSize: scalar. length of a window.
% @return sig: extended bitmap-index. For example, if ind=[0,1,1],
% windowSize=3, then sig=[0,0,0,1,1,1,1,1,1].
function [ sig ] = ind2signal( ind, windowSize )
    sig = reshape(repmat(ind,windowSize,1),windowSize*length(ind),1);
end

