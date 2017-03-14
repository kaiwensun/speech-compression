%% load audio file at a given frequency
% @author Kaiwen Sun
% @param filename: filename of audio file.
% @param rate: convert the audio signal to 'rate' frequency.
% @return s: audio signal in the rate frequency.
function [ s ] = getAudio( filename,rate )
    [s,fs] = audioread(filename);
    t = floor(1:(fs/rate):length(s));
    s = s(t);
    if(size(s,1)<3)
        s = s';
    end
end

