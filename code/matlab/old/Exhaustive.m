% Exhaustive --- performs exhaustive simulation to estimate the mean and variance of each alternative.
%
% Inputs:
% fn, fn_runlength, fn_other -- function handle to the function to be optimized, along with its
% 	runlength, and any other special state, in the format specified by simopt.org
% alts -- a matrix, where each row contains an alternative (specified as a vector).
% starting_seed -- the index of the random number stream to start with.  The
% 	streams used will be starting_seed, starting_seed+1, starting_seed+2, etc.
% n0 -- the number of samples to take from each alternative
% Outputs:
% est_mean is a vector giving, for each alternative, an estimate of the true sampling mean.
% est_var is a vector giving, for each alternative, an estimate of the true sampling variance.
% stderr is sqrt(est_var/n0), the standard error of our estimate of the mean.
% nsamples is the number of samples taken overall (which is the number of random number streams used).
function [est_mean, est_var, stderr, nsamples] = Exhaustive(fn, fn_runlength, fn_other, alts, starting_seed, n0)

% k is the number of alternatives. d is the dimension of vectors specifying an alternative.
[k,d] = size(alts); 
nsamples = 0;
est_mean = zeros(1,k); 
est_var = zeros(1,k);

for x=1:k
  y = zeros(1,n0);
  for n=1:n0
	y(n) = fn(alts(x,:),fn_runlength,starting_seed + nsamples,fn_other);
	nsamples = nsamples+1;
  end
  est_mean(x) = mean(y);
  est_var(x) = var(y);
end
stderr = sqrt(est_var/n0);
