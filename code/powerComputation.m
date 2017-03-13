function [ power ] = powerComputation(errorFrames, periods,unvoicingInd,voicingInd) 
    power = zeros(1,size(errorFrames,2));
    %% power of unvoiced frames
    uFrames = errorFrames(:,unvoicingInd);
    power(:,unvoicingInd) = mean(uFrames.^2);
    
    %% power of voicied frames
    windowSize = size(errorFrames,1);
    for col = 1:size(errorFrames,2)
        if voicingInd(col)~=0
            stop = windowSize*mod(periods(col),windowSize);
            errorFrames(stop+1:end,col) = 0;
        end
    end
    vFrames = errorFrames(:,voicingInd);
    power(:,unvoicingInd) = mean(vFrames.^2);
end

