/*
 * This code runs a procedure against all of the problems in a data file.
 */

#include "common.h"
#include "BKS.h"
#include "BIZ.h"
#include "KN.h"
#include "Paulson.h"
#include <strings.h>
#include <stdio.h>
#include <fcntl.h>
#include <time.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;
// define this to use the same seed every time
#define USE_FIXED_SEED
FILE *out;

typedef struct SampleManyRet {
	int nRuns;
	int nCorrect; // numer of correct selections in the run.
	double avgNk; // average of the number of samples per alternative, N/k
	double avgNksq; // the average of (N/k)^2
	double avgStages; // average of the number of stages.
	double avgStagesSq; // average of the number of stages squared.
	// composite estimates produced from raw stats above.
	double estPCS; // estimate of PCS
	double stdPCS; // stderr of estimate of PCS
	double stdNk; // stderr of estimate of N/k.  The estimate of N/k is avgNk.
	double stdStages; // stderr of estimate of number of stages.  The estimate is avgStages;
} SampleManyRet_t;

void RunProblemsFromFile(algorithm_t algorithm, char *filename, int nreps, algArgs_t args);
void RunProblem(algorithm_t algorithm, problem_t problem, int nreps, algArgs_t args);
void usage();

void usage() {
	fprintf(stderr, "usage: experiments {BIZ|BIZHET|BIZUNK|KN|KNHET|KNUNK|BKS|Paulson} datafile num_reps [n0=value]\n");
	fprintf(stderr, "       The optional n0 argument is accepted only by BIZUNK and KNUNK.\n");
	
	// This is a more general method for accepting arguments, which is a special case of the one described above.
	/* 
	 fprintf(stderr, "usage: experiments {BIZ|BIZHET|BIZUNK|KN|KNHET|KNUNK|BKS|Paulson} datafile num_reps "
	 "[key1=value [key2=value [...]]]\n");
	 fprintf(stderr, 
	 "The optional key,value pairs are passed to the individual algorithms,\n"
	 "which deal with them in an algorithm specific way.  Currently the only one\n"
	 "that is used is the key of n0, used by BIZUNK and KNUNK, which must be set\n"
	 "to an integer.\n");
	 */
	exit(-1);
}


int main(int argc, char *argv[]) {

	if (argc < 4)
		usage();
	out=fopen("ex.txt","w");
	out=fopen("ex2.txt","w");
	fclose(out);
	
	/* 
	 * Get the algorithm to run experiments on, parsing the optional algorithm arguments. 
	 */
	algorithm_t algorithm;
	algArgs_t args;
	char **args_str;
	int num_args = argc - 4;
	if (num_args > 0)
		args_str = &argv[4];
	else
		args_str = NULL;
	
	if (!strcmp(argv[1],"BIZ")) {
		algorithm = &BIZ;
		if (NoArgs(&args, num_args, args_str)) usage();
	} else if (!strcmp(argv[1],"BIZHET")) {
		algorithm = &BIZHET;
		if (NoArgs(&args, num_args, args_str)) usage();
	} else if (!strcmp(argv[1],"BIZUNK")) {
		algorithm = &BIZUNK;
		if (BIZUNK_ParseArgs(&args, num_args, args_str)) usage();
	} else if (!strcmp(argv[1],"BKS")) {
		algorithm = &BKS;
		if (NoArgs(&args, num_args, args_str)) usage();
	} else if (!strcmp(argv[1],"KN")) {
		algorithm = &KN;
		if (NoArgs(&args, num_args, args_str)) usage();
	} else if (!strcmp(argv[1],"KNHET")) {
		algorithm = &KNHET;
		if (NoArgs(&args, num_args, args_str)) usage();
	} else if (!strcmp(argv[1],"KNUNK")) {
		algorithm = &KNUNK;
		if (KNUNK_ParseArgs(&args, num_args, args_str)) usage();
	} else if (!strcmp(argv[1],"Paulson")) {
		algorithm = &Paulson;
		if (NoArgs(&args, num_args, args_str)) usage();
	} else {
		usage();
	}
	
	char *filename = argv[2]; // location of the datafile
	int reps = atoi(argv[3]); // number of replications to perform
	
	RunProblemsFromFile(algorithm,filename,reps,args);
	if (args.free_args != NULL)
		args.free_args(args.args);
}

