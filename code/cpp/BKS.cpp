#include "BKS.h"

/*
 * Assumes that the maximal element is unique, and has index 0.  Note that we
 * pass the StochasticLib by reference, rather than by value.  This allows the
 * seed to get updated by the random numbers we generate.
 */ 

SampleOnceRet_t SampleOnceBKS(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma);
SampleOnceRet_t BKS(StochasticLib2 &sto, problem_t problem, algArgs_t args) {
  for(int x=1; x<problem.k; x++) {
    if (problem.sigma[x] != problem.sigma[0]) {
      fprintf(stderr, "SampleOnceBKS requires the sampling variance to be the same across alternatives\n.");
      exit(-1);
    }
  }
  return SampleOnceBKS(sto, problem.k, problem.pstar, problem.delta, problem.theta, problem.sigma[0]);
}


SampleOnceRet_t SampleOnceBKS(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma) {
  int x; // generic counter

  assert(delta>0);
  assert(k>0);
  assert(sigma>=0);

  // Check that element 0 is the unique argmax, and that it is delta better than the others.
  for (x=1; x<k; x++)
    assert(theta[0]-delta >= theta[x]);

  // If this condition is not met, then the randomized policy that does no
  // measurement is acceptible.  We do not treat this case because it isn't
  // particularly interesting.
  assert(pstar > (double)1/k);

  // Create a vector of log-likelihoods.
  double logq[k];
  for (x=0; x<k; logq[x++]=0);

  // precompute the coefficient that multiplies the observation z when
  // calculating logq.  Also precompute the log of pstar.
  double c = delta / (sigma*sigma); 
  double logpstar = log(pstar);


  SampleOnceRet_t ret;
  ret.nSamplesPerAlt = 0;
  ret.nStages = 0;
  while(1) {
    // Generate the next samples and add them to logq
    ret.nSamplesPerAlt++;
    ret.nStages++;
    for (x=0; x<k; x++) {
      double z = theta[x] + sto.Normal(0,sigma);
      logq[x] += c*z;
    }

    // Renormalize logq probabilities so that exp(logq) sums to 1.  Also figure
    // out the argmax of the logqs.  
    int argmax = 0;
    double sumq = 0;
    for (x=0; x<k; x++) {
      sumq += exp(logq[x]);
      // This code does no tie-breaking, and so assumes that with 0 probability
      // we have a tie in the argmax set.  This assert checks this is true.
      assert (x==0 || logq[x] != logq[argmax]);
      if (x>0 && logq[x]>logq[argmax])
	argmax = x;
    }
    double logsumq = log(sumq);
    for (x=0; x<k; logq[x++] -= logsumq);

    // uncomment for debugging output
    /*
    printf("q = [");
    for (x=0; x<k; x++)
      printf("%.2f ", exp(logq[x]));
    printf("]\n");
    */

    // Check whether we have exceeded the threshold and can stop.
    if (logq[argmax] >= logpstar) {
      // we choose alternative x. This is correct if x is 0, and incorrect
      // otherwise.
      ret.correctSelection = (argmax == 0);
      // For debugging
      // if (ret.correctSelection) printf("correct selection\n");
      // else printf("incorrect selection\n");
      return ret;
    }

  }
}
