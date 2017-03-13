%% Convert frames matrix to linear signal.
% @author Kaiwen Sun
% @param frames is a matrix, each column of which is a frame.
% @return linearized column vector of signal.
function [ signal ] = frames2signal( frames)
    sz = size(frames);
    signal = reshape(frames,sz(1)*sz(2),1);
end