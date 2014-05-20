#ifndef _COMMON_H_
#define _COMMON_H_

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>
#include <math.h>
#include "../stocc/stocc.h"

// A ranking and selection problem.
typedef struct problem {
  int k;
  double pstar;
  double delta;
  double *theta;
  double *sigma;
} problem_t;

// Return types for information from a simulation.
typedef struct SampleOnceRet {
  int correctSelection; 
  double nSamplesPerAlt; // This is N / k, where N is the number of samples.
  double nSamples; // This is N, the number of samples.
  int nStages;
} SampleOnceRet_t;

/* Arguments to an algorithm. */
typedef void(*free_algArgs_t)(void *); // function type for freeing the void * stored in an algArgs_t.
typedef void(*print_algArgs_t)(void *); // function type for printing the contents of the algArgs_t.
typedef struct algArgs {
  void *args; 			// flexible representation of arguments.  Created by the algorithm's parser.
  print_algArgs_t print_args;	// prints the contents of this algArgs.
  free_algArgs_t free_args; 	// function for freeing the space allocated to the 
  				// void *args.  Set to NULL if there is no space allocated to args.
} algArgs_t;

/*
 * Parser for algArgs_t for algorithms that take no arguments. 
 */
int NoArgs(algArgs_t *args, int num_args, char *args_str[]);

/* Definition of an algorithm. */
typedef SampleOnceRet_t(*algorithm_t)(StochasticLib2 &sto, problem_t problem, algArgs_t args);

/* Returns a 1 if the passed selection x is correct.  Any alternative within delta of the best is considered correct. */  
int CorrectSelection(int x, int k, double theta[], double delta);

#endif /* _COMMON_H_ */
