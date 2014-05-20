% Run an algorithm (BIZUNK or KNUNK) on a problem instance, and save the result
% to a file.

% Inputs:
% alg -- function handle to either BIZUNK or KNUNK
% problem_file --- filename of the problem to run, such as sSCont.mat.
% 		Contains fn, fn_runlength, fn_other, and alts.
% k --- number of alternatives.  Take only the first k alternatives from the alts variable.
% seed_start, seed_skip -- controls the index of the random number stream to start with.  The
% 	streams used will be seed_start, seed_start+seed_skip, seed_start+2*seed_skip, etc.
% Outputs:
%	xstar, nsamples, nstages --- the selection decision, number of samples
%		taken, and number of stages of sampling.  These are also saved to outfile.

function [xstar, nsamples, nstages] = RunAlgOnce(alg, problem_file, k, seed_start, seed_skip)

% loads fn, fn_runlength, fn_other, alts, est_mean, stderr, Pstar, delta, and some other stuff we don't use.
load(problem_file); 

% Runs the algorithm, and collects the selection decision, number of samples, and number of stages
[xstar, nsamples, nstages] = alg(fn, fn_runlength, fn_other, alts(1:k,:), Pstar, delta, seed_start, seek_skip);

outfile = sprintf('run_tmp/%s_%s_%d_%g_%g_%d_%d', problem_file, alg, k, Pstar, delta, seed_start);

save(outfile, 'xstar', 'nsamples', 'nstages', 'seed_start', 'Pstar', 'delta');
