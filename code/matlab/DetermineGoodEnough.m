% DetermineGoodEnough:  Figure out the set of good-enough alternatives using exhaustive simulation
% Inputs:
% 	est_mean, stderr: a vector of estimated means, together with their standard errors, for the alternatives
% 	delta -- the indifference-zone parameter
% Outputs:
% 	good is a vector giving, for each alternative, whether it is estimated to be in the "good enough" set or not.
% 	z_scores is a vector giving an approximate z-score for the comparison
% 		of each alternative with the best minus delta.  Take enough samples
% 		to make stderr small enough to make these all big.
function [good, z_scores] = DetermineGoodEnough(est_mean, stderr, delta)

% Figure out, if the estimates are correct, which alternatives would consitute good selection.
[best_val, best_alt] = max(est_mean);
threshold = best_val - delta;
good = est_mean > threshold;

% Calculate approximate z-scores.
% This method is really simple, and ignores the multiple testing aspect, and the selection aspect.
stderr_for_comparison = sqrt(stderr(best_alt)^2 + stderr.^2);
stderr_for_comparison(best_alt) = NaN;
z_scores = abs(est_mean - threshold) ./ stderr_for_comparison; 
