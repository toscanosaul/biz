% BIZUNK: run the BIZ algorithm for unknown and heterogeneous sampling variances on a problem instance.
%
% Inputs:
% fn, fn_runlength, fn_other -- function handle to the function to be optimized, along with its
% 	runlength, and any other special state, in the format specified by simopt.org
% alts -- a matrix, where each row contains an alternative (specified as a vector).
% Pstar, delta -- indifference-zone parameters to use
% seed_start, seed_skip -- tells which random number streams to use.  The ones
% 	used are seed_start, seed_start + seek_skip, seed_start + seed_skip*2, etc.
% Outputs:
% xstar -- the alternative selected
% nsamples -- the number of samples taken overall
% nstages -- the number of stages of sampling
function [xstar, nsamples, nstages] = BIZUNK(fn, fn_runlength, fn_other, alts, Pstar, delta, seed_start, seed_skip, n0)

if (nargin < 9)
  n0 = 30;
end
batchsize = 1;

% k is the number of alternatives. d is the dimension of vectors specifying an alternative.
[k,d] = size(alts); 

if (delta<=0)
  error('delta must be strictly positive');
end
if (Pstar <= 1/k || Pstar >= 1)
  error('Pstar must be strictly between 1/k and 1');
end
logElimThresh = log1p(-Pstar^(1/(k-1)));
  %double logElimThresh = log1p(-pow(problem.pstar,1.0/(problem.k-1)));
logpstar = log(Pstar); % cache the log of Pstar

nsamples = 0; % number of samples taken
nstages = 0; % number of stages of sampling

% Create four vectors.  
% n[x] contains the number of samples taken from alternative x.  
% avg[x] contains the mean of all the observations from alternative x.  
% M2[x] contains the sum of the square differences from the current sample mean.
% M2[x] = \sum_{i=1}^n (y_i - \ybar_n)^2, where y_i are the samples from alternative x.
% The algorithm for updating the mean and M2 came from Wikipedia,
% http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance 
% who cites Knuth, and Knuth in turn apparently cites Welford.
% The sample variance is given by M2[x] / n[x];
% logq[x] is the log of q_{tx}(A).  
% If logq[x] is -INFINITY then this indicates that the alternative has been eliminated.
n = zeros(1,k); 
avg = zeros(1,k); 
M2 = zeros(1,k); 
logq = zeros(1,k); 

% Take n0 samples from each alternative and update our statistics.
for x=1:k
  while (n(x)<n0)
	y = fn(alts(x,:),fn_runlength,seed_start + nsamples*seed_skip,fn_other);
	n(x)=n(x)+1;
	nsamples = nsamples+1;
	tmp = y - avg(x);
	avg(x) = avg(x) + (tmp / n(x));
	M2(x) = M2(x) + tmp*(y - avg(x));
   end
end
[logq sumq worst_logq worst_x] = BIZUNK_UpdateLogQ(delta, n, avg, M2, logq);

while(1) % main sampling loop
    % At this point, we have the following: 
    % n, avg, M2, logq, sumq worst_logq worst_x.  

  disp(sprintf('nsamples=%d num_in_contention=%d max(q)=%.2f min(q)=%.2f ElimThresh=%.2f', nsamples, sum(logq>-Inf), exp(max(logq))/sumq, exp(worst_logq)/sumq, exp(logElimThresh)));

  %disp('Displaying n, mean, variance, q');
  %disp(n)
  %disp(avg)
  %disp(M2 ./ n); % variance
  %disp(exp(logq) / sumq);
 
  % Check whether we have exceeded the threshold and can stop.
  [best_logq best_x] = max(logq);
  if (best_logq - log(sumq) >= logpstar)
    xstar = best_x; return;  % we choose alternative x. 
  end

  % This loop eliminates the worst alternative on each pass through
  while(worst_logq - log(sumq) <= logElimThresh) % if this is true, eliminate the worst alternative

      % Eliminate the worst alternative and recompute logq.
      logq(worst_x) = -Inf; % eliminate alternative argmin
      worstq = exp(worst_logq) / sumq; % this is the normalized q of the worst alternative
      %disp(sprintf('Elimination: argmin=%d q[argmin]=%.3f, ElimThresh=%.3f, current pstar=%.3f\n', worst_x, worstq, exp(logElimThresh), exp(logpstar)))
      % The new target probability pstar increases by a factor of 1/(1-worstq), where worstq is the
      % probability of the alternative just eliminated, so the log of pstar becomes 
      % logpstar - log(1-worstq) = logpstar - log1p(-worstq)
      logpstar = logpstar - log1p(-worstq);
      %assert(logpstar<0);
      [logq sumq worst_logq worst_x] = BIZUNK_UpdateLogQ(delta, n, avg, M2, logq);

      %disp('Displaying n, mean, variance, q, worst_q, worst_x');
      %disp(n)
      %disp(avg)
      %disp(M2 ./ n); % variance
      %disp(exp(logq) / sumq);
      %disp(exp(worst_logq)/sumq);
      %disp(worst_x);

  end % End elimination while loop


  %
  % Update n[x] for each x and take these additional samples.  
  %

  nstages = nstages+1;

  % First, we calculate z = \argmin_x n[x] / var[x], which is the
  % alternative that has the least samples, according to the timescale proportional to the variance.
  % Here, var[x] = M2[x]/n[x], so n[x]/var[x]=n[x]^2/M2[x].
  % We take the minimum only over those alternatives that have not been eliminated.
  tmp = n.^2./M2;
  tmp(logq == -Inf) = Inf; % make it so that the ones out of contention can't be minimum.
  [tmp2 z] = min(tmp);

  % Update m to be (n[z]+batchsize)/var[z].
  % m is the new number of samples for alternative z, in the timescale
  % proportional to the variance. 
  var = M2(z) / n(z);
  m = (n(z) + batchsize) / var;

  % Now calculate n[x] and take the samples, maintaining logq.
  for x=1:k
    if (logq(x) == -Inf) % if x has been eliminated
       continue;
    end
    var = M2(x) / n(x); % this is the sample variance 
    new_n = ceil(var * m);  % This is n_{t+1,x}.
    %disp(sprintf('x=%d n(x)=%d new_n=%d', x, n(x), new_n));
    while (n(x) < new_n)
	y = fn(alts(x,:),fn_runlength,seed_start + nsamples*seed_skip,fn_other);
	%disp(sprintf('y=%g nsamples=%d', y, nsamples))
	n(x)=n(x)+1;
	nsamples = nsamples+1;
	tmp = y - avg(x);
	avg(x) = avg(x) + (tmp / n(x));
	M2(x) = M2(x) + tmp*(y - avg(x));
    end
  end
  [logq sumq worst_logq worst_x] = BIZUNK_UpdateLogQ(delta, n, avg, M2, logq);

end % end sampling loop

end
