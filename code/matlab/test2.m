% This script runs KNUNK on a problem from the simopt library
k = 3;
Pstar = 0.8;
delta = 1;

structure = @sSContStructure;
fn = @sSCont;
fn_runlength = 1050;
fn_other = []; % this is not used by this simopt problem

% Get some starting solutions from the simopt structure function.  All other
% return variables are returned.
[minmax d m VarNature VarBds FnGradAvail NumConstraintGradAvail alts budget ObjBd OptimalSol] = structure(k,1);

starting_seed = 1;

% Use exhaustive simulation to figure out which alternatives are in the good-selection set.
% exhaustive_n0 = 100;
% [good, z_scores, nsamples] = DetermineGoodEnough(fn, runlength, other, StartingSol, starting_seed, exhaustive_n0, delta);
good = [0 1 0];

% Run KNUNK
KNUNK(fn, fn_runlength, fn_other, alts, Pstar, delta, 1, 10);
