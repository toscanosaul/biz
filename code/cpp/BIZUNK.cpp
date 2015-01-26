/*
 * The BIZ policy with unknown and possibly heterogeneous sampling variances.
 */

#include "BIZ.h"
#include <strings.h>

// #define DEBUG

/*
 * Structure for storing statistics of a logq vector.
 */
typedef struct logqstats {
  double sumq;
  double best_logq;
  int best_x;
  double worst_logq;
  int worst_x;
} logqstats_t;

logqstats_t UpdateLogQ_Unknown(int k, double delta, unsigned int *n, double *mean, double *M2, double *logq);

SampleOnceRet_t SampleOnceBIZUNK1(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma[], double logElimThresh, int n0, int batchsize);
SampleOnceRet_t SampleOnceBIZUNK2(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma[], double logElimThresh, int n0, int batchsize);
SampleOnceRet_t SampleOnceBIZUNK3(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma[], double logElimThresh, int n0, int batchsize);
SampleOnceRet_t SampleOnceBIZUNK4(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma[], double logElimThresh, int n0, int batchsize);

/* This is the interface to this code called by outside code, as implemented in BIZ.h. */
SampleOnceRet_t BIZUNK(StochasticLib2 &sto, problem_t problem, algArgs_t args) {
  double logElimThresh = log1p(-pow(problem.pstar,1.0/(problem.k-1)));
  int n0 = *(int *)(args.args);
  int batchsize = 1;
  return SampleOnceBIZUNK4(sto, problem.k, problem.pstar, problem.delta, problem.theta, problem.sigma, logElimThresh, n0, batchsize);
}



/* 
 * The version of BIZUNK that I implemented first.  
 */
SampleOnceRet_t SampleOnceBIZUNK1(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma[], double logElimThresh, int n0, int batchsize) {
  int x; // generic counter

  assert(delta>0);
  assert(k>0);
  for (x=0; x<k; x++)
    assert(sigma[x]>=0);
  assert(k==1 || 1-exp(logElimThresh) >= pow(pstar,1.0/(k-1)));
  assert(batchsize>=1);

  SampleOnceRet_t ret;
  ret.nSamplesPerAlt = 0;
  ret.nSamples = 0;
  ret.nStages = 0;

  // If this condition is not met, then the randomized policy that does no
  // measurement is acceptable.  We do not treat this case because it isn't
  // particularly interesting.
  assert(pstar > (double)1/k);

  // Create five vectors.  
  // n[x] contains the number of samples taken from alternative x.  
  // mean[x] contains the mean of all the observations from alternative x.  
  // M2[x] contains the sum of the square differences from the current sample mean.
  // M2[x] = \sum_{i=1}^n (y_i - \ybar_n)^2, where y_i are the samples from alternative x.
  // The algorithm for updating the mean and M2 came from Wikipedia,
  // http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance 
  // who cites Knuth, and Knuth in turn apparently cites Welford.
  // The sample variance is given by M2[x] / n[x];
  // logq[x] is the log of q_{tx}(A).  
  // If logq[x] is -INFINITY then this indicates that the alternative has been eliminated.
  // prev_var[x] contains the previous value of the variance.  
  unsigned int n[k];
  double mean[k], M2[k], logq[k], prev_var[k];
  for (x=0; x<k; x++) {
    n[x] = 0;
    mean[x] = 0;
    M2[x] = 0;
    prev_var[x] = 0;
    logq[x] = 0;
  }

  double logpstar = log(pstar); // Precompute the log of pstar.

  // Take n0 samples from each alternative and update our statistics.
  for (x=0; x<k; x++) {
    while (n[x] < n0) {
      n[x]++;
      ret.nSamples++; 
      double y = theta[x] + sto.Normal(0,sigma[x]);
      double tmp = y - mean[x];
      mean[x] += tmp / n[x];
      M2[x] += tmp*(y - mean[x]);
      // prev_var and logq are initialized below.
    }
  }


  int extra = 0; // On the first pass through, don't add extra samples.  See first use of the extra variable below.
  while(1) {
    // At this point, we have the following arrays:
    // mean, M2, n, prev_var, logq.
    // prev_var and logq are not initialized.

    ret.nStages++;

    // Update n[x] for each x and take these additional samples.  
    //
    // If we are on our first pass through (i.e, all the n[x] are equal to n0),
    // we only do enough to bring everything on par.  If we are beyond this, we
    // do enough to add at least one sample.  This is implemented with the
    // variable "extra".
    //
    // First, we calculate prev_var[x] and m = \max_x n[x] / prev_var[x];
    double m = -1;
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      prev_var[x] = M2[x] / n[x]; // this is the variance before we take the new samples below.
      if (m == -1 || m < (n[x] + extra) / prev_var[x])
	m = (n[x] + extra) / prev_var[x];
    }
    // Now calculate n[x], take the samples, and calculate logq[x].
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      unsigned int new_n = ceil(prev_var[x] * m);  // This is n_{t+1,x}.
      while (n[x] < new_n) {
	n[x]++;
	ret.nSamples++;
	double y = theta[x] + sto.Normal(0,sigma[x]);
	double tmp = y - mean[x];
	mean[x] += tmp / n[x];
	M2[x] += tmp*(y - mean[x]);
      }
      // We do not update prev_var[x].  It is still using the previous value of the variance.
      logq[x] = delta * n[x] * mean[x] / prev_var[x];
      // PF: this should be more careful about numerical precision.  If the
      // mean of many of the alternatives is large, we could get an overflow.
      // This should subtract from logq the maximum value of logq across all x's.
    }
    extra = batchsize; // the next time we come through, add batchsize instead of 0.
    
    // Sum up the q's into sumq and find the worst alternative, putting results
    // in worst_x and worst_logq.
    double sumq = 0;
    int worst_x = -1;
    double worst_logq = 0;
    for (x=0; x<k; x++) {
      if (logq[x]==-INFINITY) // if x has been eliminated
	continue;
      if (worst_x == -1 || logq[x] < worst_logq) {
	worst_x = x;
	worst_logq = logq[x];
      }
      sumq += exp(logq[x]);
    }

