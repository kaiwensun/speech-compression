%% find Levinson-Durbin parameters for frames
% @param frames: L-by-n matrix. L is frame size. n is number of frames.
% @param order: the order of levinson
% @return a: n-by-(order+1) matrix. a(:,1) is always ones. Approximatly 
% a[0]*R[0] = a[1]*R[1]+a[2]*R[2]*...*a[p]*R[p]. The values of a are
% negative of that returned by MATLAB levinson().
% @return e: n-by-(order+1) matrix. e(:,order+1) is the final error.
% e(:,j) is the error in the j-th recursion.
% @return k: n-by-(order+1) matrix. PARCOR coeffieients. k(:,1) is always
% zeros. The values of k are negative of that returned by MATLAB
% levinson().
% @return R: (order+1)-by-n matrix. Auto-correlation.
function [a,e,k,R] = levinsonDurbin( frames, order )
    sz = size(frames);
    R = getHalfAutocorrelation(frames, order);
    a = [ones(sz(2),1),zeros(sz(2),order)];
    e = [R(1,:)',zeros(sz(2),order)];
    k = zeros(sz(2),order+1);
    for i = 1:order
        k(:,i+1) = (R(i+1,:)'-diag(a(:,2:i)*flipud(R(2:i,:))))./e(:,i);
        a(:,2:i) = a(:,2:i)-bsxfun(@times,k(:,i+1),fliplr(a(:,2:i)));
        a(:,i+1) = k(:,i+1);
        e(:,i+1) = (1-k(:,i+1).^2).*e(:,i);
    end
end

function R = getHalfAutocorrelation(frames, order)
    R = zeros(order+1,size(frames,2));
    for f = 1:size(frames,2)
        ac = xcorr(frames(:,f));
        R(:,f) = ac(size(frames,1):size(frames,1)+order);
    end
end