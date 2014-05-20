/*
 * The BIZ policy with known, heterogeneous sampling variances.
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

logqstats_t UpdateLogQ_Known(int k, double delta, unsigned int *n, double *mean, double *var, double *logq);

SampleOnceRet_t SampleOnceBIZHET(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma[], double logElimThresh, int n0, int batchsize);

SampleOnceRet_t BIZHET(StochasticLib2 &sto, problem_t problem, algArgs_t args) {
  double logElimThresh = log1p(-pow(problem.pstar,1.0/(problem.k-1)));
  double n0 = 0;
  int batchsize = 1;
  return SampleOnceBIZHET(sto, problem.k, problem.pstar, problem.delta, problem.theta, problem.sigma, logElimThresh, n0, batchsize);
}

SampleOnceRet_t SampleOnceBIZHET(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma[], double logElimThresh, int n0, int batchsize) {
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

  // Create three vectors.  
  // n[x] contains the number of samples taken from alternative x.  
  // mean[x] contains the mean of all the observations from alternative x.  
  // logq[x] is the log of q_{tx}(A).  
  // var[x] contains the sampling variances, and does not change.  
  // If logq[x] is -INFINITY then this indicates that the alternative has been eliminated.
  unsigned int n[k];
  double mean[k], logq[k], var[k];
  for (x=0; x<k; x++) {
    n[x] = 0;
    mean[x] = 0;
    logq[x] = 0;
    var[x] = sigma[x] * sigma[x];
  }

  // Take n0 samples from each alternative and update our statistics.
  for (x=0; x<k; x++) {
    while (n[x] < n0) {
      n[x]++;
      ret.nSamples++;
      double y = theta[x] + sto.Normal(0,sigma[x]);
      double tmp = y - mean[x];
      mean[x] += tmp / n[x];
    }
  }
  logqstats = UpdateLogQ_Known(k, delta, n, mean, var, logq);

  while(1) {
    // At this point, we have the following: 
    // n, mean, logq, logqstats.  
    
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
      printf("Elimination: argmin=%d q[argmin]=%.3f, ElimThresh=%.3f, new pstar=%.3f\n", logqstats.worst_x, worstq, exp(logElimThresh), exp(logpstar));
#endif
      // The new target probability pstar increases by a factor of 1/(1-worstq), where worstq is the
      // probability of the alternative just eliminated, so the log of pstar becomes 
      // logpstar - log(1-worstq) = logpstar - log1p(-worstq)
      logpstar -= log1p(-worstq);
      assert(logpstar<0);
      logqstats = UpdateLogQ_Known(k, delta, n, mean, var, logq);

    } // End elimination while loop


    //
    // Update n[x] for each x and take these additional samples.  
    //
  
    ret.nStages++;

    // First, we calculate z = \argmin_x n[x] / var[i], which is the
    // alternative that has the least samples, according to the timescale proportional to the variance.
    double m = 0;
    int z = -1;
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      if (z == -1 || m < n[x] / var[x]) {
	m = n[x] / var[x];
	z = x;
      }
    }

    // Update m to be (n[z]+batchsize)/var[z].
    // m is the new number of samples for alternative z, in the timescale
    // proportional to the variance. 
    m = (n[z] + batchsize) / var[z];

    // Now calculate n[x] and take the samples, maintaining logq.
    for (x=0; x<k; x++) {
      if (logq[x] == -INFINITY) // if x has been eliminated
	continue;
      unsigned int new_n = ceil(var[x] * m);  // This is n_{t+1,x}.
      while (n[x] < new_n) {
	n[x]++;
	ret.nSamples++;
	double y = theta[x] + sto.Normal(0,sigma[x]);
	double tmp = y - mean[x];
	mean[x] += tmp / n[x];
      }
    }
    logqstats = UpdateLogQ_Known(k, delta, n, mean, var, logq);

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
 * double *var		vector of sampling variances.
 * double *logq		pointer to a vector of length k.  If logq[x] == -INFINITY, this
 * 			means that alternative has already been eliminated.  Otherwise,
 * 			the logq[x] is ignored.
 *
 * Puts results into the vector logq, and returns statistics computed from this vector.
 */
logqstats_t UpdateLogQ_Known(int k, double delta, unsigned int *n, double *mean, double *var, double *logq)
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
      sumvar += var[x]; // sample variance of x.
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
