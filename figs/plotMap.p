set terminal postscript eps enhanced color solid font 'Helvetica,17'
#set boxwidth 1 relative
set size ratio 0.7
#set format y "%.2t*10^%+04T";
#set format y "%2.0t{/Symbol \327}10^{%L}";
set key font ",30"
set xlabel "Test set";
set ylabel "MAP" offset -2.5;
set xlabel font ",32"
set ylabel font ",32"
set tics font ",30";
set ytics (0.4,0.5,0.6,0.7);
set offset -0.3,-0.3,0,0
set style line 1 lc rgb '#2E2E2E' lt 1 lw 2 pt 7 ps 1.5   # --- blue
set style line 2 lc rgb '#848484' lt 1 lw 2 pt 5 ps 1.5   # --- blue
#plot 'plotting_data1.dat' with linespoints ls 1
#set style fill solid border -1;
set output "PlotMap.eps";
set datafile separator " "
blue1="#474747";
blue2="#C4C3C3";
#set key spacing 1.0
#set xtics 1:30
set yrange [0.4:0.7] 

plot  'embeddings_ml100k' using ($2) with linespoints ls 1 title 'Recnet_c', \
 using ($3) with linespoints ls 2 title 'Recnet_p'
 using ($4) with linespoints ls 2 title 'Recnet_c,p'
