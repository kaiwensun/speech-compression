%% Term project of ECE252A. Speech encoding/decding system.
% @author Kaiwen Sun

%% meta configuration
filename = 'hello.mp3';
rate = 8000;
windowSize = 180;
%voicedThresh = 0.2;
speechThresh = 0.01;
voicingThresh = 21;

%% load and preprocess audio data
signal = getAudio(filename,rate);
signal = preEmphasis(signal);
frames = getSegment(signal,windowSize);

%% split frames into non-speech, voiced speech and unvoiced speech
[speechFrames, speechInd] = speechDetector(frames,speechThresh);
%[voicingFrames, voicingInd] = speechDetector(speechFrames,voicedThresh);%voicingDetector(speechFrames,rate);
[voicingFrames, voicingInd, ~] = voicingDetector( frames, rate, voicingThresh );

unvoicingInd = xor(speechInd,voicingInd);
unvoicingFrames = frames;
unvoicingFrames(:,~unvoicingInd) = 0;

%% LP analysis
[va,ve,vk,vR] = levinsonDurbin( voicingFrames(:,voicingInd), 10);
[ua,ue,uk,uR] = levinsonDurbin( unvoicingFrames(:,unvoicingInd), 4);

%% prediction error
errorFrames = zeros(size(frames));
errorFrames(:,voicingInd) = predictionErrorFilter(voicingFrames(:,voicingInd),va);
errorFrames(:,unvoicingInd) = predictionErrorFilter(unvoicingFrames(:,unvoicingInd),ua);

%% period
periods = pitchPeriodEstimator(errorFrames,voicingInd, rate);

%% power computation
p = powerComputation(errorFrames,periods,unvoicingInd, voicingInd);
