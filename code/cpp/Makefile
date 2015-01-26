STOCDIR=../stocc
FIGDIR=../../fig
CFLAGS=-pg -g

# These creates all of the binaries and supporting structure, but does not
# actually run any of the computational experiments.  To do that, use the
# targets at the bottom of experiments.mk.  For example, to run all of the
# experiments, you can run homo_final (all homogeneous variance experiments), 
# hetero_final (all known heterogeneous variance experiments), and unk_final
# (all unknown variance experiments).
all: write_problems read_problems experiments experiments.mk problem_files

# BINARIES
write_problems: write_problems.o $(STOCDIR)/stoc1.o $(STOCDIR)/mersenne.o $(STOCDIR)/wnchyppr.o $(STOCDIR)/userintf.o
	g++ ${CFLAGS} -o write_problems write_problems.o $(STOCDIR)/stoc1.o $(STOCDIR)/mersenne.o $(STOCDIR)/wnchyppr.o $(STOCDIR)/userintf.o

read_problems: read_problems.o $(STOCDIR)/stoc1.o $(STOCDIR)/mersenne.o $(STOCDIR)/wnchyppr.o $(STOCDIR)/userintf.o
	g++ ${CFLAGS} -o read_problems read_problems.o $(STOCDIR)/stoc1.o $(STOCDIR)/mersenne.o $(STOCDIR)/wnchyppr.o $(STOCDIR)/userintf.o

experiments: experiments.o BIZ.o BIZUNK.o BIZHET.o BKS.o KN.o KNHET.o KNUNK.o Paulson.o util.o $(STOCDIR)/stoc1.o $(STOCDIR)/mersenne.o $(STOCDIR)/wnchyppr.o $(STOCDIR)/userintf.o
	g++ ${CFLAGS} -o experiments experiments.o BIZ.o BIZUNK.o BIZHET.o BKS.o KN.o KNHET.o KNUNK.o Paulson.o util.o $(STOCDIR)/stoc1.o $(STOCDIR)/mersenne.o $(STOCDIR)/wnchyppr.o $(STOCDIR)/userintf.o

# CLEAN
clean:
	rm -f *.o $(STOCDIR)/*.o experiments read_problems write_problems

really_clean: clean
	rm -f problems/*.dat experiments.mk

#
# PROBLEM FILES (in problems/)
# You only need to run this target if these .dat files are not present, e.g.,
# because you ran make really_clean
#
problem_files: 
	./write_problems

#
# EXPERIMENTAL RESULTS FILES (in data/)
# Take a look at experiments.mk, and in particular at the targets near the bottom like 
# homo_quick, homo_final, hetero_quick, hetero_final, unk_quick, unk_final.
# This makefile contains all of the targets for all of the output stored in data/
#
experiments.mk: make_experiments.pl
	./make_experiments.pl > experiments.mk

include experiments.mk


#
# OBJECT FILES
# This actually compiles the object files for read_problems, write_problems, and experiments 
#

read_problems.o: read_problems.cpp
	g++ ${CFLAGS} -c read_problems.cpp -o read_problems.o

write_problems.o: write_problems.cpp
	g++ ${CFLAGS} -c write_problems.cpp -o write_problems.o

experiments.o: experiments.cpp
	g++ ${CFLAGS} -c experiments.cpp -o experiments.o

BIZUNK.o: BIZUNK.cpp
	g++ ${CFLAGS} -c BIZUNK.cpp -o BIZUNK.o

BIZHET.o: BIZHET.cpp
	g++ ${CFLAGS} -c BIZHET.cpp -o BIZHET.o

BIZ.o: BIZ.cpp
	g++ ${CFLAGS} -c BIZ.cpp -o BIZ.o

BKS.o: BKS.cpp
	g++ ${CFLAGS} -c BKS.cpp -o BKS.o

KN.o: KN.cpp
	g++ ${CFLAGS} -c KN.cpp -o KN.o

KNHET.o: KNHET.cpp
	g++ ${CFLAGS} -c KNHET.cpp -o KNHET.o

KNUNK.o: KNUNK.cpp
	g++ ${CFLAGS} -c KNUNK.cpp -o KNUNK.o

Paulson.o: Paulson.cpp
	g++ ${CFLAGS} -c Paulson.cpp -o Paulson.o

util.o: util.cpp
	g++ ${CFLAGS} -c util.cpp -o util.o

$(STOCDIR)/stoc1.o: $(STOCDIR)/stoc1.cpp
	g++ ${CFLAGS} -c $(STOCDIR)/stoc1.cpp -o $(STOCDIR)/stoc1.o

$(STOCDIR)/userintf.o: $(STOCDIR)/userintf.cpp
	g++ ${CFLAGS} -c $(STOCDIR)/userintf.cpp -o $(STOCDIR)/userintf.o

$(STOCDIR)/mersenne.o: $(STOCDIR)/mersenne.cpp
	g++ ${CFLAGS} -c $(STOCDIR)/mersenne.cpp -o $(STOCDIR)/mersenne.o


$(STOCDIR)/wnchyppr.o: $(STOCDIR)/wnchyppr.cpp
	g++ ${CFLAGS} -c $(STOCDIR)/wnchyppr.cpp -o $(STOCDIR)/wnchyppr.o
