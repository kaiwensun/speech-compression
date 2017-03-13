function [ a,e,k,R] = levinsonDurbin( frames, order )
    R = getHalfAutocorrelation(frames, order);
    R = R(:,9);
    R = [5;4;3;2;1];
    a = [ones(1,1),zeros(1,order)];
    e = [R(1,1),zeros(1,order)];
    k = zeros(1,order+1);
    for i = 1:order
        k(1,i+1) = (R(i+1,1)-a(1,2:i)*flipud(R(2:i,1)))/e(i);
        a(1,2:i) = a(1,2:i)-k(1,i+1)*fliplr(a(1,2:i));
        a(1,i+1) = k(1,i+1);
        e(1,i+1) = (1-k(1,i+1).^2)*e(1,i);
    end
    
end

function R = getHalfAutocorrelation(frames, order)
    R = zeros(order+1,size(frames,2));
    for f = 1:size(frames,2)
        ac = xcorr(frames(:,f));
        R(:,f) = ac(size(frames,1):size(frames,1)+order);
    end
end