#ifdef DEBUG
      printf("n = [");
      for (x=0; x<k; x++)
	printf("%d ", n[x]);
      printf("]\n");
      printf("q = [");
      for (x=0; x<k; x++)
	printf("%.3f ", logq[x] == -INFINITY ? 0 : exp(logq[x])/sumq);
      printf("]\n");
      printf("prev_var = [");
      for (x=0; x<k; x++)
	printf("%.3f ", prev_var[x]);
      printf("]\n");

#endif

    // The following loop eliminates one alternative on each pass through
    // It assumes that sumq, worst_x, and worst_logq have all been computed at the beginning.
    // Here, worst_logq = logq[worst_x], and sumq is the sum of exp(logq[x]) over all alternatives in contention.
    // Thus, worst_logq - logq(sumq) is the log of the normalized q for the worst alternative.
    
    while(worst_logq - log(sumq) <= logElimThresh) { // if this is true, eliminate the worst alternative

      // Eliminate the worst alternative and recompute sumq and logpstar
      logq[worst_x] = -INFINITY; // eliminate alternative argmin
      double worstq = exp(worst_logq) / sumq; // this is the normalized q of the worst alternative
#ifdef DEBUG
      printf("Elimination: argmin=%d q[argmin]=%.3f, ElimThresh=%.3f, current pstar=%.3f\n", worst_x, worstq, exp(logElimThresh), exp(logpstar));
#endif
      sumq -= exp(worst_logq); // maintain sumq as the sum of exp(logq[x]) over all x in contention.
      assert(sumq > 0);
      // The new target probability pstar increases by a factor of 1/(1-worstq), where worstq is the
      // probability of the alternative just eliminated, so the log of pstar becomes 
      // logpstar - log(1-worstq) = logpstar - log1p(-worstq)
      logpstar -= log1p(-worstq);
      assert(logpstar<0);

      // Update worst_x and worst_logq
      worst_x = -1;
      worst_logq = 0;
      for (x=0; x<k; x++) {
	if (logq[x]==-INFINITY) // if x has been eliminated
	  continue;
	if (worst_x ==-1 || logq[x]<worst_logq) {
	  worst_x  = x;
	  worst_logq = logq[x];
	}
      }

    } // End elimination while loop

    // Figure out the argmax over non-eliminated alternatives.
    int argmax = -1;
    double best_logq = 0;
    for (x=0; x<k; x++) {
      if (logq[x]==-INFINITY) // x has been eliminated
	continue;
      if (argmax==-1 || logq[x]>best_logq) {
	argmax = x;
	best_logq = logq[x];
      }
    }

    // Check whether we have exceeded the threshold and can stop.
    if (best_logq - log(sumq) >= logpstar) {
      // we choose alternative x. This is correct if x is 0, and incorrect
      // otherwise.
      // ret.correctSelection = (argmax == 0);
      ret.correctSelection = CorrectSelection(argmax,k,theta,delta);
      ret.nSamplesPerAlt = ret.nSamples / k;
#ifdef DEBUG
      if (ret.correctSelection) printf("correct selection\n");
      else printf("incorrect selection\n");
#endif
      return ret;
    }
  }
}



