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
            p = power(frameId);
         
             %% test begin
            tCenter = mod(i,windowSize)+T/2;
            if tCenter>=windowSize/2 && frameId+1<=size(voicingInd,2) && voicingInd(frameId+1)
                alpha = tCenter/windowSize-0.5;     %0~0.5
                T = round((0.5+alpha)*T+(0.5-alpha)*periods(:,frameId+1));
                p = (0.5+alpha)*p+(0.5-alpha)*power(frameId+1);
            end
            if tCenter<windowSize/2 && frameId-1>=1 && voicingInd(frameId-1)
                alpha = 0.5-tCenter/windowSize; %0~0.5
                T = round((0.5+alpha)*T+(0.5-alpha)*periods(frameId-1));
                p = (0.5+alpha)*p+(0.5-alpha)*power(:,frameId-1);
            end
          %% test end
          
            impulse = [0.5*sqrt(p);zeros(T-1,1)];
            B = 1;
            A = [1;-a(:,frameId)];
            pitch = filter(B,A,impulse);
            pitch = pitch - mean(pitch);
            reconstSig(i:min(i+T-1,length(reconstSig)),1) = pitch(1:min(i+T-1,length(reconstSig))-i+1);
            i = i+T;
        else if unvoicingInd(frameId)% || (voicingInd(frameId) && mod(i,windowSize)+T/2>windowSize)
            whiteNoise = randn(windowSize,1)*power(frameId);
            B = 1;
            A = [1;-a(:,frameId)];
            colorfulNoise = filter(B,A,whiteNoise);
            colorfulNoise = colorfulNoise-mean(colorfulNoise);
            reconstSig(i:min(i+windowSize-1,length(reconstSig)),1) = colorfulNoise(1:min(i+windowSize-1,length(reconstSig))-i+1);
            i = i+windowSize;
        else
            i = windowSize*frameId+1;
            end
        end
    end
    reconstSig = DeEmphasis(reconstSig,0.9375);
end

