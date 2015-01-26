This directory contains C++ implementations of BIZ, KN, Paulson's procedure,
and the BKS (Bechhofer, Kiefer, Sobel) procedure, in three settings (known
homogeneous variance, known heterogeneous variance, and unknown variance)
under a variety of different standard problem configurations.

The main binary created by this code is called experiments, can be called in
the following way:

	experiments {BIZ|BIZHET|BIZUNK|KN|KNHET|KNUNK|BKS|Paulson} datafile num_reps [n0=value]

The first argument is the algorithm (BIZ, KN, BKS or Paulson).  BIZ and KN have
variants that handle heterogeneous known variance (BIZHET and KNHET), and
unknown possibly heterogeneous variance (BIZUNK and KNUNK).  The arguments BIZ,
KN, BKS or Paulson all assume known homogeneous variance.

The second argument is a datafile, such as problems/SC.dat, which specifies one
or more problem configurations, to be run in order.  Problem configurations
always assume normal sampling, with either homogeneous or heterogeneous
variance.  The problem configuration also includes a specification of the
indifference-zone parameters delta and P*.  To see the problem configurations
included in a specific file, run read_problems.  E.g., to see the problem
configurations in problems/SC.dat, run 

	read_problems problems/SC.dat

The third argument is the number of independent replications to use when
running the specified algorithm on each problem configuration in the datafile.

The final n0 argument is optional and is accepted only by BIZUNK and KNUNK.
It specifies the parameter n0 used by these algorithms.

Experiments will output one line for each problem configuration, and will
report the number of alternatives k, the estimated probability of correct
selection (PCS), the estimated expected number of samples divided by the number
of alternatives, E[N]/k, and the estimated number of stages of sampling,
E[stages].  Standard errors are also reported for all estimated values.

This directory also contains a Makefile for compiling this code, and a perl script
make_experiments.pl for creating a file called experiments.mk included by the
Makefile for running all of the different algorithms on all of the different
problem configurations.

This directory also contains C++ code (read_problems.cpp and
write_problems.cpp) which, when compiled and run, creates files in the
problems/ subdirectory.  To create a new set of problem instances, edit
write_problems.cpp, recompile using the Makefile, and then run write_problems,
which will overwrite the files in problems/.

When experiments are run by the Makefile, the output is stored in data/.
Results for all of the algorithms on all of the appropriate datafiles (sets of
problem configurations) may be found there.

There is also code (BIZ_animate.cpp and KN_animate.cpp) that is useful for
creating animations of these algorithms.
