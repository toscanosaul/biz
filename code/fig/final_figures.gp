set term pdf monochrome fsize 14 dashed 
set log x
unset log y
set xlabel 'Number of alternatives (k)'

#
# common known variance plots.
#

# SC E[N]/k
set output 'pdf/FINAL-SC-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] [0:2200] '../biz/data/KN_SC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BKS_SC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BKS' w l lt 2, '../biz/data/BIZ_SC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# SC PCS
set output 'pdf/FINAL-SC-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.88:1] '../biz/data/KN_SC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BKS_SC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BKS' w l lt 2, '../biz/data/BIZ_SC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# MDM E[N]/k
set output 'pdf/FINAL-MDM-Nk.pdf'
set key right center
set ylabel 'E[N]/k'
plot [1:16384] '../biz/data/KN_MDM_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BKS_MDM_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BKS' w l lt 2, '../biz/data/BIZ_MDM_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# MDM PCS
set output 'pdf/FINAL-MDM-PCS.pdf'
set key right top
set ylabel 'PCS'
plot [1:16384] [0.88:1] '../biz/data/KN_MDM_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BKS_MDM_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BKS' w l lt 2, '../biz/data/BIZ_MDM_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# RPI E[N]/k 
set output 'pdf/FINAL-RPI-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../biz/data/KN_RPI_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w p ps 2 pt 5, '../biz/data/BIZ_RPI_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w p ps 2 pt 6

# RPI PCS 
set output 'pdf/FINAL-RPI-PCS.pdf'
set key right center
set ylabel 'PCS'
# set arrow from 1,0.8 to 16384,0.8 nohead lt 2
plot [1:16384] [0.75:1.01] '../biz/data/KN_RPI_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w points ps 2 pt 5, '../biz/data/BIZ_RPI_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w points ps 2 pt 6
# unset arrow



#
# heterogeneous known variance plots.
#

# Uses the "quick" biz/data files, because the "final" versions for several of
# these files are unavailable.  We are not using these plots in the paper.


# SC-INCA E[N]/k
set output 'pdf/FINAL-SCINCA-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../biz/data/KNHET_SC_INCA_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_SC_INCA_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# SC-INCA PCS
set output 'pdf/FINAL-SCINCA-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNHET_SC_INCA_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_SC_INCA_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# SC-DECA E[N]/k
set output 'pdf/FINAL-SCDECA-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../biz/data/KNHET_SC_DECA_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_SC_DECA_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# SC-DECA PCS
set output 'pdf/FINAL-SCDECA-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNHET_SC_DECA_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_SC_DECA_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# MDM-INCA E[N]/k
set output 'pdf/FINAL-MDMINCA-Nk.pdf'
set key right top
set ylabel 'E[N]/k'
plot [1:16384] '../biz/data/KNHET_MDM_INCA_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_MDM_INCA_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# MDM-INCA PCS
set output 'pdf/FINAL-MDMINCA-PCS.pdf'
set key right top
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNHET_MDM_INCA_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_MDM_INCA_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# MDM-DECA E[N]/k
set output 'pdf/FINAL-MDMDECA-Nk.pdf'
set key right top
set ylabel 'E[N]/k'
plot [1:16384] '../biz/data/KNHET_MDM_DECA_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_MDM_DECA_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# MDM-DECA PCS
set output 'pdf/FINAL-MDMDECA-PCS.pdf'
set key right top
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNHET_MDM_DECA_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_MDM_DECA_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# RPI-HETA E[N]/k 
set output 'pdf/FINAL-RPIHETA-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../biz/data/KNHET_RPI_heteroA_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w p ps 2 pt 5, '../biz/data/BIZHET_RPI_heteroA_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w p ps 2 pt 6

# RPI-HETA PCS 
set output 'pdf/FINAL-RPIHETA-PCS.pdf'
set key right center
set ylabel 'PCS'
# set arrow from 1,0.8 to 16384,0.8 nohead lt 2
plot [1:16384] [0.75:1.01] '../biz/data/KNHET_RPI_heteroA_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w points ps 2 pt 5, '../biz/data/BIZHET_RPI_heteroA_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w points ps 2 pt 6
# unset arrow

# SC-INC E[N]/k
set output 'pdf/FINAL-SCINC-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../biz/data/KNHET_SC_INC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_SC_INC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# SC-INC PCS
set output 'pdf/FINAL-SCINC-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNHET_SC_INC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_SC_INC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# SC-DEC E[N]/k
set output 'pdf/FINAL-SCDEC-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../biz/data/KNHET_SC_DEC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_SC_DEC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# SC-DEC PCS
set output 'pdf/FINAL-SCDEC-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNHET_SC_DEC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_SC_DEC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# MDM-INC E[N]/k
set output 'pdf/FINAL-MDMINC-Nk.pdf'
set key right top
set ylabel 'E[N]/k'
plot [1:16384] '../biz/data/KNHET_MDM_INC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_MDM_INC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# MDM-INC PCS
set output 'pdf/FINAL-MDMINC-PCS.pdf'
set key right top
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNHET_MDM_INC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_MDM_INC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# MDM-DEC E[N]/k
set output 'pdf/FINAL-MDMDEC-Nk.pdf'
set key right top
set ylabel 'E[N]/k'
plot [1:16384] '../biz/data/KNHET_MDM_DEC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_MDM_DEC_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# MDM-DEC PCS
set output 'pdf/FINAL-MDMDEC-PCS.pdf'
set key right top
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNHET_MDM_DEC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, '../biz/data/BIZHET_MDM_DEC_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4

