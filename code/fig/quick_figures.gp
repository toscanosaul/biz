set term pdf monochrome fsize 16 dashed
set log x
unset log y
set xlabel 'Number of alternatives (k)'

# SC PCS
set output 'QUICK-SC-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.88:1] '../data/KN_SC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../data/BKS_SC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BKS' w l lt 2, '../data/BIZ_SC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4, '../data/BIZUNK_SC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w l lt 5

# SC E[N]/k
set output 'QUICK-SC-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../data/KN_SC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../data/BKS_SC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BKS' w l lt 2, '../data/BIZ_SC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4, '../data/BIZUNK_SC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w l lt 5

# MDM PCS
set output 'QUICK-MDM-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.88:1] '../data/KN_MDM_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../data/BKS_MDM_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BKS' w l lt 2, '../data/BIZ_MDM_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4, '../data/BIZUNK_MDM_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w l lt 5

# MDM E[N]/k
set output 'QUICK-MDM-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../data/KN_MDM_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../data/BKS_MDM_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BKS' w l lt 2, '../data/BIZ_MDM_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4, '../data/BIZUNK_MDM_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w l lt 5

# RPI PCS 
set output 'QUICK-RPI-PCSk.pdf'
set key right bottom
set ylabel 'PCS'
set arrow from 1,0.8 to 16384,0.8 nohead lt 2
plot [1:16384] [0.5:1.01] '../data/KN_RPI_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w points ps 2 pt 5, '../data/BIZUNK_RPI_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w points ps 2 pt 6
unset arrow

# RPI E[N]/k 
set output 'QUICK-RPI-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../data/KN_RPI_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w p ps 2 pt 5, '../data/BIZUNK_RPI_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w p ps 2 pt 6

# SC-INC PCS
set output 'QUICK-SCINC-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.88:1] '../data/KNHET_SC_INC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../data/BIZHET_SC_INC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4, '../data/BIZUNK_SC_INC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w l lt 5

# SC-INC E[N]/k
set output 'QUICK-SCINC-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../data/KNHET_SC_INC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../data/BIZHET_SC_INC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4, '../data/BIZUNK_SC_INC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w l lt 5

# SC-DEC PCS
set output 'QUICK-SCDEC-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.88:1] '../data/KNHET_SC_DEC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../data/BIZHET_SC_DEC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4, '../data/BIZUNK_SC_DEC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w l lt 5

# SC-DEC E[N]/k
set output 'QUICK-SCDEC-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../data/KNHET_SC_DEC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../data/BIZHET_SC_DEC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4, '../data/BIZUNK_SC_DEC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w l lt 5

# MDM-INC PCS
set output 'QUICK-MDMINC-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.88:1] '../data/KNHET_MDM_INC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../data/BIZHET_MDM_INC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4, '../data/BIZUNK_MDM_INC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w l lt 5

# MDM-INC E[N]/k
set output 'QUICK-MDMINC-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../data/KNHET_MDM_INC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../data/BIZHET_MDM_INC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4, '../data/BIZUNK_MDM_INC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w l lt 5

# MDM-DEC PCS
set output 'QUICK-MDMDEC-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.88:1] '../data/KNHET_MDM_DEC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../data/BIZHET_MDM_DEC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4, '../data/BIZUNK_MDM_DEC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w l lt 5

# MDM-DEC E[N]/k
set output 'QUICK-MDMDEC-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../data/KNHET_MDM_DEC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../data/BIZHET_MDM_DEC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4, '../data/BIZUNK_MDM_DEC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZUNK' w l lt 5




# Improvement factor vs. k
set output 'QUICK-ImprovementFactor.pdf'
set key left top
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'KN E[N] / BIZ E[N]'
set ytics (1,2,3,4)
plot [1:16384] [1:4] '../data/improvement_KN_BIZ_SC_quick.txt' u 1:2 w l lt 1 t 'SC', '../data/improvement_KN_BIZ_MDM_quick.txt' u 1:2 w l lt 2 t 'MDM', '../data/improvement_KN_BIZ_RPI_quick.txt' u 1:2 w p ps 2 pt 4 t 'RPI'


set term x11
