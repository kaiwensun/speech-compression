%% Estimate the pitch period, in the unit of number of samples.
% @author Kaiwen Sun
% @param frames: L-by-n matrix. Each column is a frame.
% @param voicingInd: 1-by-n bitmap vector. Indicates if a frame is a voiced
% (periodical) frame. All ones by default. I.e. if not given, then assume
% all frames are voiced.
% @param rate: Sample frequency of signal. 8000 by default. This parameter
% is used to decide where to start searching lags.
% @return lags: 1-by-n vector. Each element is the period of the
% corresponding frame, in the unit of number of samples. For unvoiced
% frames indicated by voicingInd, the period is 0.
% @return minMdf: 1-by-n vector. Each element is the minimum average of
% absolute difference of magnitude, corresponding to the lags. For unvoiced
% frames indicated by voicingInd, the minimum value is Inf.
function [lags, minMdf] = pitchPeriodEstimator( frames, voicingInd, rate)
    if nargin < 2
        voicingInd = ones(1,size(frames,2));
    end
    if nargin < 3
        rate = 8000;
    end
    windowSize = size(frames,1);
    frames = frames(:,voicingInd);
    voicingLags = zeros(1,size(frames,2));
    voicingMinMdf = Inf(1,size(frames,2));
    startLag = 20*rate/8000;
    for l = startLag:ceil(windowSize/2)
        mdf = mean(abs(frames(1+l:end,:)-frames(1:end-l,:)));
        %Should the above be mean or sum? The textbook example says sum,
        %but I think mean makes more sense.
        smallerMdfInd = mdf<voicingMinMdf;
        voicingMinMdf(smallerMdfInd) = mdf(smallerMdfInd);
        voicingLags(smallerMdfInd) = l;
    end
    lags = zeros(1,size(voicingInd,2));
    minMdf = Inf(1,size(voicingInd,2));
    lags(voicingInd) = voicingLags;
    minMdf(voicingInd) = voicingMinMdf;
end

