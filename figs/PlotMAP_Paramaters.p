set terminal postscript eps enhanced color solid font 'Helvetica,17'
set boxwidth 1.2 relative
set size ratio 0.7
set key font ",20"
set auto x
set xlabel "#Batches";
set ylabel "MAP{/Symbol a}1" offset 1.5;
set xlabel font ",22"
set ylabel font ",22"
set tics font ",20";
#set ytics (0.4,0.5,0.6,0.7,0.8,0.9);
set offset -0.3,-0.3,0,0
set style line 1 lc rgb '#CC0000' lt 1 lw 2 pt 7 ps 1.5   # --- blue
set style line 2 lc rgb '#009900' lt 1 lw 2 pt 5 ps 1.5   # --- blue
set style line 3 lc rgb '#0000CC' lt 1 lw 2 pt 5 ps 1.5   # --- blue
set output "PlotMap_Batches_ML100K.eps";
set xtic rotate by -35 scale 0
set datafile separator " "
set yrange [0.79:0.9]
set xrange [-1:10]
set key spacing 2
set key top left
set key spacing 1.7
plot  'batches_ml100k' using ($3):xticlabels(1) with linespoints ls 1 title 'Recnet_c', \
 '' using ($2):xticlabels(1) with linespoints ls 2 title 'Recnet_p', \
 '' using ($4):xticlabels(1) with linespoints ls 3 title 'Recnet_{c,p}'
