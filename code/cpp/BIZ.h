/* BIZ with maximum elimination, with common known variance. */

#ifndef _BIZ_H_
#define _BIZ_H_

#include "common.h"
#include <string.h>

// void name_BIZ();
// void name_BIZHET();
// void name_BIZUNK();

SampleOnceRet_t BIZ(StochasticLib2 &sto, problem_t problem, algArgs_t args); // common known variance
// Algorithm accepts no arguments

SampleOnceRet_t BIZHET(StochasticLib2 &sto, problem_t problem, algArgs_t args); // known and possibly heterogeneous variance
// Algorithm accepts no arguments

SampleOnceRet_t BIZUNK(StochasticLib2 &sto, problem_t problem, algArgs_t args); // unknown and possibly heterogeneous variance
int BIZUNK_ParseArgs(algArgs_t *args, int num_args, char *args_str[]);
void BIZUNK_FreeArgs(void *args);
void BIZUNK_PrintArgs(void *args);

#endif /* _BIZ_H_ */
