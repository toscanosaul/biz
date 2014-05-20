#include "BIZ.h"
#include <strings.h>

/*
 * We can define the following C preprocessor labels in the Makefile, or hardcoded here:
 * DEBUG, OUTPUT_FOR_ANIMATION, OPTIMIZE:
 * 	DEBUG turns on debugging output.
 * 	OPTIMIZE is optional, and does something tricky to make the computation of BIZ faster.
 * 	OUTPUT_FOR_ANIMATION is used to create output for a single run of BIZ
 * 		that can be used to create an animation.  Don't simulataneously turn on
 * 		OUTPUT_FOR_ANIMATION and OPTIMIZE  
 */

SampleOnceRet_t SampleOnceBIZ(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma, double logElimThresh);

SampleOnceRet_t BIZ(StochasticLib2 &sto, problem_t problem, algArgs_t args) {
  for(int x=1; x<problem.k; x++) {
    if (problem.sigma[x] != problem.sigma[0]) {
      fprintf(stderr, "SampleOnceBIZ requires the sampling variance to be the same across alternatives\n.");
      exit(-1);
    }
  }
  double logElimThresh = log1p(-pow(problem.pstar,1.0/(problem.k-1)));
  return SampleOnceBIZ(sto, problem.k, problem.pstar, problem.delta, problem.theta, problem.sigma[0], logElimThresh);
}

