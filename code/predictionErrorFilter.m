%% prediction error filter. The output is a zero state response.
% @author Kaiwen Sun
% @param frames: L-by-n matrix. Original signal. Each row is a frame of
% signal.
% @param a: coefficient of the linear predictor. predicted_s[n] =
% a[1]s[n-1]+a[2]s[n-2]+...+a[p]s[n-p], where p is the order of the
% predictor. a[1] is the coefficient applied on the most recent known
% signal.
% @return errors: order-by-n matrix. The error signal errors[n] = s[n]-
% predicted_s[n] = s[n]- sum(a[i]s[n-i]). errors[1] is the most early
% error, predicted by all-zero input (aero state response).
function errors = predictionErrorFilter( frames, a )
    errors = zeros(size(frames));
    for col = 1:size(frames,2)
        B = [1;-a(:,col)];
        A = 1;
        errors(:,col) = filter(B,A,frames(:,col));
    end
end

