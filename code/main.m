%% Term project of ECE252A. Speech encoding/decding system.
% @author Kaiwen Sun

%% meta configuration
%filename = 'original sound/hello.mp3';
filename = 'sentence.wav';

[a ,periods,power,voicingInd,unvoicingInd, windowSize ] = mainEncoder( filename );
%% save variables
save('pack.mat','a','periods','power','voicingInd','unvoicingInd');

%% reconstruct
reconstSig = mainDecoder(a(2:end,:),periods, power, voicingInd, unvoicingInd, windowSize);
rate = 8000;
soundsc(reconstSig,rate);

%% save reconstructed sound
reconstSig = reconstSig./max(reconstSig).*0.8;
audiowrite('reconstructed.wav',reconstSig,rate);

% %% debug
% close all
% %plot voiced and unvoiced speech
% figure(1)
% plot(frames2signal(unvoicingFrames), 'b');
% plot(frames2signal(voicingFrames),'r');
% 
% %compare original sound and reconstructed sound
% hold off
% plot(signal-1,'r')
% hold on
% plot(reconstSig./max(reconstSig))
% plot(ind2signal(voicingInd,windowSize)*0.1-0.2,'g')
% plot(ind2signal(unvoicingInd,windowSize)*0.1-0.4,'k')
