% This script reads in all of the files created by SetUpProblem2.sh in
% sSCont_SetUpProblem/, and processes them into a single file.

k = 10000; % number of alternatives
Pstar = 0.8;
delta = 1;
structure = @sSContStructure;
fn = @sSCont;
fn_runlength = 1050;
fn_other = []; % this is not used by this simopt problem
load('sSCont.mat'); % should have alts, and alts_seed 

est_mean = zeros(1,k);
est_var = zeros(1,k);
nruns = zeros(1,k);
exhaustive_seed = zeros(1,k);
for x=1:k
  filename = sprintf('/fs/home/pf98/svn/biz/code/matlab/sSCont_SetUpProblem/%d.mat',x);
  disp(filename);
  % loads est_mean, est_var, nruns, starting_seed, fn_runlength for this run.
  % the nruns, starting_seed, fn_runlength should all be the same.  We save nruns to be careful, 
  % the est_mean and est_var are the estimated mean and variance of the simulation output for this alternative.
  s = load(filename);  
  est_mean(x) = s.est_mean;
  est_var(x) = s.est_var;
  nruns(x) = s.nruns(1);
  exhaustive_seed(x) = s.starting_seed;
  if (fn_runlength ~= s.fn_runlength)
	warning(sprintf('fn_runlength in %s was %d rather than %d\n', filename, s.fn_runlength, fn_runlenth)); 
  end
end
stderr = sqrt(est_var ./ nruns);

save 'sSCont.mat' alts alts_seed est_mean est_var nruns exhaustive_seed stderr fn fn_runlength fn_other Pstar delta
