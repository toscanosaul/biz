#ifndef _KN_H_
#define _KN_H_

#include "common.h"

SampleOnceRet_t KN(StochasticLib2 &sto, problem_t problem, algArgs_t args); // known, common variance
SampleOnceRet_t KNHET(StochasticLib2 &sto, problem_t problem, algArgs_t args); // known, heterogeneous variance
SampleOnceRet_t KNUNK(StochasticLib2 &sto, problem_t problem, algArgs_t args); // unknown and possibly heterogeneous variance

SampleOnceRet_t SampleOnceKNHelper(StochasticLib2 &sto, int k, double pstar, double delta, double theta[], double sigma[], bool varknown, int n0);

int KNUNK_ParseArgs(algArgs_t *args, int num_args, char *args_str[]);
void KNUNK_FreeArgs(void *args);
void KNUNK_PrintArgs(void *args);
#endif /* _KN_H_ */
