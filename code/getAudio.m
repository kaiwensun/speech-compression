function [ s ] = getAudio( filename,rate )
    [s,fs] = audioread(filename);
    t = floor(1:(fs/rate):length(s));
    s = s(t);
end

