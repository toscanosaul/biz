set term pdf monochrome fsize 16 dashed size 3in,3.5in
set key bottom right
set output 'ICS2013_overdelivery2.pdf'
set xlabel 'E[Sample Size]'
set ylabel 'Worst-case PZ PCS'
set arrow from 400,0.85 to 750,0.85 nohead lt 4
# set arrow from 450,0.85 to 450,0.5 nohead lt 4
# set arrow from 585,0.85 to 585,0.5 nohead lt 4
set xtics (450,585)
plot [400:750] [0:1] 'KN_SCvP_10000.txt' u 5:3 'pstar=%lf k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'alpha' w l lt 1, 'KN_SCvP_10000.txt' u 5:1 'pstar=%lf k=%lf PCS=%lf+/-%lf E[N]/k=%lf+/-%lf' t 'beta' w l lt 2, 'intersection.txt' w p ps 2 pt 4 t '
