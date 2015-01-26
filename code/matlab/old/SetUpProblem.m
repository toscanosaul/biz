% This script creates a random problem instance of size k, and then saves the
% various expensive-to-compute problem parameters to a file.  A runlength of
% 100 is fixed.
%
function SetUpProblem(k, exhaustive_n0)

structure = @sSContStructure;
fn = @sSCont;
runlength = 100;
other = []; % this is not used by this simopt problem

% Get some starting solutions from the simopt structure function.  All other
% return variables are returned.
[minmax d m VarNature VarBds FnGradAvail NumConstraintGradAvail alts budget ObjBd OptimalSol] = structure(k,1);

% perform exhaustive simulation, which is needed to figure out which alternatives are good enough for a given delta.
starting_seed = 1;
[est_mean,est_var,stderr,nsamples] = Exhaustive(fn, runlength, other, alts, starting_seed, exhaustive_n0);

filename = sprintf('Problem_k%04d_n%04d.mat',k,exhaustive_n0);
save(filename, 'est_mean','est_var','stderr','nsamples','alts')
