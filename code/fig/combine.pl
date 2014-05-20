#!/usr/bin/perl -w
use strict;

# This perl script takes as input two files, both of which have the same number
# of lines N, and outputs to stdout N lines, where each line n is created by
# concatenating row n from file 1 with row n of file 2. 

my $num_args = $#ARGV + 1;
if ($num_args 	!= 2) {
  die "usage: ./combine.pl file1 file2";
}

open FILE_A, $ARGV[0] or die $!;
open FILE_B, $ARGV[1] or die $!;

while (1) {
  my $lineA = <FILE_A>;
  my $lineB = <FILE_B>;

  if (!$lineA && !$lineB) { last; }
  if (!$lineA || !$lineB) { die "Files have different numbers of data rows."; }

  chomp($lineA);
  chomp($lineB);

  print $lineA . " " . $lineB . "\n";
}
