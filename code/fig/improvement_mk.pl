#!/usr/bin/perl -w

# Creates the file improvement.mk, which contains targets for making all of the data output files. 

@nRuns = ("500", "10000" );
@HomoProblems = ("SC", "MDM", "RPI");
@HeteroProblems = ("SC_INC", "SC_DEC", "MDM_INC", "MDM_DEC", "RPI_hetero", "SC_INCA", "SC_DECA", "MDM_INCA", "MDM_DECA", "RPI_heteroA");
@UnkProblems = (@HomoProblems, @HeteroProblems);

# This directory contains all of the raw data
$data = "../biz/data"; 



#
# improvement files.
#
foreach $run (@nRuns) {
printf("improvement_%s:\n", $run == 500 ? "quick" : "final"); # These are the targets, one for quick, and one for final.
foreach $prob (@HomoProblems) {
    $KN = sprintf("KN_%s_%s.txt", $prob, $run == 500 ? "quick" : "final");
    $BIZ = sprintf("BIZ_%s_%s.txt", $prob, $run == 500 ? "quick" : "final");
    $out = sprintf("improvement_KN_BIZ_%s_%s.txt", $prob, $run == 500 ? "quick" : "final");
    print("\t ./improvement.pl $data/$KN $data/$BIZ > post_processed_data/$out\n");
}
foreach $prob (@HeteroProblems) {
    $KN = sprintf("KNHET_%s_%s.txt", $prob, $run == 500 ? "quick" : "final");
    $BIZ = sprintf("BIZHET_%s_%s.txt", $prob, $run == 500 ? "quick" : "final");
    $out = sprintf("improvement_KNHET_BIZHET_%s_%s.txt", $prob, $run == 500 ? "quick" : "final");
    print("\t ./improvement.pl $data/$KN $data/$BIZ > post_processed_data/$out\n");
}
foreach $prob (@UnkProblems) {
    $KN = sprintf("KNUNK_%s_%s.txt", $prob, $run == 500 ? "quick" : "final");
    $BIZ = sprintf("BIZUNK_%s_%s.txt", $prob, $run == 500 ? "quick" : "final");
    $out = sprintf("improvement_KNUNK_BIZUNK_%s_%s.txt", $prob, $run == 500 ? "quick" : "final");
    print("\t ./improvement.pl $data/$KN $data/$BIZ > post_processed_data/$out\n");
}
}
print("\n");

