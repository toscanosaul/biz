% Collect and collate results from running either BIZ or KN on a problem, for a specified value of k.
% [est_Nk, stderr_Nk, est_PGS, stderr_PGS] = Oct13_Collect(alg, problem, k, max_seed)
% 
% for example, Oct13_Collect('BIZ', 'SC', 8, 100) would check the results of
% BIZ on the SC problem, for k=8, assuming that seeds from 1 to 100 had been
% run.
%
% Inputs:
%	alg --- either 'KN' or 'BIZ'
%	problem --- the problem to solve.  Should be a string such that there is a file called problem.mat containing the problem.
% 	k --- number of alternatives.  Take only the first k alternatives from the alts variable in the loaded file.
% 	max_seed -- Data will be taken for seeds 1 through max_seed, skipping over files that don't exist.

function [est_Nk, stderr_Nk, est_PGS, stderr_PGS] = Oct13_Collect(alg, problem, k, max_seed)
problem_file = sprintf('%s.mat',problem);
load(problem_file); % loads est_mean, stderr, Pstar, delta and some other stuff we don't use.
seed_skip = 1000;
[good, z_scores] = DetermineGoodEnough(est_mean(1:k),stderr(1:k),delta); % only take the first k
disp(sprintf('Min z score is %g', min(z_scores)));
nsamples = zeros(1,max_seed);
ngood = 0; % number of good selections
nruns = 0; % overall number of files that we have
for seed=1:max_seed
	infile = sprintf('Oct13/%s_%s_%d_%d.mat', alg, problem, k, seed);
	if exist(infile, 'file') == 2 
		nruns = nruns + 1;
		% loads xstar, nsamples, nstages, seed_start, seed_skip, Pstar, delta, k
		s=load(infile); 
		nsamples(nruns) = s.nsamples;
		ngood = ngood + good(s.xstar);
	else 
		disp(sprintf('Missing %s %s k=%d seed=%d', alg, problem, k, seed));
	end
end
nsamples = nsamples(1:nruns);
est_Nk = mean(nsamples)/k;
stderr_Nk = sqrt(var(nsamples)/nruns)/k;
est_PGS = ngood / nruns;
stderr_PGS = sqrt(est_PGS * (1-est_PGS) / nruns);
disp(sprintf('%s k=%d E[N]/k=%g+/-%g;  PGS=%g +/- %g; %d runs', alg, k, est_Nk, stderr_Nk, est_PGS, stderr_PGS, nruns));
