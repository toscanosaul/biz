SRC=../../../biz/
STOCDIR=../../../stocc
PROBDIR=${SRC}/problems
CFLAGS=-O3 -DOUTPUT_FOR_ANIMATION

animation.pdf: experiments ${PROBDIR}/ANIMATION.dat
	./experiments BIZ ${PROBDIR}/ANIMATION.dat 1 | grep -v 'k=' > animation.txt
	# The grep -v gets rid of the final line, where experiments reports estimated performance
	R CMD BATCH animation.R
	pdfjoin pdf1/*
	mv animation_0238-joined.pdf animation1.pdf
	pdfjoin pdf2/*
	mv animation_0238-joined.pdf animation2.pdf



clean:
	rm -f *.o experiments animation.txt

# The targets below compile the binary experiments, with -DOUTPUT_FOR_ANIMATION compiled in, and store it in this directory
experiments: experiments.o BIZ.o BIZUNK.o BIZHET.o BKS.o KN.o KNHET.o KNUNK.o Paulson.o util.o $(STOCDIR)/stoc1.o $(STOCDIR)/mersenne.o $(STOCDIR)/wnchyppr.o $(STOCDIR)/userintf.o
	g++ ${CFLAGS} -o experiments experiments.o BIZ.o BIZUNK.o BIZHET.o BKS.o KN.o KNHET.o KNUNK.o Paulson.o util.o $(STOCDIR)/stoc1.o $(STOCDIR)/mersenne.o $(STOCDIR)/wnchyppr.o $(STOCDIR)/userintf.o

experiments.o: ${SRC}/experiments.cpp
	g++ ${CFLAGS} -c ${SRC}/experiments.cpp -o experiments.o

BIZUNK.o: ${SRC}/BIZUNK.cpp
	g++ ${CFLAGS} -c ${SRC}/BIZUNK.cpp -o BIZUNK.o

BIZHET.o: ${SRC}/BIZHET.cpp
	g++ ${CFLAGS} -c ${SRC}/BIZHET.cpp -o BIZHET.o

BIZ.o: ${SRC}/BIZ.cpp
	g++ ${CFLAGS} -c ${SRC}/BIZ.cpp -o BIZ.o

BKS.o: ${SRC}/BKS.cpp
	g++ ${CFLAGS} -c ${SRC}/BKS.cpp -o BKS.o

KN.o: ${SRC}/KN.cpp
	g++ ${CFLAGS} -c ${SRC}/KN.cpp -o KN.o

KNHET.o: ${SRC}/KNHET.cpp
	g++ ${CFLAGS} -c ${SRC}/KNHET.cpp -o KNHET.o

KNUNK.o: ${SRC}/KNUNK.cpp
	g++ ${CFLAGS} -c ${SRC}/KNUNK.cpp -o KNUNK.o

Paulson.o: ${SRC}/Paulson.cpp
	g++ ${CFLAGS} -c ${SRC}/Paulson.cpp -o Paulson.o

util.o: ${SRC}/util.cpp
	g++ ${CFLAGS} -c ${SRC}/util.cpp -o util.o

$(STOCDIR)/stoc1.o: $(STOCDIR)/stoc1.cpp
	g++ ${CFLAGS} -c $(STOCDIR)/stoc1.cpp -o $(STOCDIR)/stoc1.o

$(STOCDIR)/userintf.o: $(STOCDIR)/userintf.cpp
	g++ ${CFLAGS} -c $(STOCDIR)/userintf.cpp -o $(STOCDIR)/userintf.o

$(STOCDIR)/mersenne.o: $(STOCDIR)/mersenne.cpp
	g++ ${CFLAGS} -c $(STOCDIR)/mersenne.cpp -o $(STOCDIR)/mersenne.o


$(STOCDIR)/wnchyppr.o: $(STOCDIR)/wnchyppr.cpp
	g++ ${CFLAGS} -c $(STOCDIR)/wnchyppr.cpp -o $(STOCDIR)/wnchyppr.o

