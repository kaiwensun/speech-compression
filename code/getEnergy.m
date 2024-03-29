%% Get energy of each frame.
% @author Kaiwen Sun
% @param frames: L-by-n matrix. Each column of frames is a frame.
% @return energy: a row vector as long as the width of frames.
%%
function energy = getEnergy(frames)
    sz = size(frames);
    energy = sum(frames.^2)/sz(1);
end

