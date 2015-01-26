all: final quick

# includes the "improvement_final" and "improvement_quick" targets, which make
# all of the improvement files in post_processed_data/.  This .mk file was
# created by running the perl script impromevent_mk.pl, as in
# 	./improvement_mk.pl > improvement.mk
include improvement.mk

final: improvement_final BIZ_PGS
	gnuplot final_figures.gp # creates all the final files in pdf/
	gnuplot improvement.gp
	pdflatex final_summary.tex # creates final_summary.pdf

quick: improvement_quick
	gnuplot final_figures.gp # creates all the final files in pdf/
	pdflatex final_summary.tex # creates final_summary.pdf

# For each PGS problem file, on which we ran BIZ, create a file in
# post_processed_data that contains the mean of the second best alternative.
# This depends strongly on the format of the output of read_problems.
# Then, use this file, combine.pl, and the output data for that experiment to
# create BIZ_PGS*_with_mean2.txt.  Intermediate files are stored in /tmp
BIZ_PGS: post_processed_data/BIZ_PGS10_with_mean2.txt post_processed_data/BIZ_PGS100_with_mean2.txt post_processed_data/BIZ_PGS3_with_mean2.txt post_processed_data/BIZ_PGS32_with_mean2.txt

post_processed_data/BIZ_PGS10_with_mean2.txt: ../biz/read_problems ../biz/problems/PGS10.dat ../biz/data/BIZ_PGS10_final.txt
	../biz/read_problems ../biz/problems/PGS10.dat | grep means | awk '{print $$7}' > /tmp/PGS10_mean2.txt
	grep -v 'k=' ../biz/data/BIZ_PGS10_final.txt > /tmp/BIZ_PGS10_with_mean2.txt
	grep 'k=' ../biz/data/BIZ_PGS10_final.txt > /tmp/BIZ_PGS10_nohead.txt
	./combine.pl /tmp/PGS10_mean2.txt /tmp/BIZ_PGS10_nohead.txt >> /tmp/BIZ_PGS10_with_mean2.txt
	mv /tmp/BIZ_PGS10_with_mean2.txt post_processed_data/
	rm -f /tmp/BIZ_PGS10_nohead.txt /tmp/PGS10_mean2.txt

post_processed_data/BIZ_PGS100_with_mean2.txt: ../biz/read_problems ../biz/problems/PGS100.dat ../biz/data/BIZ_PGS100_final.txt
	../biz/read_problems ../biz/problems/PGS100.dat | grep means | awk '{print $$7}' > /tmp/PGS100_mean2.txt
	grep -v 'k=' ../biz/data/BIZ_PGS100_final.txt > /tmp/BIZ_PGS100_with_mean2.txt
	grep 'k=' ../biz/data/BIZ_PGS100_final.txt > /tmp/BIZ_PGS100_nohead.txt
	./combine.pl /tmp/PGS100_mean2.txt /tmp/BIZ_PGS100_nohead.txt >> /tmp/BIZ_PGS100_with_mean2.txt
	mv /tmp/BIZ_PGS100_with_mean2.txt post_processed_data/
	rm -f /tmp/BIZ_PGS100_nohead.txt /tmp/PGS100_mean2.txt

post_processed_data/BIZ_PGS3_with_mean2.txt: ../biz/read_problems ../biz/problems/PGS3.dat ../biz/data/BIZ_PGS3_final.txt
	../biz/read_problems ../biz/problems/PGS3.dat | grep means | awk '{print $$7}' > /tmp/PGS3_mean2.txt
	grep -v 'k=' ../biz/data/BIZ_PGS3_final.txt > /tmp/BIZ_PGS3_with_mean2.txt
	grep 'k=' ../biz/data/BIZ_PGS3_final.txt > /tmp/BIZ_PGS3_nohead.txt
	./combine.pl /tmp/PGS3_mean2.txt /tmp/BIZ_PGS3_nohead.txt >> /tmp/BIZ_PGS3_with_mean2.txt
	mv /tmp/BIZ_PGS3_with_mean2.txt post_processed_data/
	rm -f /tmp/BIZ_PGS3_nohead.txt /tmp/PGS3_mean2.txt

post_processed_data/BIZ_PGS32_with_mean2.txt: ../biz/read_problems ../biz/problems/PGS32.dat ../biz/data/BIZ_PGS32_final.txt
	../biz/read_problems ../biz/problems/PGS32.dat | grep means | awk '{print $$7}' > /tmp/PGS32_mean2.txt
	grep -v 'k=' ../biz/data/BIZ_PGS32_final.txt > /tmp/BIZ_PGS32_with_mean2.txt
	grep 'k=' ../biz/data/BIZ_PGS32_final.txt > /tmp/BIZ_PGS32_nohead.txt
	./combine.pl /tmp/PGS32_mean2.txt /tmp/BIZ_PGS32_nohead.txt >> /tmp/BIZ_PGS32_with_mean2.txt
	mv /tmp/BIZ_PGS32_with_mean2.txt post_processed_data/
	rm -f /tmp/BIZ_PGS32_nohead.txt /tmp/PGS32_mean2.txt
