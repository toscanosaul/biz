% This script takes the alternatives created by sSCont_SetUpProblem1, stored in
% sSCont.mat, and runs exhaustive simulation on alternatives from start_x to end_x (inclusive),
% storing each result in a separate file, sSCont_SetUpProblem/x.mat
% If only one argument is passed, simulations for just that passed x will be run.
function sSCont_SetUpProblem2(start_x, end_x)
if (nargin==1) 
	end_x = start_x;
end
structure = @sSContStructure;
fn = @sSCont;
fn_runlength = 1050; % length to run the sSCont simulation
fn_other = []; % this is not used by this simopt problem
nruns = 10^4; % number of samples to use for exhaustive simulation
starting_seed = 1; % seed at which to start the exhaustive simulation

disp(sprintf('sSCont_SetUpProblem2(start_x=%d, end_x=%d)\n',start_x,end_x))

load 'sSCont.mat' % loads a variable called alts, which contains the alternatives.

% k is the number of alternatives. d is the dimension of vectors specifying an alternative.
[k,d] = size(alts); 

for x=start_x:end_x
  y = zeros(1,nruns);
  for n=1:nruns
    y(n) = fn(alts(x,:),fn_runlength,starting_seed + n - 1,fn_other);
  end
  est_mean = mean(y);
  est_var = var(y);

  filename = sprintf('/fs/home/pf98/svn/biz/code/matlab/sSCont_SetUpProblem/%d.mat',x);
  save(filename, 'est_mean','est_var','nruns','starting_seed','fn_runlength')
end