/* 
 * The second version of BIZUNK that I implemented.  It does not worry as much about keeping the number of samples proportional to the sampling variance.
 */
SampleOnceRet_t SampleOnceBIZUNK2(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma[], double logElimThresh, int n0, int batchsize) {
  int x; // generic counter

  assert(delta>0);
  assert(k>0);
  for (x=0; x<k; x++)
    assert(sigma[x]>=0);
  assert(k==1 || 1-exp(logElimThresh) >= pow(pstar,1.0/(k-1)));
  assert(batchsize>=1);

  SampleOnceRet_t ret;
  ret.nSamplesPerAlt = 0;
  ret.nSamples = 0;
  ret.nStages = 0;

  // If this condition is not met, then the randomized policy that does no
  // measurement is acceptable.  We do not treat this case because it isn't
  // particularly interesting.
  assert(pstar > (double)1/k);

  double logpstar = log(pstar); // Precompute the log of pstar.

  // Create four vectors.  
  // n[x] contains the number of samples taken from alternative x.  
  // mean[x] contains the mean of all the observations from alternative x.  
  // M2[x] contains the sum of the square differences from the current sample mean.
  // M2[x] = \sum_{i=1}^n (y_i - \ybar_n)^2, where y_i are the samples from alternative x.
  // The algorithm for updating the mean and M2 came from Wikipedia,
  // http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance 
  // who cites Knuth, and Knuth in turn apparently cites Welford.
  // The sample variance is given by M2[x] / n[x];
  // logq[x] is the log of q_{tx}(A).  
  // If logq[x] is -INFINITY then this indicates that the alternative has been eliminated.
  unsigned int n[k];
  double mean[k], M2[k], logq[k];
  for (x=0; x<k; x++) {
    n[x] = 0;
    mean[x] = 0;
    M2[x] = 0;
    logq[x] = 0;
  }

  // Take n0 samples from each alternative and update our statistics.
  for (x=0; x<k; x++) {
    while (n[x] < n0) {
      n[x]++;
      ret.nSamples++;
      double y = theta[x] + sto.Normal(0,sigma[x]);
      double tmp = y - mean[x];
      mean[x] += tmp / n[x];
      M2[x] += tmp*(y - mean[x]);
    }
    double var = M2[x] / n[x]; // this is the sample variance 
    logq[x] = delta * n[x] * mean[x] / var;
  }

  while(1) {
    // At this point, we have the following arrays:
    // mean, M2, n, logq.

    // Calculate sumq, best_logq, best_x, worst_logq, and worst_x.
    double sumq = 0;
    int worst_x = -1, best_x = -1;
    double worst_logq = 0, best_logq = 0;
    for (x=0; x<k; x++) {
      if (logq[x]==-INFINITY) // if x has been eliminated
	continue;
      sumq += exp(logq[x]);
      if (worst_x == -1 || logq[x] < worst_logq) {
	worst_x = x;
	worst_logq = logq[x];
      }
      if (best_x == -1 || logq[x] > best_logq) {
	best_x = x;
	best_logq = logq[x];
      }
    }
    
#ifdef DEBUG
      printf("q = [");
      for (x=0; x<k; x++)
	printf("%.3f ", logq[x] == -INFINITY ? 0 : exp(logq[x])/sumq);
      printf("]\n");
#endif

    // Check whether we have exceeded the threshold and can stop.
    if (best_logq - log(sumq) >= logpstar) {
      // we choose alternative x. This is correct if x is 0, and incorrect
      // otherwise.
      // ret.correctSelection = (best_x == 0);
      ret.correctSelection = CorrectSelection(best_x,k,theta,delta);
      ret.nSamplesPerAlt = ret.nSamples / k;
#ifdef DEBUG
      if (ret.correctSelection) printf("correct selection\n");
      else printf("incorrect selection\n");
#endif
      return ret;
    }


    // The following loop eliminates one alternative on each pass through
    // It assumes that sumq, worst_x, and worst_logq have all been computed at the beginning.
    // Here, worst_logq = logq[worst_x], and sumq is the sum of exp(logq[x]) over all alternatives in contention.
    // Thus, worst_logq - logq(sumq) is the log of the normalized q for the worst alternative.
    
    while(worst_logq - log(sumq) <= logElimThresh) { // if this is true, eliminate the worst alternative

      // Eliminate the worst alternative and recompute sumq and logpstar
      logq[worst_x] = -INFINITY; // eliminate alternative argmin
      double worstq = exp(worst_logq) / sumq; // this is the normalized q of the worst alternative
#ifdef DEBUG
      printf("Elimination: argmin=%d q[argmin]=%.3f, ElimThresh=%.3f, current pstar=%.3f\n", worst_x, worstq, exp(logElimThresh), exp(logpstar));
#endif
      sumq -= exp(worst_logq); // maintain sumq as the sum of exp(logq[x]) over all x in contention.
      assert(sumq > 0);
      // The new target probability pstar increases by a factor of 1/(1-worstq), where worstq is the
      // probability of the alternative just eliminated, so the log of pstar becomes 
      // logpstar - log(1-worstq) = logpstar - log1p(-worstq)
      logpstar -= log1p(-worstq);
      assert(logpstar<0);

      // Update worst_x and worst_logq
      worst_x = -1;
      worst_logq = 0;
      for (x=0; x<k; x++) {
	if (logq[x]==-INFINITY) // if x has been eliminated
	  continue;
	if (worst_x ==-1 || logq[x]<worst_logq) {
	  worst_x  = x;
	  worst_logq = logq[x];
	}
      }

    } // End elimination while loop


    //
    // Update n[x] for each x and take these additional samples.  
    //
  
    ret.nStages++;

    // First, we calculate m = \max_x n[x] / var;
    double m = -1;
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      double var = M2[x] / n[x];
      if (m == -1 || m < (n[x] + batchsize) / var)
	m = (n[x] + batchsize) / var;
    }

    // Now calculate n[x] and take the samples.
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      double var = M2[x] / n[x]; // this is the sample variance 
      unsigned int new_n = ceil(var * m);  // This is n_{t+1,x}.
      while (n[x] < new_n) {
	n[x]++;
	ret.nSamples++;
	double y = theta[x] + sto.Normal(0,sigma[x]);
	double tmp = y - mean[x];
	mean[x] += tmp / n[x];
	M2[x] += tmp*(y - mean[x]);
      }
      var = M2[x] / n[x]; // this is the sample variance 
      logq[x] = delta * n[x] * mean[x] / var;
    }
  }
}


