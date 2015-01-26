% Computes logq, which is the logarithm of the numerator of qhat_{tx}(A) in
% equation 11 of the paper on June 25,2012.  The inputs are:
%
% k		number of alternatives.  All vectors are of length k.
% delta	IZ parameter
% n		vector of number of samples taken from each alternative.
% avg		vector of sampling means
% M2		vector of sums of the square of the differences from
% 		the current sample mean.  M2[x]/n[x] gives the sample variance.
% logq		vector of length k.  If logq[x] == -INFINITY, this
% 		means that alternative has already been eliminated.  Otherwise,
% 		the logq[x] is ignored.
%
% Puts results into the vector logq, and returns statistics computed from this vector.
function [logq sumq worst_logq worst_x] = BIZUNK_UpdateLogQ(delta, n, avg, M2, logq)
    % Sum up number of samples and sample variances.
    in_contention = logq > -Inf; % indices of alternatives that haven't been eliminated.
    N = sum(n(in_contention));
    sumvar = sum(M2(in_contention) ./ n(in_contention)); % sum of the sample variances.

    % Calculate new logq values and statistics based on them.
    logq(in_contention) = delta * avg(in_contention) * N / sumvar;

    % This normalizes everything, so that the logqs don't grow too large,
    % causing numerical overflow when we take exp.  It is not in the C++ code,
    % at least as of 9/2013, because the problems we were running there didn't
    % need it, but it would be good to add there just in case.
    logq = logq - max(logq);

    sumq = sum(exp(logq(in_contention))); % sum of the q values, for those in contention
    tmp = logq;
    tmp(logq == -Inf) = Inf; % make it so that the ones out of contention can't be minimum.
    [worst_logq worst_x] = min(tmp); % worst of the in-contention logq values
end
