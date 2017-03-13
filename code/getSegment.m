%% Segment if length of s is not a multiple of windowSize, padding 0 will be added
% @author Kaiwen Sun
% @param s: signal. can be either column or row vector
% @param windowSize: segment length.
% @return frames: a matrix each column of which is a segment.
%%
function frames = getSegment( s, windowSize )
    % make sure s is a column vector
    sz = size(s);
    if(sz(1)<sz(2))
        s = s';
    end
    
    %padding and reshape
    l = ceil(length(s)/windowSize)*windowSize;
    s = padarray(s,l-length(s),'post');
    frames = reshape(s,windowSize,l/windowSize);
end

