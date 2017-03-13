function [ voicingFrames, voicingInd, zeroCrossCnt] = voicingDetector( frames )
    %threshF = 3000;%Energy for voiced speech tends to concentrate below 3KHz.
    thresh = 21;
    sgn = frames<0;
    cross = xor(sgn(1:end-1,:),sgn(2:end,:));
    zeroCrossCnt = sum(cross);
    voicingInd = zeroCrossCnt<thresh;
    voicingFrames = frames;
    voicingFrames(:,~voicingInd) = 0;
end