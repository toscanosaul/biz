% This script creates a random problem instance of size 10000, and saves the
% alternatives to a file.
k=10000;
alts_seed=1;

structure = @sSContStructure;
fn = @sSCont;

% Get some starting solutions from the simopt structure function.  All other
% return variables are returned.
[minmax d m VarNature VarBds FnGradAvail NumConstraintGradAvail alts budget ObjBd OptimalSol] = structure(k,alts_seed);
save 'sSCont.mat' alts alts_seed
