%% compute power for each frame for generation of pulse train.
% @author Kaiwen Sun
% @param errorFrames: L-by-n frames. Each column is a frame.
% @param periods: 1-by-n vector. The period for each frame, in the unit of
% number of samples.
% @param unvoicingInd: 1-by-n vector. Inidcates whether a frame is unvoiced.
% @param voicingInd: 1-by-n vector. Indicates whether a frame is voicied.
% @return power: 1-by-n vector. Indicates the power of each frame. The
% power of voiced and unvoiced frames are computed in different ways.
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
    power(:,voicingInd) = mean(vFrames.^2);
end

