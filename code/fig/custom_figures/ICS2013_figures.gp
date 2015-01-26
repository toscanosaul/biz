set term pdf monochrome fsize 16 dashed

# SC configuration, PCS
set output 'ICS2013-SC-PCS.pdf'
set key right center
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'PCS'
#set arrow from 1,0.9 to 16384,0.9 nohead lt 4
#set arrow from 1,1.0 to 16384,1.0 nohead lt 4
# plot [1:16384] [0.88:1.005] '../data/SC_final.txt' index 0 u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w linespoints lt 1 ps 2 pt 5, '../data/SC_final.txt' index 2 u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w linespoints lt 4 ps 2 pt 6
plot [1:16384] [0.88:1] '../data/KN_SC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w linespoints lt 1 ps 2 pt 5, '../data/BIZ_SC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w linespoints lt 4 ps 2 pt 6
#unset arrow

# SC configuration, E[N]/k
set output 'ICS2013-SC-Nk.pdf'
set key left top
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'E[N]/k'
# plot [1:16384] '../data/SC_final.txt' index 0 u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w linespoints lt 1 ps 2 pt 5, '../data/SC_final.txt' index 2 u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w linespoints lt 4 ps 2 pt 6
plot [1:16384] [0:2200] '../data/KN_SC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w linespoints lt 1 ps 2 pt 5, '../data/BIZ_SC_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w linespoints lt 4 ps 2 pt 6




# MDM configuration, PCS
set output 'ICS2013-MDM-PCS.pdf'
set key right bottom
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'PCS'
# set arrow from 1,0.9 to 16384,0.9 nohead lt 4
#set arrow from 1,1.0 to 16384,1.0 nohead lt 4
# plot [1:16384] [0.88:1.005] '../data/MDM_final.txt' index 0 u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w linespoints lt 1 ps 2 pt 5, '../data/MDM_final.txt' index 2 u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w linespoints lt 4 ps 2 pt 6
plot [1:16384] [0.88:1] '../data/KN_MDM_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w linespoints lt 1 ps 2 pt 5, '../data/BIZ_MDM_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w linespoints lt 4 ps 2 pt 6
#unset arrow

# MDM configuration, E[N]/k
set output 'ICS2013-MDM-Nk.pdf'
set key right top
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'E[N]/k'
# plot [1:16384] '../data/MDM_final.txt' index 0 u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w linespoints lt 1 ps 2 pt 5, '../data/MDM_final.txt' index 2 u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w linespoints lt 4 ps 2 pt 6
plot [1:16384] '../data/KN_MDM_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w linespoints lt 1 ps 2 pt 5, '../data/BIZ_MDM_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w linespoints lt 4 ps 2 pt 6


# RPI configuration, PCS vs. k
set output 'ICS2013-RPI-PCSk.pdf'
set key right center
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'PCS'
# set arrow from 1,0.8 to 16384,0.8 nohead lt 4
#set arrow from 1,1 to 16384,1 nohead lt 4
# plot [1:16384] [0.79:1.01] '../data/RPI_final.txt' u 5:3 'BIZ-PCS=%lf BIZ-E[N]=%lf KN-PCS=%lf KN-E[N]=%lf k=%lf' t 'KN' w points ps 2 pt 5, '../data/RPI_final.txt' u 5:1 'BIZ-PCS=%lf BIZ-E[N]=%lf KN-PCS=%lf KN-E[N]=%lf k=%lf' t 'BIZ' w points ps 2 pt 6 
plot [1:16384] [0.75:1.01] '../data/KN_RPI_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w points ps 2 pt 5, '../data/BIZ_RPI_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w points ps 2 pt 6
#unset arrow

# RPI configuration, E[N]/k vs. k
set output 'ICS2013-RPI-Nk.pdf'
set key left top
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'E[N]/k'
# plot [1:16384] '../data/RPI_final.txt' u 5:($4/$5) 'BIZ-PCS=%lf BIZ-E[N]=%lf KN-PCS=%lf KN-E[N]=%lf k=%lf' t 'KN' w p ps 2 pt 5, '../data/RPI_final.txt' u 5:($2/$5) 'BIZ-PCS=%lf BIZ-E[N]=%lf KN-PCS=%lf KN-E[N]=%lf k=%lf' t 'BIZ' w p ps 2 pt 6
plot [1:16384] '../data/KN_RPI_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w points ps 2 pt 5, '../data/BIZ_RPI_final.txt' u 1:4 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w points ps 2 pt 6





# Improvement factor vs. k
# set output 'ICS2013-ImprovementFactor.pdf'
# set key left top
# set log x
# unset log y
# set xlabel 'Number of alternatives (k)'
# set ylabel 'KN E[N] / BIZ E[N]'
# set ytics (1,5,10,15)
# plot [1:16384] [0:15] '../data/SC_combined_final.txt' u 1:($4/$2) w l lt 1 t 'SC', '../data/RPI_final.txt' u 5:($4/$2) 'BIZ-PCS=%lf BIZ-E[N]=%lf KN-PCS=%lf KN-E[N]=%lf k=%lf' w p ps 2 pt 4 t 'RPI', '../data/MDM_combined_final.txt' u 1:($4/$2) w l lt 2 t ' MDM'




set ytics autofreq
set term x11
