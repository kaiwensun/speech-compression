%% prediction error filter. The output is a zero state response.
% @author Kaiwen Sun
% @param frames: L-by-n matrix. Original signal. Each row is a frame of
% signal.
% @param a: coefficient of the linear predictor. predicted_s[n] =
% a[1]s[n-1]+a[2]s[n-2]+...+a[p]s[n-p], where p is the order of the
% predictor. a[1] is the coefficient applied on the most recent known
% signal.
% @return errors: The error signal errors[n] = s[n]-predicted_s[n] = s[n]-
% sum(a[i]s[n-i]). errors[1] is the most early error, predicted by all-zero
% input (aero state response).
function errors = predictionErrorFilter( frames, a )
    if(size(a,1)~=1)
        a = a'; %make a a row vector
    end
    B = [1,-a];
    A = 1;
    errors = filter(B,A,frames);
end

