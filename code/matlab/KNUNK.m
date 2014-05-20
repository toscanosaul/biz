% KNUNK: run the KN algorithm on a problem instance.
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


function [xstar, nsamples, nstages] = KNUNK(fn, fn_runlength, fn_other, alts, Pstar, delta, seed_start, seed_skip, n0)

if (nargin < 9)
  n0 = 30;
end

% k is the number of alternatives. d is the dimension of vectors specifying an alternative.
[k,d] = size(alts); 

if (delta<=0)
  error('delta must be strictly positive');
end

% If Pstar < 1/k, then the randomized policy that does no measurement is
% acceptible.  We do not treat this case because it isn't particularly
% interesting.
if (Pstar <= 1/k || Pstar >= 1)
  error('Pstar must be strictly between 1/k and 1');
end

nSamples = 0; % total number of samples.
nStages = 0; % number of rounds

sum = zeros(1,k);
varhat = zeros(1,k);

% Constants
alpha = 1-Pstar;
% To handle known variance, change eta and h2 to:
% eta = log((k-1)/(2.0*alpha));
% h2 = 2*eta;
tmp=(2*alpha/(k-1))^(-2/(n0-1));
eta = (tmp-1)/2;
h2 = 2*eta*(n0-1);
c1 = h2/(delta^2);

disp(sprintf('n0=%d eta=%f h2=%f c1=%f', n0,eta,h2,c1));

nsamples = 0; % number of samples taken
nstages = 0; % number of stages of sampling
 
% Run a first stage
nstages = nstages + n0;
  for x=1:k
    % mean and M2 are for calculating the sample variance.
    % The algorithm for updating the mean and M2 came from Wikipedia,
    % http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance 
    % who cites Knuth, and Knuth in turn apparently cites Welford.
    % The sample variance is given by M2 / (ret.nSamples - 1);
    mean = 0; % current sample mean.
    M2 = 0; % sum of the square differences from the current sample mean.
    for nstages=1:n0
	z = fn(alts(x,:),fn_runlength,seed_start + nsamples*seed_skip,fn_other);
	nsamples = nsamples + 1;
	sum(x) = sum(x) + z;
	tmp = z - mean;
	mean = mean + (tmp / nstages); % nstages is the number of samples taken from this alt.
	M2 = M2 + tmp*(z - mean);
    end
    varhat(x) = M2 / (n0-1);
    disp(sprintf('varhat(%d)=%f', x, varhat(x)));
  end

  % Sequential Screening
  in = ones(1,k); % flags that are set when we are still simulating
  nIn = k; % number of flags that are turned on
  lastIn = k; % index of the alternative in contention with the largest index.  

  r = n0;
  while(1)
    nstages = nstages + 1;

    % Figure out which x is largest of those in the continuation set.
    best = -1;
    for x=1:lastIn
      if (in(x) && (best == -1 || sum(x)>sum(best)))
	  best = x;
      end
    end

    % Iterate through the alternatives still in the consideration set, and
    % test each of them for removal.
    for x=1:lastIn
      disp(sprintf('in(%d)=%d sum(%d)=%f nIn=%d lastIn=%d', x, in(x), x, sum(x), nIn, lastIn));
      % If the x isn't in the continuation set, we don't test it.
      % If x has the largest mean, we can't remove it.
      if (in(x)==0 || x==best) 
	      continue;
      end

      % Calculate the constant w.  It depends on S_{il}^2, which is the variance
      % of the difference between the best alternative, and the current
      % alternative.  We work with the sum of the observations, rather than
      % their mean, which means that we multiply the w constant in Kim &
      % Nelson 2006 by nstages.
      Sil2 = varhat(best) + varhat(x);
      w = max(0,(c1*Sil2 - r)*delta/2.0);

      % Remove the alternative
      disp(sprintf('x=%d sum(x)=%f sum(best)-w=%f', x, sum(x), sum(best)-w));
      if (sum(x) < sum(best)-w)
	in(x) = 0;
	nIn = nIn-1;
      end
      
    end % done testing for removal

    if (nIn == 1) % done
      break;
    end

    % sample from all the alternatives in contention
    r = r+1;
    for x=1:lastIn
      if (in(x)==0)
	      continue;
      end

      z = fn(alts(x,:),fn_runlength,seed_start + nsamples*seed_skip,fn_other);
      sum(x) = sum(x) + z;
      nsamples = nsamples + 1;
    end

    % Figure out if we can decrease the value of the largest alternative that
    % is in contention.  This is optional for functionality, and just improves
    % the speed.
    while(in(lastIn)==0)  % while the last alternative is out of contention
      lastIn = lastIn-1;
    end
    assert(lastIn>0);
  end

% we have exited the loop.
xstar = best;
disp(sprintf('xstar=%d nsamples=%d', xstar, nsamples));
