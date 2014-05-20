k=1000; % number of alternatives
delta=1; % IZ parameter, and parameter of slippage configuration
Pstar = 0.9;
sigma = 10; % sampling sdev.

% alts is a matrix, where each row corresponds to an alternative.  
% the first column is the alternative's mean, and the second column is its standard deviation.
alts = zeros(k,2); 
alts(1,1) = delta; % the first alternative has mean delta, and the rest have mean 0. 
alts(:,2) = sigma; % homogeneous sampling variance

% this is what you would get out of exhaustive simulation, if you took infinitely many samples
est_mean = alts(:,1)';
est_var = (alts(:,2).^2)';
nruns = ones(1,k)*Inf;
stderr = zeros(1,k);

% For normal sampling
fn = @Normal;
fn_runlength = 1;
fn_other = [];

save 'SC.mat' alts est_mean est_var nruns stderr fn fn_runlength fn_other delta Pstar