# RPI-HET E[N]/k 
set output 'pdf/FINAL-RPIHET-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] '../biz/data/KNHET_RPI_hetero_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w p ps 2 pt 5, '../biz/data/BIZHET_RPI_hetero_quick.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w p ps 2 pt 6

# RPI-HETA PCS 
set output 'pdf/FINAL-RPIHET-PCS.pdf'
set key right center
set ylabel 'PCS'
# set arrow from 1,0.8 to 16384,0.8 nohead lt 2
plot [1:16384] [0.75:1.01] '../biz/data/KNHET_RPI_hetero_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w points ps 2 pt 5, '../biz/data/BIZHET_RPI_hetero_quick.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w points ps 2 pt 6
# unset arrow






#
# unknown variance plots.
#

# SC E[N]/k
set output 'pdf/FINAL-UNK-SC-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] [0:2200] '../biz/data/KNUNK_SC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_SC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# SC PCS
set output 'pdf/FINAL-UNK-SC-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNUNK_SC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_SC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# MDM E[N]/k
set output 'pdf/FINAL-UNK-MDM-Nk.pdf'
set key right top
set ylabel 'E[N]/k'
plot [1:16384] [0:300] '../biz/data/KNUNK_MDM_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_MDM_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# MDM PCS
set output 'pdf/FINAL-UNK-MDM-PCS.pdf'
set key right bottom
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNUNK_MDM_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_MDM_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# RPI E[N]/k 
set output 'pdf/FINAL-UNK-RPI-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] [0:3000] '../biz/data/KNUNK_RPI_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w p ps 2 pt 5, '../biz/data/BIZUNK_RPI_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w p ps 2 pt 6

# RPI PCS 
set output 'pdf/FINAL-UNK-RPI-PCS.pdf'
set key right bottom
set ylabel 'PCS'
# set arrow from 1,0.8 to 16384,0.8 nohead lt 2
plot [1:16384] [0.75:1.01] '../biz/data/KNUNK_RPI_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w points ps 2 pt 5, '../biz/data/BIZUNK_RPI_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w points ps 2 pt 6
# unset arrow


#
# hetero unknown
# 


# SC-INCA E[N]/k
set output 'pdf/FINAL-UNK-SCINCA-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] [0:3500] '../biz/data/KNUNK_SC_INCA_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_SC_INCA_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# SC-INCA PCS
set output 'pdf/FINAL-UNK-SCINCA-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNUNK_SC_INCA_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_SC_INCA_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# SC-DECA E[N]/k
set output 'pdf/FINAL-UNK-SCDECA-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] [0:3500] '../biz/data/KNUNK_SC_DECA_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_SC_DECA_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# SC-DECA PCS
set output 'pdf/FINAL-UNK-SCDECA-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNUNK_SC_DECA_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_SC_DECA_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# MDM-INCA E[N]/k
set output 'pdf/FINAL-UNK-MDMINCA-Nk.pdf'
set key right top
set ylabel 'E[N]/k'
plot [1:16384] [0:550]'../biz/data/KNUNK_MDM_INCA_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_MDM_INCA_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# MDM-INCA PCS
set output 'pdf/FINAL-UNK-MDMINCA-PCS.pdf'
set key right bottom
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNUNK_MDM_INCA_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_MDM_INCA_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# MDM-DECA E[N]/k
set output 'pdf/FINAL-UNK-MDMDECA-Nk.pdf'
set key right top
set ylabel 'E[N]/k'
plot [1:16384] [0:550] '../biz/data/KNUNK_MDM_DECA_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_MDM_DECA_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# MDM-DECA PCS
set output 'pdf/FINAL-UNK-MDMDECA-PCS.pdf'
set key right bottom
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNUNK_MDM_DECA_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_MDM_DECA_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# RPI-HETA E[N]/k 
set output 'pdf/FINAL-UNK-RPIHETA-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] [0:5000] '../biz/data/KNUNK_RPI_heteroA_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w p ps 2 pt 5, '../biz/data/BIZUNK_RPI_heteroA_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w p ps 2 pt 6

# RPI-HETA PCS 
set output 'pdf/FINAL-UNK-RPIHETA-PCS.pdf'
set key right bottom
set ylabel 'PCS'
# set arrow from 1,0.8 to 16384,0.8 nohead lt 2
plot [1:16384] [0.75:1.01] '../biz/data/KNUNK_RPI_heteroA_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w points ps 2 pt 5, '../biz/data/BIZUNK_RPI_heteroA_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w points ps 2 pt 6
# unset arrow

