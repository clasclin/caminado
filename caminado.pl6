#!/usr/bin/env perl6 
#
# caminado.pl6 - Facilita el ingreso de datos y muestra un reporte
#

use v6;

chdir "$*HOME/Escritorio";

class Walk {
    has $.date;
    has $.distance;
    
    method week {
        return Date.new($!date).week-number;
    }
}

sub export-data-for-graphics (@data) {
    for @data -> $obj {
        my $day-and-distance = $obj.date ~ "\t" ~ $obj.distance ~ "\n";
        spurt 'distancia.dat', $day-and-distance, :append;
    }
    say "Datos exportados";
}

sub plot ($dat-file, $save-as) { 
    my $cfg = qq:to/END/; 
        set terminal png size 800,480;
        set output "$save-as";
        
        set ylabel 'Distancia km';
        set xlabel "Semanas";
        
        set grid;
        set xtic rotate by -45;
        
        set xdata time;
        set timefmt "%Y-%m-%d";
        set format x "%d-%m-%Y";
        
        set boxwidth 3600*24 * 0.6;
        set style fill solid 0.6 noborder;
        
        plot "$dat-file" using 1:2 with boxes title "caminado" linecolor rgb "skyblue"
        END 

    run 'gnuplot', '-e', $cfg; 
}

sub show-report ($file, Bool $export?) {
    # show a report with statistics

    my @walks;
    for $file.IO.lines -> $line {
        next unless $line ~~ /^ \d+  /;

        my ($date, $distances) = $line.split(' | ');
        my $distance           = $distances.words.sum;

        @walks.push: Walk.new(:$date, :$distance);
    }

    my $long-distance    = @walks.sort({ .distance }).tail;
    my $total-distance   = [+] @walks».distance;
    my $first            = Date.new(@walks».date.sort.head);
    my $last             = Date.new(@walks».date.sort.tail);
    my $period-time      = $last - $first;
    my $average-distance = $total-distance / @walks.elems;

    my $report = q:to/EOF/; 

        REPORTE
        ----------------------------------------
        Distancia total: %s km
                periodo: %s días
        Mayor distancia: %s km
                  fecha: %s
                 semana: %s
               Promedio: %.2f km 

        EOF

    printf $report, $total-distance, $period-time, $long-distance.distance,
           $long-distance.date, $long-distance.week, $average-distance;

    export-data-for-graphics(@walks) if $export;
}

sub from-stdin ($save-as) {
    # process data from keyboard and append to the default file

    my $today = Date.today;
    my $date  = prompt "Fecha [$today]: ";
    $date    := $today unless $date;

    my @total-distance;
    loop {
        my $distance = prompt "Distancia: ";
        $distance
            ?? @total-distance.push: $distance
            !! last;
    }

    my $head = "Fecha        Distancia\n----------------------\n";
    my $data = $date ~ ' | ' ~ join ' ', @total-distance ~ "\n";
    spurt $save-as, $head unless $save-as.IO.e;
    spurt $save-as, $data, :append;
}

multi sub MAIN (:$save-as = "distancia-caminada.txt") {
    from-stdin($save-as);
}

multi sub MAIN (Bool :$reporte, :$file = "distancia-caminada.txt") {
    show-report($file, True);
}

multi sub MAIN (
    Bool :$plot,
    :$file = "distancia.dat", 
    :$save-as = "distancia.png",
) {
    plot($file, $save-as);
}

