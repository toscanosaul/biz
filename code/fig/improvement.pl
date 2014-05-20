#!/usr/bin/perl -w
use strict;

# This perl script takes as input two files, such as KN_SC_final.txt and BIZ_SC_final.txt, each of which is assumed
# to have the performance of a single policy on a fixed sequence of problems.  So row n in each file corresponds to the
# same problem.  It outputs a file in which the record at line n corresponds to this same problem, and has the ratio of
# the performance of the two 
# 
# Warning: this perl script is not very robust, and relies heavily on the particular file format used to create these
# input text files.
# example use: ./improvement.pl ../biz/data/Paulson_SC_final.txt ../biz/data/BIZ_SC_final.txt > post_processed_data/improvement_Paulson_BIZ_SC.txt

my $num_args = $#ARGV + 1;
if ($num_args 	!= 2) {
  die "usage: ./improvement.pl file1 file2";
}

# If the files aren't present, print that they aren't there, and produce no
# output, but don't report an error status because this makes it difficult to
# use these within a Makefile --- we want to skip those files that aren't there.

if (! -e $ARGV[0]) {
  print STDERR "WARNING from improvement.pl: $ARGV[0] doesn't exist --- producing no output.\n";
  exit;
}
if (! -e $ARGV[1]) {
  print STDERR "WARNING from improvement.pl: $ARGV[1] doesn't exist --- producing no output.\n";
  exit;
}



open FILE_A, $ARGV[0] or die $!;
open FILE_B, $ARGV[1] or die $!;

while (1) {
  my $lineA = <FILE_A>;
  my $lineB = <FILE_B>;

  if (!$lineA && !$lineB) { last; }
  if (!$lineA || !$lineB) { die "Files have different numbers of data rows."; }

  while($lineA =~ /^#/) { $lineA = <FILE_A>; }
  while($lineB =~ /^#/) { $lineB = <FILE_B>; }

  if (!$lineA && !$lineB) { last; }
  if (!$lineA || !$lineB) { die "Files have different numbers of data rows."; }

  my $k_B;
  my $ENk_B;
  my $ENkerr_B;
  my $k_A;
  my $ENk_A;
  my $ENkerr_A;

  if ($lineA =~ /k=(\d+) PCS=([\.\d]+)\+\/\-([\.\d]+) E\[N\]\/k=([\.\d]+)\+\/\-([\.\d]+) /) {
    $k_A = $1;
    $ENk_A = $4;
    $ENkerr_A = $5;
  }
  if ($lineB =~ /k=(\d+) PCS=([\.\d]+)\+\/\-([\.\d]+) E\[N\]\/k=([\.\d]+)\+\/\-([\.\d]+) /) {
    $k_B = $1;
    $ENk_B = $4;
    $ENkerr_B = $5;
  }

  if ($k_A != $k_B) { die "Values of k in files do not match"; }

  my $improvement = $ENk_A / $ENk_B;
  # The standard error of z=x/y is sqrt((dz/dx)^2 sigma_x^2 + (dz/dy)^2 sigma_y^2) = sqrt(1/y^2 + x^2/y^4) = sqrt(y^2*sigma_x^2 + x^2*sigma_y^2)/y^2
  my $t = ($ENk_A*$ENkerr_B) ** 2 + ($ENk_B*$ENkerr_B) ** 2;
  my $stderr = sqrt($t) / ($ENk_B**2);

  print $k_A . " " . $improvement . " " . $stderr . "\n";
  }
