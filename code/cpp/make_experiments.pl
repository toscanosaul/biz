#!/usr/bin/perl -w

# Creates the file experiments.mk, which contains targets for making all of the data output files. 


@nRuns = ("500", "10000" );
@HomoAlgorithms = ( "BIZ", "KN", "BKS", "Paulson");
@HeteroAlgorithms = ( "BIZHET", "KNHET");
@UnkAlgorithms = ( "BIZUNK", "KNUNK");
@HomoProblems = ("SC", "MDM", "RPI");
@HeteroProblems = ("SC_INC", "SC_DEC", "MDM_INC", "MDM_DEC", "RPI_hetero", "SC_INCA", "SC_DECA", "MDM_INCA", "MDM_DECA", "RPI_heteroA");
@UnkProblems = (@HomoProblems, @HeteroProblems);

@PgsAlgorithms = ("BIZ");
@PgsProblems = ("PGS3", "PGS10", "PGS100", "PGS32", "RPI_PGS");


# Common variance experiments:
# BIZ, KN, BKS, Paulson against SC, MDM, RPI.
# In quick, final, and proof versions.
# 4*3*2=24 experiments
#
foreach $alg (@HomoAlgorithms) {
  foreach $prob (@HomoProblems) {
    foreach $run (@nRuns) {
      $filename = sprintf("%s_%s_%s.txt", $alg, $prob, $run == 500 ? "quick" : "final");
      print("data/$filename: experiments $alg.cpp problems/$prob.dat\n");
      print("\t./experiments $alg problems/$prob.dat $run > data/$filename\n");
      print("\n");
    }
  }
}

#
# Heterogeneous known variance experiments:
# BIZHET, KNHET against 
# SC_INC, SC_DEC, MDM_INC, MDM_DEC, RPI_hetero,
# SC_INCA, SC_DECA, MDM_INCA, MDM_DECA, RPI_heteroA.
# In both quick and final versions.
# 2*5*2=20 experiments
#
foreach $alg (@HeteroAlgorithms) {
  foreach $prob (@HeteroProblems) {
    foreach $run (@nRuns) {
      $filename = sprintf("%s_%s_%s.txt", $alg, $prob, $run == 500 ? "quick" : "final");
      print("data/$filename: experiments $alg.cpp problems/$prob.dat\n");
      print("\t./experiments $alg problems/$prob.dat $run > data/$filename\n");
      print("\n");
    }
  }
}

#
# Unknown variance experiments:
# BIZUNK, KNUNK against SC, MDM, RPI, 
# SC_INC, SC_DEC, MDM_INC, MDM_DEC, RPI_hetero.
# SC_INCA, SC_DECA, MDM_INCA, MDM_DECA, RPI_heteroA.
# In both quick and final versions.
# 2*8*2=32 experiments
#
foreach $alg (@UnkAlgorithms) {
  foreach $prob (@UnkProblems) {
    foreach $run (@nRuns) {
      $filename = sprintf("%s_%s_%s.txt", $alg, $prob, $run == 500 ? "quick" : "final");
      print("data/$filename: experiments $alg.cpp problems/$prob.dat\n");
      print("\t./experiments $alg problems/$prob.dat $run > data/$filename\n");
      print("\n");
    }
  }
}

# PGS experiments
# BIZ against PGS32,
# In both quick and final versions.
foreach $alg (@PgsAlgorithms) {
  foreach $prob (@PgsProblems) {
    foreach $run (@nRuns) {
      $filename = sprintf("%s_%s_%s.txt", $alg, $prob, $run == 500 ? "quick" : "final");
      print("data/$filename: experiments $alg.cpp problems/$prob.dat\n");
      print("\t./experiments $alg problems/$prob.dat $run > data/$filename\n");
      print("\n");
    }
  }
}



#
# Easy to use targets
#

print("homo_quick:");
foreach $alg (@HomoAlgorithms) {
  foreach $prob (@HomoProblems) {
      printf(" data/%s_%s_quick.txt", $alg, $prob);
  }
}
print("\n\n");

print("homo_final:");
foreach $alg (@HomoAlgorithms) {
  foreach $prob (@HomoProblems) {
      printf(" data/%s_%s_final.txt", $alg, $prob);
  }
}
print("\n\n");

print("hetero_quick:");
foreach $alg (@HeteroAlgorithms) {
  foreach $prob (@HeteroProblems) {
      printf(" data/%s_%s_quick.txt", $alg, $prob);
  }
}
print("\n\n");

print("hetero_final:");
foreach $alg (@HeteroAlgorithms) {
  foreach $prob (@HeteroProblems) {
      printf(" data/%s_%s_final.txt", $alg, $prob);
  }
}
print("\n\n");

print("unk_quick:");
foreach $alg (@UnkAlgorithms) {
  foreach $prob (@UnkProblems) {
      printf(" data/%s_%s_quick.txt", $alg, $prob);
  }
}
print("\n\n");

print("unk_final:");
foreach $alg (@UnkAlgorithms) {
  foreach $prob (@UnkProblems) {
      printf(" data/%s_%s_final.txt", $alg, $prob);
  }
}
print("\n\n");



#
# For each problem, create a target for running all algorithms against that problem.  
# For each algorithm, create a target for running that algorithm against all problems.
#
foreach $run (@nRuns) {
  $runname = ($run == 500 ? "quick" : "final");
  foreach $prob (@HomoProblems) {
    printf("%s_%s:", $prob, $runname);
    foreach $alg (@HomoAlgorithms,@UnkAlgorithms) { 
      $filename = sprintf("%s_%s_%s.txt", $alg, $prob, $runname);
      print(" data/$filename"); 
    }
    print("\n\n");
}
foreach $prob (@HeteroProblems) {
    printf("%s_%s:", $prob, $runname);
    foreach $alg (@HeteroAlgorithms,@UnkAlgorithms) { 
      $filename = sprintf("%s_%s_%s.txt", $alg, $prob, $runname);
      print(" data/$filename"); 
    }
    print("\n\n");
  }
  foreach $alg (@HomoAlgorithms) {
    printf("%s_%s:", $alg, $runname);
    foreach $prob (@HomoProblems) {
      $filename = sprintf("%s_%s_%s.txt", $alg, $prob, $runname);
      print(" data/$filename"); 
    }
    print("\n\n");
  }
  foreach $alg (@HeteroAlgorithms) {
    printf("%s_%s:", $alg, $runname);
    foreach $prob (@HeteroProblems) {
      $filename = sprintf("%s_%s_%s.txt", $alg, $prob, $runname);
      print(" data/$filename"); 
    }
    print("\n\n");
  }
  foreach $alg (@UnkAlgorithms) { 
    printf("%s_%s:", $alg, $runname);
    foreach $prob (@UnkProblems) {
      $filename = sprintf("%s_%s_%s.txt", $alg, $prob, $runname);
      print(" data/$filename"); 
    }
    print("\n\n");
  }
}
