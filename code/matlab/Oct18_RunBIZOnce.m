% Run BIZUNK on a problem, and save the result to a file.

% Inputs:
%	problem --- the problem to solve.  Should be a string such that there is a file called problem.mat containing the problem.
% 	k --- number of alternatives.  Take only the first k alternatives from the alts variable in the loaded file.
% 	seed_start -- controls the index of the random number stream to start with.  The
% 		streams used will be seed_start, seed_start+seed_skip, seed_start+2*seed_skip, etc.
% Outputs:
%	xstar, nsamples, nstages --- the selection decision, number of samples
%		taken, and number of stages of sampling.  These are also saved to file.

function [xstar, nsamples, nstages] = Oct18_RunBIZOnce(problem, k, seed_start)
problem_file = sprintf('%s.mat',problem);
load(problem_file); % loads fn, fn_runlength, fn_other, alts, Pstar, delta, and some other stuff we don't use.
seed_skip = 1000;
Pstar = 0.90; % alter Pstar and delta
delta = 1;
[xstar, nsamples, nstages] = BIZUNK(fn, fn_runlength, fn_other, alts(1:k,:), Pstar, delta, seed_start, seed_skip);
outfile = sprintf('Oct18/BIZ_%s_%d_%d.mat', problem, k, seed_start);
save(outfile, 'xstar', 'nsamples', 'nstages', 'seed_start', 'seed_skip', 'Pstar', 'delta', 'k');
