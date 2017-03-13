filename = 'hello.mp3';
rate = 8000;
windowSize = 180;
voicedThresh = 0.1;
speechThresh = 0.01;
%% load, preprocess audio data
signal = getAudio(filename,rate);
%signal = signal(30000:60000);

%% get segments
frames = getSegment(signal,windowSize);

[speechFrames, speechInd] = speechDetector(frames);
%[voicingFrames, voicingInd] = speechDetector(speechFrames,0.2);%voicingDetector(speechFrames,rate);
[voicingFrames, voicingInd, ~] = voicingDetector(speechFrames);

unvoicingInd = xor(speechInd,voicingInd);
unvoicingFrames = frames;
unvoicingFrames(:,~unvoicingInd) = 0;


hold off
plot(frames2signal(voicingFrames),'r')
hold on
plot(frames2signal(unvoicingFrames))