SampleOnceRet_t SampleOnceBIZ(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma, double logElimThresh) {
  int x; // generic counter

  assert(delta>0);
  assert(k>0);
  assert(sigma>=0);
  assert(k==1 || 1-exp(logElimThresh) >= pow(pstar,1.0/(k-1)));

  // If this condition is not met, then the randomized policy that does no
  // measurement is acceptable.  We do not treat this case because it isn't
  // particularly interesting.
  assert(pstar > (double)1/k);

  // Create a vector of log-likelihoods. If a log-likelihood is -INF, then this indicates that the alternative has been
  // eliminated.
  double logq[k];
  for (x=0; x<k; logq[x++]=0);
#ifdef OUTPUT_FOR_ANIMATION
  double Y[k];
  for (x=0; x<k; Y[x++]=0);
#endif // OUTPUT_FOR_ANIMATION
  int last = k-1; // This is the largest alternative in contention.

#ifdef OPTIMIZE
  // To make things faster when skipping over eliminated alternatives, we will change the logq[] and theta[] arrays, so
  // that logq[x] may refer to a different alternative later if alternatives before x are eliminated.

  // alt[x] will be the original number of the alternative in index x.  
  double *alts = new double[k];
  for (x=0;x<k;x++)
    alts[x]=x;

  // We will also be altering theta.  Create a new vector and copy the contents into it.
  double *original_theta = theta;
  theta = new double[k];
  memcpy(theta,original_theta,k*sizeof(double));
#endif // OPTIMIZE

  // precompute the coefficient that multiplies the observation when
  // calculating logq.  Also precompute the log of pstar.
  double c = delta / (sigma*sigma); 
  double logpstar = log(pstar);

#ifdef OUTPUT_FOR_ANIMATION
  printf("t,LowerEliminationThreshold,Pstar");
  for (x=0; x<k; x++) { printf(",Y[%d]",x); }
  for (x=0; x<k; x++) { printf(",q[%d]",x); }
  printf("\n");
#endif

  SampleOnceRet_t ret;
  ret.nSamples = 0;
  ret.nStages = 0;
  while(1) {
#ifdef OUTPUT_FOR_ANIMATION
      // uncomment for graphical output for a diagram for the APS 2011 talk.
         printf("%d,", ret.nStages);
         printf("%.5f,", exp(logElimThresh));
         printf("%.5f", exp(logpstar));
      // Prints Y_{tx}
     	 for (x=0; x<k; x++) {
	   if (logq[x]==-INFINITY) // if x has been eliminated
	     printf(",NaN");
	   else
	     printf(",%.5f", Y[x]);
	 }
      // Prints q_{tx}(A_{N_t})
	 for (x=0; x<k; x++) {
	   if (logq[x]==-INFINITY) // if x has been eliminated
	     printf(",0");
	   else
	     printf(",%.5f", exp(logq[x]));
	 }
	 printf("\n");
#endif



    ret.nStages++;
    // Generate the next samples and add them to logq.
    // Also sum up the q's into sumq
    // and finds the worst alternative, putting results in worst_x and worst_logq.
    double sumq = 0;
    int worst_x = -1;
    double worst_logq = 0;
    for (x=0; x<=last; x++) {
      if (logq[x]==-INFINITY) // if x has been eliminated
	continue;
      double z = theta[x] + sto.Normal(0,sigma);
      logq[x] += c*z;
#ifdef OUTPUT_FOR_ANIMATION
      Y[x] += z;
#endif // OUTPUT_FOR_ANIMATION
      if (worst_x == -1 || logq[x] < worst_logq) {
	worst_x = x;
	worst_logq = logq[x];
      }
      sumq += exp(logq[x]);
      ret.nSamples++; 
    }

#ifdef DEBUG
      printf("q = [");
      for (x=0; x<k; x++)
	printf("%.3f ", logq[x] == -INFINITY ? 0 : exp(logq[x])/sumq);
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
      printf("Elimination: argmin=%d q[argmin]=%.3f, ElimThresh=%.3f, new pstar=%.3f\n", worst_x, worstq, exp(logElimThresh), exp(logpstar));
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
      for (x=0; x<=last; x++) {
	if (logq[x]==-INFINITY) // if x has been eliminated
	  continue;
	if (worst_x ==-1 || logq[x]<worst_logq) {
	  worst_x  = x;
	  worst_logq = logq[x];
	}
      }

    } // End elimination while loop

    // Renormalize logq probabilities so that exp(logq) sums to 1.
    // Also, figure out the argmax over non-eliminated alternatives.
    // Also, find the index of the largest non-eliminated alternative to update last.
    double logsumq = log(sumq);
    int argmax = -1;
#ifdef OPTIMIZE
    int new_last = 0;
    int num_in_contention = 0;
#endif
    double best_logq = 0;
    for (x=0; x<=last; x++) {
      if (logq[x]==-INFINITY) // x has been eliminated
	continue;
      logq[x] -= logsumq; // renormalize x
#ifdef OPTIMIZE
      new_last = x;
      num_in_contention++;
#endif
      if (argmax==-1 || logq[x]>best_logq) {
	argmax = x;
	best_logq = logq[x];
      }
    }

    // Check whether we have exceeded the threshold and can stop.
    if (best_logq >= logpstar) {
      // we choose alternative x. This is correct if x is 0, and incorrect
      // otherwise.
      // ret.correctSelection = (argmax == 0);
#ifdef OPTIMIZE
      // The selected alternative is actually alts[argmax], according to the original numbering.
      ret.correctSelection = CorrectSelection(alts[argmax],k,original_theta,delta);
#else
      ret.correctSelection = CorrectSelection(argmax,k,theta,delta);
#endif 
      ret.nSamplesPerAlt = ret.nSamples / k;
#ifdef DEBUG
      if (ret.correctSelection) printf("correct selection\n");
      else printf("incorrect selection\n");
#endif
#ifdef OPTIMIZE
      free(theta);
      free(alts);
#endif // OPTIMIZE
      return ret;
    }


#ifdef OPTIMIZE
    last = new_last; // Update the index of the last alternative in contention.

    // If we have lots of blank spaces in our array due to elimination, get rid of those eliminated alternatives and put
    // non-eliminated alternatives in their place.  In doing this, make sure not to get rid of alternative 0, even if we
    // have eliminated it.
    // Be aware that the correctness of this code depends critically on knowing that alternative 0 is the best.  If we
    // don't know which alternative is the best, we have to keep track of the indices of all of the remaining
    // alternatives so that  
    if (last >= 128 && num_in_contention < last*.9) {
      int from = 0, to=0;
      for (from=0;from<=last;from++) {
	if (logq[from]==-INFINITY)
	  continue;

	// Copy everything about the alternative "from", which is later in the array, into the earlier location "to".
	alts[to] = alts[from];
	theta[to] = theta[from];
	logq[to] = logq[from];
	to++;
      }
      last = to-1; // now everything starting from "to" is invalid.
    }
#endif




  }
}
