#include "KN.h"

SampleOnceRet_t KNUNK(StochasticLib2 &sto, problem_t problem, algArgs_t args) {
  int n0 = *(int *)(args.args);
  return SampleOnceKNHelper(sto, problem.k, problem.pstar, problem.delta, problem.theta, problem.sigma, 0, n0);
}

void KNUNK_FreeArgs(void *args) { free(args); }
void KNUNK_PrintArgs(void *args) { 
  int n0 = *(int *)(args);
  printf("# KNUNK n0 = %d\n", n0);
}


int KNUNK_ParseArgs(algArgs_t *args, int num_args, char *args_str[]) {
  int n0;


  if (num_args > 1) {
    fprintf(stderr, "KNUNK requires at most 1 argument.\n");
    return -1;
  }

  // Default value for n0 is 30
  if (num_args == 0) 
    n0 = 30;

  if (num_args == 1) {
    int ret = sscanf(args_str[0],"n0=%d", &n0);
    if (ret != 1) {
      fprintf(stderr, "Argument to KNUNK must be of the form \"n0=integer\".\n");
      return -1;
    }
  }

  args->args = malloc(sizeof(int));
  if (args->args == NULL) {
    perror("Out of memory");
    return -1;
  }
  *(int *)(args->args) = n0;

  args->print_args = &KNUNK_PrintArgs;
  args->free_args = &KNUNK_FreeArgs;

    return 0;
}
