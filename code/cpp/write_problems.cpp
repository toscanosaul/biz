/*
 * This code creates data files containing sets of problems.
 */

#include "common.h"
#include <strings.h>
#include <stdio.h>
#include <fcntl.h>
#include <math.h>

// define this to use the same seed every time
#define USE_FIXED_SEED

#define FILE_DIR "problems/"

int write_SC(const char *filename, int maxk, double pstar, double delta, double sigma1, double sigma2); 
int write_MDM(const char *filename, int maxk, double pstar, double delta, double sigma1, double sigma2);
//int write_RPI(const char *filename, int maxk, double pstar, double delta, double sigma, double RPIsigma, int nProblems, int moveToPreferenceZone);
int write_RPI(const char *filename, int maxk, double pstar, double delta, double lower_sigma, double upper_sigma, double RPIsigma, int nProblems, int moveToPreferenceZone);
int write_SCvP(const char *filename, int k, double delta, double sigma1, double sigma2); 
int write_PGS(const char *filename, int k, int m, double pstar, double delta, double sigma);
int write_animation(const char *filename, int k, double pstar, double delta, double sigma);
int write_trial(const char *filename);
int write_trial2(const char *filename);

int main(int argc, char *argv[]) {

  // Common-variance and heterogeneous-variance versions of SC and MDM.
  // The heterogeneous variance versions have the standard deviation range
  // between 10/2 and 10*2 (variance between 100/4 and 100*4).
  int maxk = 16384;
  double pstar = 0.9;
  double delta = 1;
  double sigma = 10;
  write_SC(FILE_DIR "SC.dat", maxk, pstar, delta, sigma, sigma);
  write_MDM(FILE_DIR "MDM.dat", maxk, pstar, delta, sigma, sigma);

  write_SC(FILE_DIR "SC_INC.dat", maxk, pstar, delta, sigma/2, sigma*2);
  write_SC(FILE_DIR "SC_DEC.dat", maxk, pstar, delta, sigma*2, sigma/2);
  write_MDM(FILE_DIR "MDM_INC.dat", maxk, pstar, delta, sigma/2, sigma*2);
  write_MDM(FILE_DIR "MDM_DEC.dat", maxk, pstar, delta, sigma*2, sigma/2);

  write_SC(FILE_DIR "SC_INCA.dat", maxk, pstar, delta, sigma, sigma*sqrt(2));
  write_SC(FILE_DIR "SC_DECA.dat", maxk, pstar, delta, sigma*sqrt(2), sigma);
  write_MDM(FILE_DIR "MDM_INCA.dat", maxk, pstar, delta, sigma, sigma*sqrt(2));
  write_MDM(FILE_DIR "MDM_DECA.dat", maxk, pstar, delta, sigma*sqrt(2), sigma);

  // Common variance version of RPI.
  pstar = 0.8;
  delta = 0.5;
  sigma = 10;
  double RPIsigma = 0.5;
  int nProblems = 75;
  int moveToPreferenceZone = 1;
  write_RPI(FILE_DIR "RPI.dat",maxk,pstar,delta,sigma,sigma,RPIsigma,nProblems,moveToPreferenceZone);

  // Heterogeneous variance version of RPI.
  // RPI_hetero.dat has a factor of 16 difference in the variance (4 in the standard deviation).
  // RPI_heteroA.dat has a factor of 2 difference in the variance (sqrt(2) in the standard deviation).
  // RPI_PGS.dat is like RPI, but allows the second best alternative to be strictly closer than delta of the best.
  pstar = 0.8;
  delta = 0.5;
  sigma = 10;
  RPIsigma = 0.5;
  nProblems = 75;
  write_RPI(FILE_DIR "RPI_hetero.dat",maxk,pstar,delta,sigma/2,sigma*2,RPIsigma,nProblems,moveToPreferenceZone);
  write_RPI(FILE_DIR "RPI_heteroA.dat",maxk,pstar,delta,sigma,sigma*sqrt(2),RPIsigma,nProblems,moveToPreferenceZone);
  write_RPI(FILE_DIR "RPI_PGS.dat",maxk,pstar,delta,sigma,sigma,RPIsigma,nProblems,0);

  // This set of problems was usesd to create a plot for the ICS conference in
  // January 2013 in Sante Fe.  It is the slippage configuration for a variety
  // of different values of P.
  write_SCvP(FILE_DIR "SCvP.dat", 32, delta, sigma, sigma);

  // Creates a set of problem for exploring probability of good selection for
  // configurations in the indifference zone.  It creates a set of
  // configurations that are like the slippage configuration, where alt 1 has
  // value delta, alts 3 through k have value 0, and alt 2 has value ranging
  // between -delta and delta.
  pstar = 0.9;
  delta = 0.5;
  sigma = 10;
  double m = 10; // number of problems generated is 2*m+1
  write_PGS(FILE_DIR "PGS3.dat", 3, 10, pstar, delta, sigma);
  write_PGS(FILE_DIR "PGS10.dat", 10, 10, pstar, delta, sigma);
  write_PGS(FILE_DIR "PGS32.dat", 32, 10, pstar, delta, sigma);
  write_PGS(FILE_DIR "PGS100.dat", 100, 10, pstar, delta, sigma);
  write_PGS(FILE_DIR "PGS1000.dat", 1000, 10, pstar, delta, sigma);


  // Writes a problem configuration useful for creating an animation.
  int k = 4;
  pstar = 0.8;
  sigma = 10;
  delta = 1;
  write_animation(FILE_DIR "ANIMATION.dat", k, pstar, delta, sigma);


  // Write problem configurations for testing performance in certain limiting cases.
	delta=1;
  write_trial(FILE_DIR "TRIAL.dat");
	
	write_trial2(FILE_DIR "TRIAL2.dat");
}

