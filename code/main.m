%% Term project of ECE252A. Speech encoding/decding system.
% @author Kaiwen Sun

%% meta configuration
filename = 'hello.mp3';
rate = 8000;
windowSize = 180;
%voicedThresh = 0.2;
speechThresh = 0.01;
voicingThresh = 21;

%% load audio data
signal = getAudio(filename,rate);

%% get segments (frames)
frames = getSegment(signal,windowSize);

%% split frames into non-speech, voiced speech and unvoiced speech
[speechFrames, speechInd] = speechDetector(frames,speechThresh);
%[voicingFrames, voicingInd] = speechDetector(speechFrames,voicedThresh);%voicingDetector(speechFrames,rate);
[voicingFrames, voicingInd, ~] = voicingDetector( frames, rate, voicingThresh );

unvoicingInd = xor(speechInd,voicingInd);
unvoicingFrames = frames;
unvoicingFrames(:,~unvoicingInd) = 0;

%% temp test
hold off
plot(frames2signal(voicingFrames),'r')
hold on
plot(frames2signal(unvoicingFrames),'b')

