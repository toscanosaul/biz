#include "KN.h"

SampleOnceRet_t SampleOnceKN(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma);
SampleOnceRet_t KN(StochasticLib2 &sto, problem_t problem, algArgs_t args) {
  for(int x=1; x<problem.k; x++) {
    if (problem.sigma[x] != problem.sigma[0]) {
      fprintf(stderr, "SampleOnceKN requires the sampling variance to be the same across alternatives\n.");
      exit(-1);
    }
  }
  return SampleOnceKN(sto, problem.k, problem.pstar, problem.delta, problem.theta, problem.sigma[0]);
}


/*
 * Sample according to the KN policy.  Assumes common known variance.
 */ 
SampleOnceRet_t SampleOnceKN(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma) {
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
  ret.nSamples = 0; // total number of samples.
  ret.nStages = 0;
  double sum[k];
  for (int x=0;x<k;sum[x++]=0);

  // Constants
  int n0 = 1;
  //double eta = -1 * log(2.0 - 2.0*pow(1-pstar,1.0/(k-1)));
  double alpha = 1-pstar;
  double eta = log((k-1)/(2.0*alpha));
  double h2 = 2*eta;
  double sigma2 = sigma*sigma; // supposed to be sample variance
  double c1 = h2/(delta*delta);

  // printf("n0=%d eta=%f h2=%f sigma2=%f c1=%f\n", n0,eta,h2,sigma2,c1);
  
  // Run a first stage
  for(r=0;r<n0;r++) {
    ret.nStages++;
    for (x=0; x<k; x++) {
      double z = theta[x] + sto.Normal(0,sigma);
      sum[x] += z;
      ret.nSamples++;
    }
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

    // Set the w constant for this round.  Note that common variance implies
    // that this constant does not change for the different alternatives.
    double S2 = 2*sigma2;
    double w = (c1*S2 - r)*delta/2.0;
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


      /* Here is an initial implementation of the more general method for
       * heterogeneous sampling variance. 
       */
      /*
      // Test x against each y in the continuation set, excepting x.
      for (y=0; y<lastIn; y++) {
	if (!in[y] || y==x) 
	  continue;
	w = (c1*S2 - r)*delta/2.0;
	if (w<0)
	  w=0;
	if (sum[x] < sum[y] - rw) {
	  // remove x from the continuation set.
	  assert(in[x]);
	  in[x] = false;
	  nIn--;
	  break; // we are done with this x. break the y loop, and go back to
	  	 // the x loop.
	}
      }
      */
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
  ret.nSamplesPerAlt = ret.nSamples / k;
  return ret;
}
