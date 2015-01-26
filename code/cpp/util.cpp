#include "common.h"

/* Returns a 1 if the passed selection x is correct.  Any alternative within delta of the best is considered correct. */  
int CorrectSelection(int x, int k, double theta[], double delta) {
  double max = theta[0];
  //printf("theta[%d]=%.1f ", 0, theta[0]);
  for (int i=1; i<k; i++) {
    //printf("theta[%d]=%.1f ", i, theta[i]);
    if (theta[i] > max)
      max = theta[i];
  }
  //printf("x=%d\n", x);
  if (theta[x] > max - delta)
    return 1;
  else
    return 0;
}

/* Parser for the algorithm arguments if the algorithm takes no arguments. */
int NoArgs(algArgs_t *args, int num_args, char *args_str[]) {
  if (num_args > 0) {
    fprintf(stderr, "This algorithm expects no arguments.\n");
    return -1;
  }
  if (num_args < 0) {
    fprintf(stderr, "Internal Error: args->n is less than 0\n");
    return -1;
  }

  args->args = NULL;
  args->free_args = NULL;
  args->print_args = NULL;
  return 0;
}




