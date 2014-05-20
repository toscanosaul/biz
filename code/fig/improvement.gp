set term pdf monochrome fsize 14 dashed 
set log x
unset log y
set xlabel 'Number of alternatives (k)'

#
# Improvement factor vs. k
#
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ytics (0,1,2,3,4)

# Common known variance (3)
set output 'pdf/FINAL-Common-Known-ImprovementFactor.pdf'
set key left top
set ylabel 'KN E[N] / BIZ E[N]'
plot [1:16384] [0:4] 'post_processed_data/improvement_KN_BIZ_SC_final.txt' u 1:2 w l lt 1 t 'SC', 'post_processed_data/improvement_KN_BIZ_MDM_final.txt' u 1:2 w l lt 2 t 'MDM', 'post_processed_data/improvement_KN_BIZ_RPI_final.txt' u 1:2 w p ps 1 pt 1 t 'RPI'

# Heterogeneous known variance, version A (factor of 2 in variance between largest and smallest) (5)
set output 'pdf/FINAL-HeteroA-Known-ImprovementFactor.pdf'
set key left top
set ylabel 'KN E[N] / BIZ E[N]'
plot [1:16384] [0:7] 'post_processed_data/improvement_KNHET_BIZHET_SC_INCA_final.txt' u 1:2 w l lt 1 t 'SC-INCA', 'post_processed_data/improvement_KNHET_BIZHET_SC_DECA_final.txt' u 1:2 w l lt 2 t 'SC-DECA', 'post_processed_data/improvement_KNHET_BIZHET_MDM_INCA_final.txt' u 1:2 w l lt 3 t 'MDM-INCA', 'post_processed_data/improvement_KNHET_BIZHET_MDM_DECA_final.txt' u 1:2 w l lt 4 t 'MDM-DECA', 'post_processed_data/improvement_KNHET_BIZHET_RPI_heteroA_final.txt' u 1:2 w p ps 1 pt 1 t 'RPI-HETA'

# Heterogeneous known variance (factor of 16 in variance between largest and smallest)
set output 'pdf/FINAL-Hetero-Known-ImprovementFactor.pdf'
set key left top
set ylabel 'KN E[N] / BIZ E[N]'
plot [1:16384] [0:7] 'post_processed_data/improvement_KNHET_BIZHET_SC_INC_final.txt' u 1:2 w l lt 1 t 'SC-INC', 'post_processed_data/improvement_KNHET_BIZHET_SC_DEC_final.txt' u 1:2 w l lt 2 t 'SC-DEC', 'post_processed_data/improvement_KNHET_BIZHET_MDM_INC_final.txt' u 1:2 w l lt 3 t 'MDM-INC', 'post_processed_data/improvement_KNHET_BIZHET_MDM_DEC_final.txt' u 1:2 w l lt 4 t 'MDM-DEC', 'post_processed_data/improvement_KNHET_BIZHET_RPI_hetero_final.txt' u 1:2 w p ps 1 pt 1 t 'RPI-HET'

# Common unknown variance (3)
set output 'pdf/FINAL-Common-Unknown-ImprovementFactor.pdf'
set key left top
set ylabel 'KN-UNK E[N] / BIZ-UNK E[N]'
plot [1:16384] [0:4] 'post_processed_data/improvement_KNUNK_BIZUNK_SC_final.txt' u 1:2 w l lt 1 t 'SC', 'post_processed_data/improvement_KNUNK_BIZUNK_MDM_final.txt' u 1:2 w l lt 2 t 'MDM', 'post_processed_data/improvement_KNUNK_BIZUNK_RPI_final.txt' u 1:2 w p ps 1 pt 1 t 'RPI'

# Heterogeneous unknown variance, version A (factor of 2 between largest & smallest variances) (5)
set output 'pdf/FINAL-HeteroA-Unknown-ImprovementFactor.pdf'
set key left top
set ylabel 'KN-UNK E[N] / BIZ-UNK E[N]'
plot [1:16384] [0:4] 'post_processed_data/improvement_KNUNK_BIZUNK_SC_INCA_final.txt' u 1:2 w l lt 1 t 'SC-INCA', 'post_processed_data/improvement_KNUNK_BIZUNK_SC_DECA_final.txt' u 1:2 w l lt 2 t 'SC-DECA', 'post_processed_data/improvement_KNUNK_BIZUNK_MDM_INCA_final.txt' u 1:2 w l lt 3 t 'MDM-INCA', 'post_processed_data/improvement_KNUNK_BIZUNK_MDM_DECA_final.txt' u 1:2 w l lt 4 t 'MDM-DECA', 'post_processed_data/improvement_KNUNK_BIZUNK_RPI_heteroA_final.txt' u 1:2 w p ps 1 pt 1 t 'RPI-HETA'


# Heterogeneous unknown variance, factor of 16 between largest and smallest variances
set output 'pdf/FINAL-Hetero-Unknown-ImprovementFactor.pdf'
set key left top
set ylabel 'KN-UNK E[N] / BIZ-UNK E[N]'
plot [1:16384] [0:4] 'post_processed_data/improvement_KNUNK_BIZUNK_SC_INC_final.txt' u 1:2 w l lt 1 t 'SC-INC', 'post_processed_data/improvement_KNUNK_BIZUNK_SC_DEC_final.txt' u 1:2 w l lt 2 t 'SC-DEC', 'post_processed_data/improvement_KNUNK_BIZUNK_MDM_INC_final.txt' u 1:2 w l lt 3 t 'MDM-INC', 'post_processed_data/improvement_KNUNK_BIZUNK_MDM_DEC_final.txt' u 1:2 w l lt 4 t 'MDM-DEC', 'post_processed_data/improvement_KNUNK_BIZUNK_RPI_hetero_final.txt' u 1:2 w p ps 1 pt 1 t 'RPI-HET'


set term x11
