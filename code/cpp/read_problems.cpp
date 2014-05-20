/*
 * This code reads in a data file containing sets of problems and prints them
 * in human readable form.
 */

#include "common.h"
#include <strings.h>
#include <stdio.h>
#include <fcntl.h>

void usage();

void usage() {
  fprintf(stderr,"usage: read_problems filename\n");
  exit(-1);
}

int read_problems(char *filename);

int main(int argc, char *argv[]) {
  if (argc != 2)
    usage();
  read_problems(argv[1]);
}

int read_problems(char *filename) {
  int nProblems;

   FILE *file = fopen(filename,"r");
   if (file == NULL) { fprintf(stderr,"could not open %s", filename); exit(-1); }

   // The first entry in the file is the number of problems.
   if (fread(&nProblems,sizeof(int),1,file) < 1) { fprintf(stderr,"Error reading from %s", filename); exit(-1); }
   if (nProblems > 10000) { fprintf(stderr,"Likely data corruption.  The number of problems is > 10000. Exiting."); exit(-1); }

   printf("# %d problems\n", nProblems);

   for (int n=0; n<nProblems; n++) {
     printf("Problem %d\n", n+1);

     // Read in each problem.  The first entry is the number of alternatives,
     // the second entry is pstar, and the third entry is delta.
     int k;
     double delta, pstar;
     if (fread(&k,sizeof(int),1,file) < 1) { fprintf(stderr,"Error reading from %s", filename); exit(-1); }
     if (k > 10000000) {
       fprintf(stderr,"Likely data corruption.  The number of problems is > 10000000. Exiting.");
       exit(-1);
     }
     if (fread(&pstar,sizeof(pstar),1,file) < 1) { fprintf(stderr, "Error reading from %s", filename); exit(-1); }
     if (pstar <= 0 or pstar >= 1) {
       fprintf(stderr,"Likely data corruption.  pstar is not in the interval (0,1). Exiting.");
       exit(-1);
     }
     if (fread(&delta,sizeof(delta),1,file) < 1) { fprintf(stderr,"Error reading from %s", filename); exit(-1); }
     if (delta <= 0) {
       fprintf(stderr,"Likely data corruption.  delta is <= 0. Exiting.");
       exit(-1);
     }

     printf("delta=%f pstar=%f\n", delta, pstar);

     // Read in the sampling means of the k alternatives.
     double theta[k];
     if (fread(theta,sizeof(double),k,file) < k) { fprintf(stderr,"Error reading from %s", filename); exit(-1); }

     printf("sampling means of %d alternatives:", k);
     for (int x=0; x<k; x++) { printf(" %f", theta[x]); }
     printf("\n");

     // Read in the sampling standard deviations of the k alternatives.
     double sigma[k];
     if (fread(sigma,sizeof(double),k,file) < k) { fprintf(stderr,"Error reading from %s", filename); exit(-1); }

     printf("sampling sdevs of %d alternatives:", k);
     for (int x=0; x<k; x++) { printf(" %f", sigma[x]); }
     printf("\n");
   }
   fclose(file);
}
