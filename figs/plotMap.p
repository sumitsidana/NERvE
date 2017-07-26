set terminal postscript eps enhanced color solid font 'Helvetica,17'
set boxwidth 1.2 relative
set size ratio 0.7
#set format y "%.2t*10^%+04T";
#set format y "%2.0t{/Symbol \327}10^{%L}";
set key font ",30"
set xlabel "Embeddings Size";
set ylabel "MAP{/Symbol a}1" offset -2.5;
set xlabel font ",32"
set ylabel font ",32"
set tics font ",30";
set ytics (0.4,0.5,0.6,0.7,0.8,0.9);
#set xtics (0,2,4,6,8,10,12,14,16,18,20);
set offset -0.3,-0.3,0,0
set style line 1 lc rgb '#CC0000' lt 1 lw 2 pt 7 ps 1.5   # --- blue
set style line 2 lc rgb '#009900' lt 1 lw 2 pt 5 ps 1.5   # --- blue
set style line 3 lc rgb '#0000CC' lt 1 lw 2 pt 5 ps 1.5   # --- blue
set output "PlotMap_KASANDR.eps";
set datafile separator " "
set yrange [0.6:1] 
set key spacing 2
set key bottom right
plot  'embeddings_netflix' using ($2) with linespoints ls 1 title 'Recnet_c', \
 '' using ($3) with linespoints ls 2 title 'Recnet_p', \
 '' using ($4) with linespoints ls 3 title 'Recnet_{c,p}'
