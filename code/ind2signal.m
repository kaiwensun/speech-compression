function [ sig ] = ind2signal( ind, windowSize )
    sig = reshape(repmat(ind,windowSize,1),windowSize*length(ind),1);
end

