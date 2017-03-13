%decoder
%Impulse train generation with unit amplitude to voiced frame, times power
%computation of error signal in each frame
%white noise geration to unvoiced frame, only 1 random number per frame
%generated
function [errorNoised]=AddNoise(voicingInd, unvoicingInd,errorFrames,power)
errorNoised=zeros(size(errorFrames));
%impulse train with unit amplitude generation to voiced frame
vFrames=errorFrames(:,voicingInd);
ImpulseTrain=ones(1,180).*power(:,voicingInd);
errorNoised(:,voicingInd)=vFrames+ImpulseTrain;

%white noise to unvoiced frame
uFrames = errorFrames(:,unvoicingInd);
errorNoised(:,unvoicingInd)=uFrames+randn(numel(unvoicingInd,1));

end