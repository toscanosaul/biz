set term pdf monochrome fsize 18 dashed

# SC configuration, PCS, just KN 
set output 'AFOSR2013-SC-KN-PCS.pdf'
set key right center
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'PCS'
set arrow from 1,0.9 to 16384,0.9 nohead lt 4
#set arrow from 1,1.0 to 16384,1.0 nohead lt 4
plot [1:16384] [0.88:1] '../../biz/data/KN_SC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w linespoints lt 1 ps 2 pt 5
unset arrow

# SC configuration, PCS, just BIZ 
set output 'AFOSR2013-SC-BIZ-PCS.pdf'
set key right center
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'PCS'
set arrow from 1,0.9 to 16384,0.9 nohead lt 4
#set arrow from 1,1.0 to 16384,1.0 nohead lt 4
plot [1:16384] [0.88:1] '../../biz/data/BIZ_SC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w linespoints lt 4 ps 2 pt 6
unset arrow


# SC configuration, PCS, KN and BIZ
set output 'AFOSR2013-SC-PCS.pdf'
set key right center
set log x
unset log y
set xlabel 'Number of alternatives (k)'
set ylabel 'PCS'
set arrow from 1,0.9 to 16384,0.9 nohead lt 4
#set arrow from 1,1.0 to 16384,1.0 nohead lt 4
plot [1:16384] [0.88:1] '../../biz/data/KN_SC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'KN' w linespoints lt 1 ps 2 pt 5, '../../biz/data/BIZ_SC_final.txt' u 1:2 'k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'BIZ' w linespoints lt 4 ps 2 pt 6
unset arrow


