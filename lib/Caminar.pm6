unit module Caminar;

class Walk {
    has $.date;
    has $.distance;
    
    method week {
        return Date.new($!date).week-number;
    }
}

sub export-data-for-graphics (%data) {
    unlink 'distancia.dat' if 'distancia.dat'.IO.f;
    for %data{'walks'}.flat -> $obj {
        my $day-and-distance = $obj.date ~ "\t" ~ $obj.distance ~ "\n";
        spurt 'distancia.dat', $day-and-distance, :append;
    }
    say "\t*** Datos exportados ***\n";
}

sub plot (Str $dat-file, Str $save-as, Str $size) is export {
    my $cfg = qq:to/END/; 
        set terminal png size $size;
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

sub create-report (Str $file) returns Hash {
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

    my %data = :$long-distance, :$total-distance, 
        :$period-time, :$average-distance, :@walks;

    return %data;
}

sub show-report (Str $file, Bool $export?) is export {
    
    my %data = create-report($file);

    my $report = q:to/EOF/; 

        REPORTE
        --------------------------------------
        Distancia total: %s km en %s días
        Mayor distancia: %s km el %s
               Promedio: %.2f km 

    EOF

    printf $report, %data{'total-distance'}, %data{'period-time'}, 
        %data{'long-distance'}.distance, %data{'long-distance'}.date, 
        %data{'average-distance'};

    export-data-for-graphics(%data) if $export;
}

sub from-stdin ($save-as) is export {

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

