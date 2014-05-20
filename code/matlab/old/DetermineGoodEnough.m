% DetermineGoodEnough:  Figure out the set of good-enough alternatives using exhaustive simulation
% Inputs:
% 	fn, fn_runlength, fn_other -- function handle to the function to be optimized, along with its
% 		runlength, and any other special state, in the format specified by simopt.org
% 	alts -- a matrix, where each row contains an alternative (specified as a vector).
% 	starting_seed -- the index of the random number stream to start with.  The
% 		streams used will be starting_seed, starting_seed+1, starting_seed+2, etc.
% 	exhaustive_n0 -- the number of samples to take from each alternative
% 	delta -- the indifference-zone parameter
% Outputs:
% 	good is a vector giving, for each alternative, whether it is estimated to be in the "good enough" set or not.
% 	z_scores is a vector giving an approximate z-score for the comparison
% 		of each alternative with the best minus delta.  Set exhaustive_n0 big
% 		enough to make these all big.
% 	nsamples is the number of samples taken overall (which is the number of random number streams used).
function [good, z_scores, nsamples] = DetermineGoodEnough(fn, fn_runlength, fn_other, alts, starting_seed, exhaustive_n0, delta)

% perform exhaustive simulation
[est_mean,est_var,stderr,nsamples] = Exhaustive(fn, runlength, other, StartingSol, starting_seed, exhaustive_n0);

% Figure out, if the estimates are correct, which alternatives would consitute good selection.
[best_val, best_alt] = max(est_mean);
threshold = best_val - delta;
good = est_mean >= threshold;

% Calculate approximate z-scores.
% This method is really simple, and ignores the multiple testing aspect, and the selection aspect.
stderr_for_comparison = sqrt(stderr(best_alt)^2 + stderr.^2);
stderr_for_comparison(best_alt) = NaN;
z_scores = abs(est_mean - threshold) ./ stderr_for_comparison; 
