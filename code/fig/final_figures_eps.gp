#set term postscript eps fontsize 16 monochrome dashed
# set term postscript eps monochrome 32 dashed
set term postscript eps monochrome 32 size 5in,3in dashed lw 2.0 dl 3.0

# SC configuration, PCS
set output 'FINAL-SC-PCS.eps'
set key right center
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'PCS'
#set arrow from 1,0.9 to 16384,0.9 nohead lt 4
#set arrow from 1,1.0 to 16384,1.0 nohead lt 4
plot [1:16384] [0.88:1.005] 'SC_final.txt' index 0 u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, 'SC_final.txt' index 1 u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BKS' w l lt 2, 'SC_final.txt' index 2 u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4
#unset arrow

# SC configuration, E[N]/k
set output 'FINAL-SC-Nk.eps'
set key left top
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'E[N]/k'
plot [1:16384] 'SC_final.txt' index 0 u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, 'SC_final.txt' index 1 u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BKS' w l lt 2, 'SC_final.txt' index 2 u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4






# MDM configuration, PCS
set output 'FINAL-MDM-PCS.eps'
set key right top
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'PCS'
# set arrow from 1,0.9 to 16384,0.9 nohead lt 4
#set arrow from 1,1.0 to 16384,1.0 nohead lt 4
plot [1:16384] [0.88:1.005] 'MDM_final.txt' index 0 u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, 'MDM_final.txt' index 1 u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BKS' w l lt 2, 'MDM_final.txt' index 2 u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4
#unset arrow

# MDM configuration, E[N]/k
set output 'FINAL-MDM-Nk.eps'
set key right top
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'E[N]/k'
plot [1:16384] 'MDM_final.txt' index 0 u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, 'MDM_final.txt' index 1 u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BKS' w l lt 2, 'MDM_final.txt' index 2 u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4



# RPI configuration, PCS vs. k
set output 'FINAL-RPI-PCSk.eps'
set key right center
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'PCS'
# set arrow from 1,0.8 to 16384,0.8 nohead lt 4
#set arrow from 1,1 to 16384,1 nohead lt 4
plot [1:16384] [0.79:1.01] 'RPI_final.txt' u 5:3 'BIZ-PCS=%lf BIZ-E[N]=%lf KN-PCS=%lf KN-E[N]=%lf k=%lf' t 'KN' w points ps 2 pt 5, 'RPI_final.txt' u 5:1 'BIZ-PCS=%lf BIZ-E[N]=%lf KN-PCS=%lf KN-E[N]=%lf k=%lf' t 'BIZ' w points ps 2 pt 6 
#unset arrow

# RPI configuration, E[N]/k vs. k
set output 'FINAL-RPI-Nk.eps'
set key left top
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'E[N]/k'
plot [1:16384] 'RPI_final.txt' u 5:($4/$5) 'BIZ-PCS=%lf BIZ-E[N]=%lf KN-PCS=%lf KN-E[N]=%lf k=%lf' t 'KN' w p ps 2 pt 5, 'RPI_final.txt' u 5:($2/$5) 'BIZ-PCS=%lf BIZ-E[N]=%lf KN-PCS=%lf KN-E[N]=%lf k=%lf' t 'BIZ' w p ps 2 pt 6





# Improvement factor vs. k
set output 'FINAL-ImprovementFactor.eps'
set key left top
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'KN E[N] / BIZ E[N]'
set ytics (1,5,10,15)
plot [1:16384] [0:15] 'SC_combined_final.txt' u 1:($4/$2) w l lt 1 t 'SC', 'RPI_final.txt' u 5:($4/$2) 'BIZ-PCS=%lf BIZ-E[N]=%lf KN-PCS=%lf KN-E[N]=%lf k=%lf' w p ps 2 pt 4 t 'RPI', 'MDM_combined_final.txt' u 1:($4/$2) w l lt 2 t ' MDM'





set ytics autofreq

# SC configuration, log-linear plot of E[N]/k for KN
set output 'DIAG-SC-logNk.eps'
set key left top
set log xy
set xlabel 'Number of alternatives (k)'
set ylabel 'E[N]/k'
plot [1:16384] 'SC_final.txt' index 0 u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w l lt 1, 'SC_final.txt' index 1 u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BKS' w l lt 2, 'SC_final.txt' index 2 u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w l lt 4


# RPI, plot of just E[N]/k for just BIZ
set output 'DIAG-RPI-Nk.eps'
set key left top
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'E[N]/k'
plot [1:16384] [0:1000] 'RPI_final.txt' u 5:($2/$5) 'BIZ-PCS=%lf BIZ-E[N]=%lf KN-PCS=%lf KN-E[N]=%lf k=%lf' t 'BIZ' w p ps 2 pt 6




set term x11