/* 
 * The third version of BIZUNK that I implemented.  Like version 2, it does not
 * worry as much about keeping the number of samples proportional to the
 * sampling variance.  However, unlike version 2, its decisions are invariant
 * to shifting all of the sample means by a constant.
 */
SampleOnceRet_t SampleOnceBIZUNK3(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma[], double logElimThresh, int n0, int batchsize) {
  int x; // generic counter

  assert(delta>0);
  assert(k>0);
  for (x=0; x<k; x++)
    assert(sigma[x]>=0);
  assert(k==1 || 1-exp(logElimThresh) >= pow(pstar,1.0/(k-1)));
  assert(batchsize>=1);

  SampleOnceRet_t ret;
  ret.nSamplesPerAlt = 0;
  ret.nSamples = 0;
  ret.nStages = 0;

  // If this condition is not met, then the randomized policy that does no
  // measurement is acceptable.  We do not treat this case because it isn't
  // particularly interesting.
  assert(pstar > (double)1/k);

  double logpstar = log(pstar); // Precompute the log of pstar.

  // Create four vectors.  
  // n[x] contains the number of samples taken from alternative x.  
  // mean[x] contains the mean of all the observations from alternative x.  
  // M2[x] contains the sum of the square differences from the current sample mean.
  // M2[x] = \sum_{i=1}^n (y_i - \ybar_n)^2, where y_i are the samples from alternative x.
  // The algorithm for updating the mean and M2 came from Wikipedia,
  // http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance 
  // who cites Knuth, and Knuth in turn apparently cites Welford.
  // The sample variance is given by M2[x] / n[x];
  // logq[x] is the log of q_{tx}(A).  
  // If logq[x] is -INFINITY then this indicates that the alternative has been eliminated.
  unsigned int n[k];
  double mean[k], M2[k], logq[k];
  for (x=0; x<k; x++) {
    n[x] = 0;
    mean[x] = 0;
    M2[x] = 0;
    logq[x] = 0;
  }

  // Take n0 samples from each alternative and update our statistics.
  for (x=0; x<k; x++) {
    while (n[x] < n0) {
      n[x]++;
      ret.nSamples++;
      double y = theta[x] + sto.Normal(0,sigma[x]);
      double tmp = y - mean[x];
      mean[x] += tmp / n[x];
      M2[x] += tmp*(y - mean[x]);
    }
  }

  // update logq.
  double N = 0;
  double sumvar = 0;
  for (x=0; x<k; x++) {
    N += n[x];
    sumvar += M2[x] / n[x]; // sample variance of x.
  }
  for (x=0; x<k; x++)
    logq[x] = delta * mean[x] * N / sumvar;


  while(1) {
    // At this point, we have the following arrays:
    // mean, M2, n, logq.  

    // Calculate sumq, best_logq, best_x, worst_logq, and worst_x.
    double sumq = 0;
    int worst_x = -1, best_x = -1;
    double worst_logq = 0, best_logq = 0;
    for (x=0; x<k; x++) {
      if (logq[x]==-INFINITY) // if x has been eliminated
	continue;
      sumq += exp(logq[x]);
      if (worst_x == -1 || logq[x] < worst_logq) {
	worst_x = x;
	worst_logq = logq[x];
      }
      if (best_x == -1 || logq[x] > best_logq) {
	best_x = x;
	best_logq = logq[x];
      }
    }
    
#ifdef DEBUG
      printf("q = [");
      for (x=0; x<k; x++)
	printf("%.3f ", logq[x] == -INFINITY ? 0 : exp(logq[x])/sumq);
      printf("]\n");
#endif

    // Check whether we have exceeded the threshold and can stop.
    if (best_logq - log(sumq) >= logpstar) {
      // we choose alternative x. This is correct if x is 0, and incorrect
      // otherwise.
      // ret.correctSelection = (best_x == 0);
      ret.correctSelection = CorrectSelection(best_x,k,theta,delta);
      ret.nSamplesPerAlt = ret.nSamples / k;
#ifdef DEBUG
      if (ret.correctSelection) printf("correct selection\n");
      else printf("incorrect selection\n");
#endif
      return ret;
    }


    // The following loop eliminates one alternative on each pass through
    // It assumes that sumq, worst_x, and worst_logq have all been computed at the beginning.
    // Here, worst_logq = logq[worst_x], and sumq is the sum of exp(logq[x]) over all alternatives in contention.
    // Thus, worst_logq - logq(sumq) is the log of the normalized q for the worst alternative.
    
    while(worst_logq - log(sumq) <= logElimThresh) { // if this is true, eliminate the worst alternative

      // Eliminate the worst alternative and recompute sumq and logpstar
      logq[worst_x] = -INFINITY; // eliminate alternative argmin
      double worstq = exp(worst_logq) / sumq; // this is the normalized q of the worst alternative
#ifdef DEBUG
      printf("Elimination: argmin=%d q[argmin]=%.3f, ElimThresh=%.3f, current pstar=%.3f\n", worst_x, worstq, exp(logElimThresh), exp(logpstar));
#endif
      sumq -= exp(worst_logq); // maintain sumq as the sum of exp(logq[x]) over all x in contention.
      assert(sumq > 0);
      // The new target probability pstar increases by a factor of 1/(1-worstq), where worstq is the
      // probability of the alternative just eliminated, so the log of pstar becomes 
      // logpstar - log(1-worstq) = logpstar - log1p(-worstq)
      logpstar -= log1p(-worstq);
      assert(logpstar<0);

      // Update worst_x and worst_logq
      worst_x = -1;
      worst_logq = 0;
      for (x=0; x<k; x++) {
	if (logq[x]==-INFINITY) // if x has been eliminated
	  continue;
	if (worst_x ==-1 || logq[x]<worst_logq) {
	  worst_x  = x;
	  worst_logq = logq[x];
	}
      }

    } // End elimination while loop


    //
    // Update n[x] for each x and take these additional samples.  
    //
  
    ret.nStages++;

    // First, we calculate m = \max_x n[x] / var;
    double m = -1;
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      double var = M2[x] / n[x];
      if (m == -1 || m < (n[x] + batchsize) / var)
	m = (n[x] + batchsize) / var;
    }

    // Now calculate n[x] and take the samples.
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      double var = M2[x] / n[x]; // this is the sample variance 
      unsigned int new_n = ceil(var * m);  // This is n_{t+1,x}.
      while (n[x] < new_n) {
	n[x]++;
	ret.nSamples++;
	double y = theta[x] + sto.Normal(0,sigma[x]);
	double tmp = y - mean[x];
	mean[x] += tmp / n[x];
	M2[x] += tmp*(y - mean[x]);
      }
    }

    // update logq.
    double N = 0;
    double sumvar = 0;
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      N += n[x];
      sumvar += M2[x] / n[x]; // sample variance of x.
    }
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      logq[x] = delta * mean[x] * N / sumvar;
    }
  }
}

