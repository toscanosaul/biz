#include "KN.h"

SampleOnceRet_t KNHET(StochasticLib2 &sto, problem_t problem, algArgs_t args) {
  int n0 = 2;
  bool varknown = 1;
  return SampleOnceKNHelper(sto, problem.k, problem.pstar, problem.delta, problem.theta, problem.sigma, varknown, n0);
}


/*
 * Sample according to the KN policy, with heterogeneous sampling variance.
 * Set varknown to TRUE for known sampling variance, and FALSE for unknown.
 */ 
SampleOnceRet_t SampleOnceKNHelper(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma[], bool varknown, int n0) {
  int x; // generic counter

  assert(delta>0);
  assert(k>0);

  // If this condition is not met, then the randomized policy that does no
  // measurement is acceptible.  We do not treat this case because it isn't
  // particularly interesting.
  assert(pstar > (double)1/k);

  SampleOnceRet_t ret;

  int r = 0; // number of rounds
  ret.nSamples = 0; // total number of samples.
  ret.nStages = 0;
  double sum[k], varhat[k];
  for (int x=0;x<k;sum[x++]=0);

  // Constants
  double eta, h2;
  double alpha = 1-pstar;
  if (varknown) { // Known variance
    eta = log((k-1)/(2.0*alpha));
    h2 = 2*eta;
  } else { // Unknown variance
    eta = (pow(2.0*alpha/(k-1),-2.0/(n0-1))-1)/2.0;
    h2 = 2*eta*(n0-1);
  }
  double c1 = h2/(delta*delta);

  // printf("n0=%d eta=%f h2=%f c1=%f\n", n0,eta,h2,c1);
  
  // Run a first stage
  ret.nStages += n0;
  for (x=0; x<k; x++) {
    // mean and M2 are for calculating the sample variance.
    // The algorithm for updating the mean and M2 came from Wikipedia,
    // http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance 
    // who cites Knuth, and Knuth in turn apparently cites Welford.
    // The sample variance is given by M2 / (ret.nSamples - 1);
    double mean = 0; // current sample mean.
    double M2 = 0; // sum of the square differences from the current sample mean.
    for(r=0;r<n0;r++) {
      double z = theta[x] + sto.Normal(0,sigma[x]);
      sum[x] += z;
      double tmp = z - mean;
      mean += tmp / (r+1); // r+1 is the number of samples taken.
      M2 += tmp*(z - mean);
      ret.nSamples++;
    }
    if (varknown) {
      varhat[x] = sigma[x] * sigma[x];
    } else {
      varhat[x] = M2 / (n0-1);
    }
    // printf("varhat[%d]=%f\n", x, varhat[x]);
  }

  // Sequential Screening
  bool in[k]; // flags that are set when we are still simulating
  for (int x=0;x<k;in[x++]=true);
  int nIn = k; // number of flags that are turned on
  int lastIn = k; // index of the alternative in contention with the largest index.  

  int best;
  while(1) {
    ret.nStages++;

    // Figure out which x is largest of those in the continuation set.
    best = -1;
    for (x=0; x<lastIn; x++) {
      if (in[x] && (best == -1 || sum[x]>sum[best]))
	  best = x;
    }

    // Iterate through the alternatives still in the consideration set, and
    // test each of them for removal.
    for (x=0; x<lastIn; x++) {
      // printf("in[%d]=%d sum[%d]=%f nIn=%d lastIn=%d\n", x, in[x], x, sum[x], nIn, lastIn);
      // If the x isn't in the continuation set, we don't test it.
      // If x has the largest mean, we can't remove it.
      if (!in[x] || x==best) continue;

      // Calculate the constant w.  It depends on S_{il}^2, which is the variance
      // of the difference between the best alternative, and the current
      // alternative.  We work with the sum of the observations, rather than
      // their mean, which means that we multiply the w constant in Kim &
      // Nelson 2006 by r.
      double Sil2 = varhat[best] + varhat[x];
      double w = (c1*Sil2 - r)*delta/2.0;
      if (w<0)
	w=0;

      // Remove the alternative
      // printf("x=%d sum[x]=%f sum[best]-w=%f\n", x, sum[x], sum[best]-w);
      if (sum[x] < sum[best]-w) {
	in[x] = false;
	nIn--;
      }
      
    } // done testing for removal

    if (nIn == 1)
      break;

    // Generate the next samples.
#define BUFSIZE 256
    double buf[BUFSIZE];
    int bufind = BUFSIZE;
    
    r++;
    for (x=0; x<lastIn; x++) {
      if (!in[x]) continue;

      if (bufind == BUFSIZE) {
	for (bufind=0;bufind<BUFSIZE;bufind++)
	  buf[bufind] = sto.Normal(0,1);
	bufind = 0;
      }
      double z = theta[x] + sigma[x]*buf[bufind++];
      sum[x] += z;
      ret.nSamples++;
    }

    // Figure out if we can decrease the value of the largest alternative that is in contention.  This is optional for
    // functionality, and just improves the speed.
    while(!in[lastIn-1])  // while the last alternative is out of contention
      lastIn--;
    assert(lastIn>0);
  }

  //ret.correctSelection = (best == 0);
  ret.correctSelection = CorrectSelection(best,k,theta,delta);
  ret.nSamplesPerAlt = ret.nSamples / k;
  return ret;
}
