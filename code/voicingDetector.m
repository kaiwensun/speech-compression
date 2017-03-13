%% Detect voicing frames
% @author Kaiwen Sun
% @param frames: L-by-n matrix. Each column is a frame.
% @param rate: Frequency of signal in Hz. assume to be 8000Hz if not
% specified.
% @param voicingThresh: A threshold indicating the number of zero-crosses
% in a frame. Will be adjusted by rate and frame size. By default is 21.
% @return voicingFrames: L-by-n matrix. Non-voicing frames are set to 0.
% @return voicingInd: row bitmap index of voicing frames.
% @return zeroCrossCnt: row vector. Number of zero-crosses in each frame.
function [ voicingFrames, voicingInd, zeroCrossCnt] = voicingDetector( frames, rate, voicingThresh )
    %threshF = 3000;%Energy for voiced speech tends to concentrate below 3KHz.
    if nargin<2
        rate = 8000;
    end
    if nargin<3
        voicingThresh = 21;
    end
    thresh = voicingThresh*(size(frames,1)/180)/(rate/8000);
    sgn = frames<0;
    cross = xor(sgn(1:end-1,:),sgn(2:end,:));
    zeroCrossCnt = sum(cross);
    voicingInd = zeroCrossCnt<thresh;
    voicingFrames = frames;
    voicingFrames(:,~voicingInd) = 0;
end