/*
 * The fourth version of BIZUNK that I implemented.  This is the one that is in
 * the paper, as of June 25 2012, which I am planning to submit as a revision to OR.
 */
SampleOnceRet_t SampleOnceBIZUNK4(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma[], double logElimThresh, int n0, int batchsize) {
  int x; // generic counter
  logqstats_t logqstats;

  assert(delta>0);
  assert(k>0);
  for (x=0; x<k; x++)
    assert(sigma[x]>=0);
  assert(k==1 || 1-exp(logElimThresh) >= pow(pstar,1.0/(k-1)));
  assert(batchsize>=1);

  SampleOnceRet_t ret;
  ret.nSamplesPerAlt = 0;
  ret.nSamples = 0;
  ret.nStages = 0;

  // If this condition is not met, then the randomized policy that does no
  // measurement is acceptable.  We do not treat this case because it isn't
  // particularly interesting.
  assert(pstar > (double)1/k);

  double logpstar = log(pstar); // Precompute the log of pstar.

  // Create four vectors.  
  // n[x] contains the number of samples taken from alternative x.  
  // mean[x] contains the mean of all the observations from alternative x.  
  // M2[x] contains the sum of the square differences from the current sample mean.
  // M2[x] = \sum_{i=1}^n (y_i - \ybar_n)^2, where y_i are the samples from alternative x.
  // The algorithm for updating the mean and M2 came from Wikipedia,
  // http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance 
  // who cites Knuth, and Knuth in turn apparently cites Welford.
  // The sample variance is given by M2[x] / n[x];
  // logq[x] is the log of q_{tx}(A).  
  // If logq[x] is -INFINITY then this indicates that the alternative has been eliminated.
  unsigned int n[k];
  double mean[k], M2[k], logq[k];
  for (x=0; x<k; x++) {
    n[x] = 0;
    mean[x] = 0;
    M2[x] = 0;
    logq[x] = 0;
  }

  // Take n0 samples from each alternative and update our statistics.
  for (x=0; x<k; x++) {
    while (n[x] < n0) {
      n[x]++;
      ret.nSamples++;
      double y = theta[x] + sto.Normal(0,sigma[x]);
      double tmp = y - mean[x];
      mean[x] += tmp / n[x];
      M2[x] += tmp*(y - mean[x]);
    }
  }
  logqstats = UpdateLogQ_Unknown(k, delta, n, mean, M2, logq);

  while(1) {
    // At this point, we have the following: 
    // n, mean, M2, logq, logqstats.  
    
#ifdef DEBUG
      printf("q = [");
      for (x=0; x<k; x++)
	printf("%.3f ", logq[x] == -INFINITY ? 0 : exp(logq[x])/logqstats.sumq);
      printf("]\n");
#endif

    // Check whether we have exceeded the threshold and can stop.
    if (logqstats.best_logq - log(logqstats.sumq) >= logpstar) {
      // we choose alternative x. This is correct if x is 0, and incorrect
      // otherwise.
      ret.correctSelection = CorrectSelection(logqstats.best_x,k,theta,delta);
      ret.nSamplesPerAlt = ret.nSamples / k;
#ifdef DEBUG
      if (ret.correctSelection) printf("correct selection\n");
      else printf("incorrect selection\n");
#endif
      return ret;
    }

    // This loop eliminates the worst alternative on each pass through
    while(logqstats.worst_logq - log(logqstats.sumq) <= logElimThresh) { // if this is true, eliminate the worst alternative

      // Eliminate the worst alternative and recompute logq.
      logq[logqstats.worst_x] = -INFINITY; // eliminate alternative argmin
      double worstq = exp(logqstats.worst_logq) / logqstats.sumq; // this is the normalized q of the worst alternative
#ifdef DEBUG
      printf("Elimination: argmin=%d q[argmin]=%.3f, ElimThresh=%.3f, current pstar=%.3f\n", logqstats.worst_x, worstq, exp(logElimThresh), exp(logpstar));
#endif
      // The new target probability pstar increases by a factor of 1/(1-worstq), where worstq is the
      // probability of the alternative just eliminated, so the log of pstar becomes 
      // logpstar - log(1-worstq) = logpstar - log1p(-worstq)
      logpstar -= log1p(-worstq);
      assert(logpstar<0);
      logqstats = UpdateLogQ_Unknown(k, delta, n, mean, M2, logq);

    } // End elimination while loop


    //
    // Update n[x] for each x and take these additional samples.  
    //
  
    ret.nStages++;

    // First, we calculate z = \argmin_x n[x] / var[x], which is the
    // alternative that has the least samples, according to the timescale proportional to the variance.
    double m = 0;
    int z = -1;
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      double var = M2[x] / n[x];
      if (z == -1 || m < n[x] / var) {
	m = n[x] / var;
	z = x;
      }
    }

    // Update m to be (n[z]+batchsize)/var[z].
    // m is the new number of samples for alternative z, in the timescale
    // proportional to the variance. 
    double var = M2[z] / n[z];
    m = (n[z] + batchsize) / var;

    // Now calculate n[x] and take the samples, maintaining logq.
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      double var = M2[x] / n[x]; // this is the sample variance 
      unsigned int new_n = ceil(var * m);  // This is n_{t+1,x}.
      while (n[x] < new_n) {
	n[x]++;
	ret.nSamples++;
	double y = theta[x] + sto.Normal(0,sigma[x]);
	double tmp = y - mean[x];
	mean[x] += tmp / n[x];
	M2[x] += tmp*(y - mean[x]);
      }
    }
    logqstats = UpdateLogQ_Unknown(k, delta, n, mean, M2, logq);

  } // end sampling loop
}