/*
 * Writes random problem instances to a file.
 */
int write_RPI(const char *filename, int maxk, double pstar, double delta, double lower_sigma, double upper_sigma, double RPIsigma, int nProblems, int moveToPreferenceZone) {
#ifdef USE_FIXED_SEED
   int seed = 0;
#else
   int seed = (int)time(0);
#endif
   StochasticLib2 sto(seed);

   FILE *file = fopen(filename,"w");
   if (file == NULL) { fprintf(stderr,"could not open %s", filename); exit(-1); }

   /*
    * The data format is:
    * First, a single int giving the number of problems.
    * Then, for each problem, a single int giving the number of alternatives, and that many doubles giving the
    * value of theta[x] for each alternative x.
    */ 
   if (fwrite(&nProblems,sizeof(nProblems),1,file)<1) { fprintf(stderr,"error writing ", filename); exit(-1); }

   for (int n=0; n<nProblems; n++) {
     double logk = log(maxk)*sto.Random();
     int k = ceil(exp(logk));
     if (k<2) // this if statement is true only if logk=0, which happens with very small probability.
       k = 2; 
     double theta[k];
     double sigma_vec[k];
     int argmax = 0;
     for (int x=0; x<k; x++) { 
       theta[x] = sto.Normal(0,RPIsigma);
       if (theta[x]>theta[argmax]) // this also is ok for x=0
	 argmax = x;
       sigma_vec[x] = lower_sigma + (upper_sigma - lower_sigma) * sto.Random(); // uniform between lower_sigma and upper_sigma.
     }

     // Switch the 0th entry and the one with the largest value.  Our simulation code requires theta[0] to be largest.
     double tmp = theta[0]; 
     theta[0] = theta[argmax];
     theta[argmax] = tmp;

     // Reduce the ones that are within delta of the best to be exactly delta away.
     if (moveToPreferenceZone) {
       for (int x=1; x<k; x++) { 
         if (theta[x] > theta[0]-delta)
	   theta[x] = theta[0] - delta;
       }
     }

     // Write to file, in a binary format.
     if (fwrite(&k,sizeof(k),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }
     if (fwrite(&pstar,sizeof(pstar),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(&delta,sizeof(delta),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(theta,sizeof(*theta),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(sigma_vec,sizeof(*sigma_vec),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }
   }
   fclose(file);
}


/*
 * Writes slippage configuration problems to a file.
 */
int write_SC(const char *filename, int maxk, double pstar, double delta, double sigma1, double sigma2)
{
#ifdef USE_FIXED_SEED
   int seed = 0;
#else
   int seed = (int)time(0);
#endif
   StochasticLib2 sto(seed);

   FILE *file = fopen(filename,"w");
   if (file == NULL) { fprintf(stderr,"could not open %s", filename); exit(-1); }

   // count how many problems.
   int nProblems = 0;
   int k = 2;
   while (k<=maxk) {
     nProblems++;
     if (k<8)
       k++;
     else
       k=k*2;
   }
   if (fwrite(&nProblems,sizeof(nProblems),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }

   k = 2;
   while (k<=maxk) {
     // least favorable configuration
     double theta[k];
     double sigma_vec[k];
     double sigma_step = (sigma2 - sigma1)/(k-1);
     for (int x=0; x<k; x++) {
       theta[x]=0;
       sigma_vec[x]= sigma1 + sigma_step*x;
     }
     theta[0] = delta; 

     // Write to file, in a binary format.
     if (fwrite(&k,sizeof(k),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }
     if (fwrite(&pstar,sizeof(pstar),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(&delta,sizeof(delta),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(theta,sizeof(*theta),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(sigma_vec,sizeof(*sigma_vec),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }

     if (k<8)
       k++;
     else
       k=k*2;
   }
   fclose(file);
}

/*
 * Writes monotone decreasing means configuration problems to a file.
 */
int write_MDM(const char *filename, int maxk, double pstar, double delta, double sigma1, double sigma2)
{
#ifdef USE_FIXED_SEED
   int seed = 0;
#else
   int seed = (int)time(0);
#endif
   StochasticLib2 sto(seed);

   FILE *file = fopen(filename,"w");
   if (file == NULL) { fprintf(stderr,"could not open ", filename); exit(-1); }

   // count how many problems.
   int nProblems = 0;
   int k = 2;
   while (k<=maxk) {
     nProblems++;
     if (k<8)
       k++;
     else
       k=k*2;
   }
   if (fwrite(&nProblems,sizeof(nProblems),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }

   k = 2;
   while (k<=maxk) {
     // least favorable configuration
     double theta[k];
     double sigma_vec[k];
     double sigma_step = (sigma2 - sigma1)/(k-1);
     for (int x=0; x<k; x++) {
       theta[x]=-delta*x;
       sigma_vec[x]= sigma1 + sigma_step*x;
     }

     // Write to file, in a binary format.
     if (fwrite(&k,sizeof(k),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }
     if (fwrite(&pstar,sizeof(pstar),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(&delta,sizeof(delta),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(theta,sizeof(*theta),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(sigma_vec,sizeof(*sigma_vec),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }

     if (k<8)
       k++;
     else
       k=k*2;
   }
   fclose(file);
}



/*
 * Writes to a file a series of slippage configuration problems with different
 * pstar but a constant k.  Used to create a plot illustrating the consequences
 * of overdelivery on PCS for the 2013 ICS conference in Sante Fe.
 */
int write_SCvP(const char *filename, int k, double delta, double sigma1, double sigma2)
{
#ifdef USE_FIXED_SEED
   int seed = 0;
#else
   int seed = (int)time(0);
#endif
   StochasticLib2 sto(seed);

   FILE *file = fopen(filename,"w");
   if (file == NULL) { fprintf(stderr,"could not open %s", filename); exit(-1); }

   double change_in_pstar = .05;
   double pstar;

   // count how many problems.
   int nProblems = 0;
   pstar=.5;
   while(pstar<.99) {
     pstar+= change_in_pstar;
     nProblems++;
   }
   if (fwrite(&nProblems,sizeof(nProblems),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }

   pstar=.5;
   while(pstar<.99) {
     // least favorable configuration
     double theta[k];
     double sigma_vec[k];
     double sigma_step = (sigma2 - sigma1)/(k-1);
     for (int x=0; x<k; x++) {
       theta[x]=0;
       sigma_vec[x]= sigma1 + sigma_step*x;
     }
     theta[0] = delta; 

     // Write to file, in a binary format.
     if (fwrite(&k,sizeof(k),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }
     if (fwrite(&pstar,sizeof(pstar),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(&delta,sizeof(delta),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(theta,sizeof(*theta),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(sigma_vec,sizeof(*sigma_vec),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }

     pstar+=change_in_pstar;
   }
   fclose(file);
}



/* 
 * This set of problem configurations is used to test the hypothesis that the
 * worst probability of good selection occurs at the slippage configuration,
 * and not in the indifference zone.  For a given value of k, it creates a
 * sequence of configurations with mean [delta,b,0,...,0], where b ranges
 * between delta and 0.  The number of problem configurations created is
 * 2*m+1, where m is an argument to the function. 
 */
int write_PGS(const char *filename, int k, int m, double pstar, double delta, double sigma)
{
#ifdef USE_FIXED_SEED
   int seed = 0;
#else
   int seed = (int)time(0);
#endif
   StochasticLib2 sto(seed);

   FILE *file = fopen(filename,"w");
   if (file == NULL) { fprintf(stderr,"could not open %s", filename); exit(-1); }

   int nProblems = 2*m+1;
   if (fwrite(&nProblems,sizeof(nProblems),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }

   for (int i= -m; i<=m; i++) {
     double theta[k];
     double sigma_vec[k];
     for (int x=0; x<k; x++) {
       theta[x]=0;
       sigma_vec[x]= sigma;
     }
     theta[0] = delta; 
     theta[1] = delta*i/m;

     // Write to file, in a binary format.
     if (fwrite(&k,sizeof(k),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }
     if (fwrite(&pstar,sizeof(pstar),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(&delta,sizeof(delta),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(theta,sizeof(*theta),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(sigma_vec,sizeof(*sigma_vec),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }
   }
   fclose(file);
}


/*
 * Writes to a file a problem appropriate for animation, which is essentially
 * MDM with k=4.
 */
int write_animation(const char *filename, int k, double pstar, double delta, double sigma)
{
   FILE *file = fopen(filename,"w");
   if (file == NULL) { fprintf(stderr,"could not open ", filename); exit(-1); }

   int nProblems = 1;
   if (fwrite(&nProblems,sizeof(nProblems),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }

   double theta[k];
   double sigma_vec[k];
   for (int x=0; x<k; x++) {
     theta[x]=-delta*(x-2);
     sigma_vec[x]= sigma;
   }

   // Write to file, in a binary format.
   if (fwrite(&k,sizeof(k),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }
   if (fwrite(&pstar,sizeof(pstar),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
   if (fwrite(&delta,sizeof(delta),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
   if (fwrite(theta,sizeof(*theta),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }
   if (fwrite(sigma_vec,sizeof(*sigma_vec),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }

   fclose(file);
}


/*
 * This function writes a problem that has different variances.
 */
int write_trial(const char *filename)
{
#ifdef USE_FIXED_SEED
   int seed = 0;
#else
   int seed = (int)time(0);
#endif
   StochasticLib2 sto(seed);

   FILE *file = fopen(filename,"w");
   if (file == NULL) { fprintf(stderr,"could not open ", filename); exit(-1); }

   int nProblems = 10;
   if (fwrite(&nProblems,sizeof(nProblems),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }

   int k = 10;
   double pstar = 0.95;
	double delta2=1.0;
	double delta=1.2;
   double sigma = 50.0;
	double a=delta;
	double b=0.6;
   for(int i=1;i<=nProblems;i++) {
     // least favorable configuration
	  delta=a-(double(i)/double(nProblems))*((a-b));
	   //delta=0.00001;
	   //delta=0.001;
     double theta[k];
     double sigma_vec[k];
     for (int x=0; x<k; x++) {
       theta[x]=(delta)*x;
       sigma_vec[x]= sigma/(x+1); // set the variance to decrease with i.
     }

     // Write to file, in a binary format.
     if (fwrite(&k,sizeof(k),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }
     if (fwrite(&pstar,sizeof(pstar),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(&delta,sizeof(delta),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(theta,sizeof(*theta),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }
     if (fwrite(sigma_vec,sizeof(*sigma_vec),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }
   }
   fclose(file);
}

int write_trial2(const char *filename)
{
#ifdef USE_FIXED_SEED
	int seed = 0;
#else
	int seed = (int)time(0);
#endif
	StochasticLib2 sto(seed);
	
	FILE *file = fopen(filename,"w");
	if (file == NULL) { fprintf(stderr,"could not open ", filename); exit(-1); }
	
	int nProblems = 10;
	if (fwrite(&nProblems,sizeof(nProblems),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }
	
	int k = 10;
	double pstar = 0.95;

	double delta=1.0;
	double sigma = 1.0;
	double aux=1.0;
	for(int i=1;i<=nProblems;i++) {
		// least favorable configuration
	
		//delta=0.001;
		double theta[k];
		double sigma_vec[k];
		for (int x=0; x<k; x++) {
			theta[x]=-(delta)*x;
			sigma_vec[x]= (sigma/(double(x)+1.0))+aux; // set the variance to decrease with i.
		}
		
		// Write to file, in a binary format.
		if (fwrite(&k,sizeof(k),1,file)<1) { fprintf(stderr,"error writing %s", filename); exit(-1); }
		if (fwrite(&pstar,sizeof(pstar),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
		if (fwrite(&delta,sizeof(delta),1,file)<1) { fprintf(stderr, "error writing %s", filename); exit(-1); }
		if (fwrite(theta,sizeof(*theta),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }
		if (fwrite(sigma_vec,sizeof(*sigma_vec),k,file)<k) { fprintf(stderr, "error writing %s", filename); exit(-1); }
		
		aux=aux*2.0;
	}
	fclose(file);
}
