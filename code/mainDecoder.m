%% Main decoder of ECE252A term project.
% @author Kaiwen Sun
% @para a: (order+1)-by-n matrix. a(:,1) is always ones. Approximatly 
% a[0]*R[0] = a[1]*R[1]+a[2]*R[2]*...*a[p]*R[p]. The values of a are
% negative of that returned by MATLAB levinson().
% @para periods: 1-by-n vector. Each element is the period of the
% corresponding frame, in the unit of number of samples. For unvoiced
% frames indicated by voicingInd, the period is 0.
% @para power: 1-by-n vector. Indicates the power of each frame. The
% power of voiced and unvoiced frames are computed in different ways.
% @para voicingInd: row bitmap index of voicing frames.
% @para unvoicingInd: row bitmap index of unvoicing frames.
% @return reconstSig: reconstructed signal. (n*windowSize)-by-1 vector.

function reconstSig = mainDecoder(a,periods, power, voicingInd, unvoicingInd, windowSize)
    reconstSig = zeros(size(power,2)*windowSize,1);
    i = 1;
    while i<=length(reconstSig)
        frameId = ceil(i/windowSize);
        if voicingInd(frameId)
            T = periods(:,frameId);
            impulse = [0.5*sqrt(power(frameId));zeros(T-1,1)];
            B = 1;
            A = [1;-a(:,frameId)];
            pitch = filter(B,A,impulse);
            reconstSig(i:min(i+T-1,length(reconstSig)),1) = pitch(1:min(i+T-1,length(reconstSig))-i+1);
            i = i+T;
        else if unvoicingInd(frameId)
            whiteNoise = randn(windowSize,1)*power(frameId);
            B = 1;
            A = [1;-a(:,frameId)];
            colorfulNoise = filter(B,A,whiteNoise);
            reconstSig(i:min(i+windowSize-1,length(reconstSig)),1) = colorfulNoise(1:min(i+windowSize-1,length(reconstSig))-i+1);
            i = i+windowSize;
        else
            i = i+1;
            end
        end
    end
    reconstSig = DeEmphasis(reconstSig,0.5);
end

