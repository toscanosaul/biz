% Run an algorithm (BIZUNK or KNUNK) on a problem instance, and collect the
% probability of good selection, expected sample size, and expected number of
% stages.

% Inputs:
% alg -- function handle to either BIZUNK or KNUNK
% fn, fn_runlength, fn_other -- function handle to the function to be optimized, along with its
% 	runlength, and any other special state, in the format specified by simopt.org
% alts -- a matrix, where each row contains an alternative (specified as a vector).
% Pstar, delta -- indifference-zone parameters to use
% starting_seed -- the index of the random number stream to start with.  The
% 	streams used will be starting_seed, starting_seed+1, starting_seed+2, etc.
% good -- binary vector containing, for each alternative, whether we should consider
% 	it a good selection or not, i.e., whether or not its true mean is within
% 	delta of the best.
% nruns -- number of independent replications of the algorithm to do
% Outputs:
% 	est_PGS, std_PGS  -- Estimate and corresponding standard error of the probability of good selection
% 	est_N, std_N  -- Estimate and corresponding standard error of the probability of good selection

function [est_PGS, std_PGS, est_N, std_N] = RunAlg(alg, fn, fn_runlength, fn_other, alts, Pstar, delta, starting_seed, good, nruns)
ngood = 0;
seed = starting_seed;
N_vec = zeros(1,nruns);
for n=1:nruns
	[xstar, nsamples, nstages] = alg(fn, fn_runlength, fn_other, alts, Pstar, delta, seed);
	N_vec(n) = nsamples;
	seed = seed + nsamples;
	ngood = ngood + good(xstar);
	disp(sprintf('Run %d good=%d N=%d\n', n, good(xstar), nsamples));
end
% disp(sprintf('%d out of %d were good selections\n', ngood, nruns))
est_PGS = ngood / nruns;
std_PGS = sqrt(est_PGS * (1-est_PGS) / nruns);
est_N = mean(N_vec);
std_N = sqrt(var(N_vec)/nruns);