void RunProblemsFromFile(algorithm_t algorithm, char *filename, int nreps, algArgs_t args) {
	int nProblems = 0;
	
	printf("# %d replications, %s\n", nreps, filename);
	time_t now = time(NULL);
	printf("# %s", ctime(&now));
	if (args.print_args != NULL)
		args.print_args(args.args);
	
	FILE *file = fopen(filename,"r");
	if (file == NULL) {
		fprintf(stderr,"could not open %s", filename);
		exit(-1);
	}
	
	// The first entry in the file is the number of problems.
	if (fread(&nProblems,sizeof(int),1,file) < 1) { fprintf(stderr, "Error reading from %s", filename); exit(-1); }
	if (nProblems > 10000) { fprintf(stderr,"Likely data corruption.  The number of problems is > 10000. Exiting."); exit(-1); }
	
	for (int n=0; n<nProblems; n++) {
		problem_t problem;
		
		// Read in the number of alternatives, pstar, and delta.
		if (fread(&problem.k,sizeof(int),1,file) < 1) { fprintf(stderr, "Error reading from %s", filename); exit(-1); }
		if (problem.k <= 0 || problem.k > 10000000) {
			fprintf(stderr,"Likely data corruption.  The number of problems is > 10000000 or <=0. Exiting.");
			exit(-1);
		}
		
		if (fread(&problem.pstar,sizeof(problem.pstar),1,file) < 1) { fprintf(stderr, "Error reading from %s", filename); exit(-1); }
		if (problem.pstar <= 0 or problem.pstar >= 1) {
			fprintf(stderr,"Likely data corruption.  pstar is not in the interval (0,1). Exiting.");
			exit(-1);
		}
		
		if (fread(&problem.delta,sizeof(problem.delta),1,file) < 1) { fprintf(stderr, "Error reading from %s", filename); exit(-1); }
		if (problem.delta <= 0) {
			fprintf(stderr,"Likely data corruption.  delta is <= 0. Exiting.");
			exit(-1);
		}
		
		// Read in the sampling means of the k alternatives.
		problem.theta = (double *)malloc(sizeof(double)*problem.k);
		if (problem.theta == NULL) { perror("Out of memory."); exit(-1); }
		if (fread(problem.theta,sizeof(double),problem.k,file) < problem.k) { 
			fprintf(stderr,"Error reading from %s", filename); 
			exit(-1);
		}
		
		// Read in the sampling standard deviations of the k alternatives.
		problem.sigma = (double *)malloc(sizeof(double)*problem.k);
		if (fread(problem.sigma,sizeof(double),problem.k,file) < problem.k) {
			fprintf(stderr,"Error reading from %s", filename);
			exit(-1);
		}
		
		RunProblem(algorithm, problem, nreps, args);
		
		free(problem.theta);
		free(problem.sigma);
		fflush(NULL);
	}
	fclose(file);
}


void RunProblem(algorithm_t algorithm, problem_t problem, int nRuns, algArgs_t args) {
#ifdef USE_FIXED_SEED
	int seed = 0;
#else
	int seed = (int)time(0);
#endif
	StochasticLib2 sto(seed);
	
	SampleManyRet_t ret;
	ret.nRuns = 0;
	ret.nCorrect = 0;
	ret.avgNk = 0;
	ret.avgNksq = 0;
	ret.avgStages = 0;
	ret.avgStagesSq = 0;
	
	
	for (int n=0; n<nRuns; n++) {
#ifdef DEBUG
		if (n % 100 == 0) {
			printf("# run=%d of %d\n", n, nRuns);
			fflush(NULL);
		}
#endif
		SampleOnceRet_t now = algorithm(sto, problem, args);
		if (now.correctSelection)
			ret.nCorrect++;
		double a = (double)ret.nRuns / (ret.nRuns + 1);
		double b = 1-a;
		ret.avgNk = ret.avgNk * a + now.nSamplesPerAlt * b;
		ret.avgNksq = ret.avgNksq * a + (now.nSamplesPerAlt * now.nSamplesPerAlt) * b;
		ret.avgStages = ret.avgStages * a + now.nStages * b;
		ret.avgStagesSq = ret.avgStagesSq * a + (now.nStages * now.nStages) * b;
		ret.nRuns++;
	}
	
	ret.estPCS = (double)ret.nCorrect/(double)ret.nRuns;
	double varPCS = ret.estPCS*(1-ret.estPCS);
	ret.stdPCS = sqrt(varPCS/ret.nRuns);
	double varNk = ret.avgNksq - (ret.avgNk*ret.avgNk);
	ret.stdNk = sqrt(varNk/(ret.nRuns-1));
	double varStages = ret.avgStagesSq - (ret.avgStages*ret.avgStages);
	ret.stdStages = sqrt(varStages/(ret.nRuns-1));
	
	out=fopen("ex2.txt","a");
	
	fprintf(out,"%f %f %f %f\n",problem.sigma[0],problem.delta, ret.estPCS, ret.stdPCS);
	fclose(out);
	
	
	printf("delta=%f PCS=%f+/-%f E[N]/k=%.3f+/-%.3f E[stages]=%.3f+/-%.3f\n", problem.sigma[0], ret.estPCS, ret.stdPCS, ret.avgNk, ret.stdNk, ret.avgStages, ret.stdStages);
}




