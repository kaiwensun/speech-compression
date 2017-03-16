%% Main encoder of ECE252A term project.
% @author Kaiwen Sun
% @param filename: the audio filename
% @return a: (order+1)-by-n matrix. a(:,1) is always ones. Approximatly 
% a[0]*R[0] = a[1]*R[1]+a[2]*R[2]*...*a[p]*R[p]. The values of a are
% negative of that returned by MATLAB levinson().
% @return periods: 1-by-n vector. Each element is the period of the
% corresponding frame, in the unit of number of samples. For unvoiced
% frames indicated by voicingInd, the period is 0.
% @return power: 1-by-n vector. Indicates the power of each frame. The
% power of voiced and unvoiced frames are computed in different ways.
% @return voicingInd: row bitmap index of voicing frames.
% @return unvoicingInd: row bitmap index of unvoicing frames.
% @return windowSize: length of each frame.
function [ a,periods,power,voicingInd,unvoicingInd, windowSize ] = mainEncoder( filename )
rate = 8000;
windowSize = 180;
speechThresh = 0.008;
%voicedThresh = 0.001;   %decreasing thresh gives more voiced frames.
voicingThresh = 80;%decreasing thresh gives more unvoiced frames.

%% load and preprocess audio data
signal = getAudio(filename,rate);
signal = preEmphasis(signal);
frames = getSegment(signal,windowSize);
%signal = frames2signal(frames); %padding to signal.

%% split frames into non-speech, voiced speech and unvoiced speech
[speechFrames, speechInd] = speechDetector(frames,speechThresh);
%[voicingFrames_energy, voicingInd_energy] = speechDetector(speechFrames,voicedThresh);%voicingDetector(speechFrames,rate);
[~, voicingInd, ~] = voicingDetector( speechFrames, speechInd, rate, voicingThresh );
%voicingInd = voicingInd & voicingInd_energy;
%voicingFrames(:,voicingInd) = speechFrames(:,voicingInd);

unvoicingInd = xor(speechInd,voicingInd);
%unvoicingFrames = frames;
%unvoicingFrames(:,~unvoicingInd) = 0;

%% LP analysis
[a,~,~,~] = levinsonDurbin(speechFrames, 10);

%% prediction error
errorFrames =predictionErrorFilter(speechFrames,a(2:end,:));


%% period
periods = pitchPeriodEstimator(errorFrames,voicingInd, rate);

%% power computation
power = powerComputation(errorFrames,periods,unvoicingInd, voicingInd);

end