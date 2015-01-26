This directory contains scripts for processing the data in ../biz/data to create figures.

You can run all of these scripts by typing "make". The figures created will be
in pdf/, and they can be viewed all together in a convenient way by viewing the
final_summary.pdf file, which shows results for the 10000 replication runs,
(and also the quick_summary.pdf, which shows results for the shorter runs).


Here is a description of the files:

Makefile: puts the scripts together to create the figure files.

combine.pl: a perl script for combining two files together, line by line, used
to create the post_processed_data/BIZ_PGS*_with_mean2.txt files.  This is used
by Makefile.

custom_figures: custom figure code used to create figures for various
conferences.  Some of these directories are messy.

final_figures.gp: a gnuplot script that creates all of the figures labeled
FINAL in pdf/, except for the "ImprovementFactor" figures (created by
improvement.gp).  It uses data in post_processed_data, and in ../biz/data.

final_figures_eps.gp: like final_figures.gp, except creates eps files rather
than pdf. 

improvement.gp: a gnuplot script that creates the "ImprovementFactor" figures
in pdf/.  It uses data in post_processed_data created by the targets in
improvement.mk (called by Makefile), which in turn uses improvement.pl and is
created by improvement_mk.pl

improvement.mk: a set of makefile targets, included by Makefile, for creating
the improvement files in post_processed_data/.  All of these post-processed
data files are created by comparing the performance of two algorithms on the
same problems, and taking the ratio of E[N]/k.  This data comes from
../biz/data.

improvement.pl: A perl script used by the targets in improvement.mk

improvement_mk.pl: A perl script for creating the file improvement.mk.

final_summary.tex: A tex file that creates final_figures.pdf, which combines
together, in an easy to view way, all of the figures in pdf/ created with the
"final" data, i.e., data with 10000 replications.

final_summary.aux,  final_summary.log: temporary files created by latex when
creating final_summary.pdf.

final_summary.pdf: A summary of all of the figures in pdf/ created with final
data.

pdf/: This directory contains figures created by the gnuplot scripts in this
directory, such as final_figures.gp and improvement.gp

post_processed_data/: This directory contains data created by processing the
raw data, in ../biz/data/

quick_figures.gp quick_summary.aux quick_summary.log quick_summary.pdf quick_summary.tex:
These files do the same thing as final_figures.gp, except they are for the
"quick" data files, which were created using fewer replications.


BUGS
final_figures_eps.gp needs to be cleaned up, to match final_figures.gp
final_figures.gp is using quick for some of the known heterogeneous variance plots.
quick_figures.* should probably be deleted, as well as associated quick targets
in the Makefile, and pdf/QUICK* post_processed_data/*_quick, since we aren't
maintaining these.