/*
 * Computes logq, which is the logarithm of the numerator of qhat_{tx}(A) in
 * equation 11 of the paper on June 25,2012.  The inputs are:
 *
 * int k		number of alternatives.  All vectors are of length k.
 * double delta		IZ parameter
 * unsigned int *n	vector of number of samples taken from each alternative.
 * double *mean		vector of sampling means
 * double *M2		vector of sums of the square of the differences from
 * 			the current sample mean.  M2[x]/n[x] gives the sample variance.
 * double *logq		pointer to a vector of length k.  If logq[x] == -INFINITY, this
 * 			means that alternative has already been eliminated.  Otherwise,
 * 			the logq[x] is ignored.
 *
 * Puts results into the vector logq, and returns statistics computed from this vector.
 */
logqstats_t UpdateLogQ_Unknown(int k, double delta, unsigned int *n, double *mean, double *M2, double *logq)
{ 
    int x;
    double N = 0;
    double sumvar = 0;
    logqstats_t ret;


    // Sum up number of samples and sample variances.
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      N += n[x];
      sumvar += M2[x] / n[x]; // sample variance of x.
    }

    // Calculate new logq values and statistics based on them.
    ret.sumq = 0; 
    ret.worst_logq = 0; ret.best_logq = 0;
    ret.worst_x = -1; ret.best_x = -1;
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      logq[x] = delta * mean[x] * N / sumvar;
      ret.sumq += exp(logq[x]);
      if (ret.worst_x == -1 || logq[x] < ret.worst_logq) {
	ret.worst_x = x;
	ret.worst_logq = logq[x];
      }
      if (ret.best_x == -1 || logq[x] > ret.best_logq) {
	ret.best_x = x;
	ret.best_logq = logq[x];
      }
    }
    return ret;
}



void BIZUNK_FreeArgs(void *args) { free(args); }
void BIZUNK_PrintArgs(void *args) { 
  int n0 = *(int *)(args);
  printf("# BIZUNK n0 = %d\n", n0);
}

int BIZUNK_ParseArgs(algArgs_t *args, int num_args, char *args_str[]) {
  int n0;


  if (num_args > 1) {
    fprintf(stderr, "BIZUNK requires at most 1 argument.\n");
    return -1;
  }

  // Default value for n0 is 30
  if (num_args == 0) 
    n0 = 30;

  if (num_args == 1) {
    int ret = sscanf(args_str[0],"n0=%d", &n0);
    if (ret != 1) {
      fprintf(stderr, "Argument to BIZUNK must be of the form \"n0=integer\".\n");
      return -1;
    }
  }

  args->args = malloc(sizeof(int));
  if (args->args == NULL) {
    perror("Out of memory");
    return -1;
  }
  *(int *)(args->args) = n0;

  args->print_args = &BIZUNK_PrintArgs;
  args->free_args = &BIZUNK_FreeArgs;

    return 0;
}
