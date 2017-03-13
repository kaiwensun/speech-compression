%% 
% @param frames is columns of frame
% @param energy is a row vector
% @param thresholdRatio is the ratio of nonspeech energy ratio. 0.01 by
% defualt
% @return speech has same size as frames, with zeros at non-speech frame.
% @return speechInd indicates index of speech signal.
% @note: this function can be used to detect either voiced signal or speech
% signal.

function [ speech, speechInd] = speechDetector( frames, thresholdRatio)
    energy = getEnergy(frames);
    if nargin <2
        thresholdRatio = 0.01;
    end;
    speechInd = energy>max(energy)*thresholdRatio;
    speech = frames;
    speech(:,~speechInd)=0;
end

