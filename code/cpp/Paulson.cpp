#include "Paulson.h"

SampleOnceRet_t SampleOncePaulson(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma);
SampleOnceRet_t Paulson(StochasticLib2 &sto, problem_t problem, algArgs_t args) {
  for(int x=1; x<problem.k; x++) {
    if (problem.sigma[x] != problem.sigma[0]) {
      fprintf(stderr, "SampleOncePaulson requires the sampling variance to be the same across alternatives\n.");
      exit(-1);
    }
  }
  return SampleOncePaulson(sto, problem.k, problem.pstar, problem.delta, problem.theta, problem.sigma[0]);
}


/*
 * Sample according to Paulson's procedure, as described in Paulson (1964).
 *
 * Paulson, E. (1964). A Sequential Procedure for Selecting the Population with the Largest Mean from k Normal
 * Populations. The Annals of Mathematical Statistics, 35(1), 174-180.
 *
 * The procedure is also described in Kim & Nelson's chapter in the Simulation Handbook from 2006.
 */ 
SampleOnceRet_t SampleOncePaulson(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma) {
  int x; // generic counter

  assert(delta>0);
  assert(k>0);
  assert(sigma>=0);

  // If this condition is not met, then the randomized policy that does no
  // measurement is acceptible.  We do not treat this case because it isn't
  // particularly interesting.
  assert(pstar > (double)1/k);

  SampleOnceRet_t ret;

  int r = 0; // number of rounds
  ret.nSamples = 0;
  ret.nStages = 0;
  double sum[k];
  for (int x=0;x<k;sum[x++]=0);

  // Constants
  double sigma2 = sigma*sigma;
  double lambda = delta / 2; // use this, as recommended by Kim & Nelson 2001.  Paulson 1964 recommends delta/4.
  double PICS = 1-pstar; 
  double a = log((k-1)/PICS) * sigma2 / (delta - lambda);


  //printf("a=%f lambda=%f delta=%f sigma2=%f\n", a,lambda,delta,sigma2);
  
  // Run a first stage of 1 measurement.
  ret.nStages++;
  for (x=0; x<k; x++) {
    double z = theta[x] + sto.Normal(0,sigma);
    sum[x] += z;
    ret.nSamples++;
  }
  r = 1;
  
  // Sequential Screening
  bool in[k]; // flags that are set when we are still simulating
  for (int x=0;x<k;in[x++]=true);
  int nIn = k; // number of flags that are turned on
  int lastIn = k; // index of the alternative in contention with the largest index.  

  int best;
  while(1) {
    ret.nStages++;

    // This first part of the loop is considered, in the Paulson paper and in Kim & Nelson 2006, to be the last part of
    // the previous stage.

    // Figure out which x is largest of those in the continuation set.
    best = -1;
    for (x=0; x<lastIn; x++) {
      if (in[x] && (best == -1 || sum[x]>sum[best]))
	  best = x;
    }

    // Set the w constant for this round.  Note that common variance implies
    // that this constant does not change for the different alternatives.
    double w = a - r * lambda;
    if (w<0)
      w=0;

    //printf("r=%d nIn=%d w=%f best=%d\n", r, nIn, w, best);

    // Iterate through the alternatives still in the consideration set, and
    // test each of them for removal.
    for (x=0; x<lastIn; x++) {
      // printf("in[%d]=%d sum[%d]=%f\n", x, in[x], x, sum[x]);
      // If the x isn't in the continuation set, we don't test it.
      // If x has the largest mean, we can't remove it.
      if (!in[x] || x==best) continue;


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
	  buf[bufind] = sto.Normal(0,sigma);
	bufind = 0;
      }
      double z = theta[x] + buf[bufind++];
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
  ret.nSamplesPerAlt = ret.nSamples / k; // Make it the average per alternative
  return ret;
}
