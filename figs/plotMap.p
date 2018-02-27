set terminal postscript eps enhanced color solid font 'Helvetica,17'
set encoding iso_8859_1
set boxwidth 1.2 relative
set size ratio 0.7
set key font ",20"
set xlabel "Embeddings Size";
set ylabel 'MAP\@1' offset -2.5;
set xlabel font ",22"
set ylabel font ",22"
set tics font ",20";
set ytics (0.4,0.5,0.6,0.7,0.8,0.9,1.0);
set offset -0.3,-0.3,0,0
set style line 1 lc rgb '#CC0000' lt 1 lw 2 pt 7 ps 1.5   # --- blue
set style line 2 lc rgb '#009900' lt 1 lw 2 pt 5 ps 1.5   # --- blue
set style line 3 lc rgb '#0000CC' lt 1 lw 2 pt 5 ps 1.5   # --- blue
set output "PlotMap_KASANDR.eps";
set datafile separator " "
set yrange [0.65:1]
set xrange [-1:20]
set key spacing 2
set key top right
plot  'embeddings_kasandr' using ($4):xticlabels(1) with linespoints ls 1 title 'Recnet_c', \
 '' using ($3):xticlabels(1) with linespoints ls 2 title 'Recnet_p', \
 '' using ($2):xticlabels(1) with linespoints ls 3 title 'Recnet_{c,p}'