# SC-INC E[N]/k
set output 'pdf/FINAL-UNK-SCINC-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] [0:5500] '../biz/data/KNUNK_SC_INC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_SC_INC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# SC-INC PCS
set output 'pdf/FINAL-UNK-SCINC-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNUNK_SC_INC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_SC_INC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# SC-DEC E[N]/k
set output 'pdf/FINAL-UNK-SCDEC-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] [0:5500] '../biz/data/KNUNK_SC_DEC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_SC_DEC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# SC-DEC PCS
set output 'pdf/FINAL-UNK-SCDEC-PCS.pdf'
set key right center
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNUNK_SC_DEC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_SC_DEC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# MDM-INC E[N]/k
set output 'pdf/FINAL-UNK-MDMINC-Nk.pdf'
set key right top
set ylabel 'E[N]/k'
plot [1:16384] [0:900]'../biz/data/KNUNK_MDM_INC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_MDM_INC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# MDM-INC PCS
set output 'pdf/FINAL-UNK-MDMINC-PCS.pdf'
set key right bottom
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNUNK_MDM_INC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_MDM_INC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# MDM-DEC E[N]/k
set output 'pdf/FINAL-UNK-MDMDEC-Nk.pdf'
set key right top
set ylabel 'E[N]/k'
plot [1:16384] [0:900] '../biz/data/KNUNK_MDM_DEC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_MDM_DEC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# MDM-DEC PCS
set output 'pdf/FINAL-UNK-MDMDEC-PCS.pdf'
set key right bottom
set ylabel 'PCS'
plot [1:16384] [0.85:1] '../biz/data/KNUNK_MDM_DEC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w l lt 1, '../biz/data/BIZUNK_MDM_DEC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w l lt 4

# RPI-HET E[N]/k 
set output 'pdf/FINAL-UNK-RPIHET-Nk.pdf'
set key left top
set ylabel 'E[N]/k'
plot [1:16384] [0:8000] '../biz/data/KNUNK_RPI_hetero_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w p ps 2 pt 5, '../biz/data/BIZUNK_RPI_hetero_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w p ps 2 pt 6

# RPI-HET PCS 
set output 'pdf/FINAL-UNK-RPIHET-PCS.pdf'
set key right bottom
set ylabel 'PCS'
# set arrow from 1,0.8 to 16384,0.8 nohead lt 2
plot [1:16384] [0.75:1.01] '../biz/data/KNUNK_RPI_hetero_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN-UNK' w points ps 2 pt 5, '../biz/data/BIZUNK_RPI_hetero_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ-UNK' w points ps 2 pt 6
# unset arrow






# PGS plots
# Note that delta is 0.5
set output 'pdf/FINAL-PGS.pdf'
unset log x
unset log y 
set key top right
set xlabel '(mu(1) - mu(2)) / Delta'
set ylabel 'PGS'
plot [0:2] 'post_processed_data/BIZ_PGS3_with_mean2.txt' u (2*(0.5-$1)):3 '%lf k=%lf PCS=%lf+/-%lf' w l t 'k=3', 'post_processed_data/BIZ_PGS10_with_mean2.txt' u (2*(0.5-$1)):3 '%lf k=%lf PCS=%lf+/-%lf' w l t 'k=10', 'post_processed_data/BIZ_PGS100_with_mean2.txt' u (2*(0.5-$1)):3 '%lf k=%lf PCS=%lf+/-%lf' w l t 'k=100' 




# s-S inventory plots
set datafile separator ","
set xlabel 'Number of alternatives (k)'
set log x

# sS inventory E[N]/k
set output 'pdf/FINAL-sSCont-Nk.pdf'
set key right top
set ylabel 'E[N]/k'
plot [1:15000] [0:250] '../matlab/Oct13_KN.csv' u 1:2 t 'KN-UNK' w p ps 2 pt 5, '../matlab/Oct13_BIZ.csv' u 1:2 t 'BIZ-UNK' w p ps 2 pt 6


# sS inventory E[N]
set log y
set output 'pdf/FINAL-sSCont-N.pdf'
set key left top
set ylabel 'E[N]'
plot [1:15000] '../matlab/Oct13_KN.csv' u 1:($2*$1) t 'KN-UNK' w p ps 2 pt 5, '../matlab/Oct13_BIZ.csv' u 1:($2*$1) t 'BIZ-UNK' w p ps 2 pt 6
unset log y


# sS inventory PGS
set datafile separator ","
set output 'pdf/FINAL-sSCont-PGS.pdf'
set key right bottom
set ylabel 'PGS'
plot [1:15000] [0.75:1.01] '../matlab/Oct13_KN.csv' u 1:4 t 'KN-UNK' w p ps 2 pt 5, '../matlab/Oct13_BIZ.csv' u 1:4 t 'BIZ-UNK' w p ps 2 pt 6

# sS inventory Improvement
set datafile separator ","
set output 'pdf/FINAL-sSCont-Improvement.pdf'
set key right bottom
set ylabel 'E[N] KN / E[N] BIZ'
plot [1:15000] [1:4] '../matlab/Oct13_improvement.csv' u 1:2:3 w p ps 3 pt 1 t ''

set term x11
