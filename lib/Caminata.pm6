unit module Caminata;

class Walk {
    has $.date      is required;
    has @.distances is required;
    
    method sum-distance {
        return sum @!distances;
    }
}

class Walks is export {
    has Walk @.walks;
    
    method !load-data ($file) {
        for "$file".IO.lines -> $line {
            next unless $line ~~ /^ \d /;
            my ( $date, $sep-distances ) = $line.split(" | ");
            my @distances = $sep-distances.split(' ');
            @!walks.push: Walk.new(:$date, :@distances);
        }
    }

    method add-walk ($date, @distances) {
        @!walks.push: Walk.new( :$date, :@distances );
    }
    
    multi method export-data-for-graphics (:$from-file, :$save-as) {
        self!load-data($from-file);
        self.export-data-for-graphics($save-as);
    }

    multi method export-data-for-graphics ($save-as) {
        die "No data to export" if @!walks.elems < 1;

        unlink $save-as if "$save-as".IO.f;
        
        for @!walks -> $obj {
            my $data = $obj.date ~ "\t" ~ $obj.sum-distance ~ "\n";
            spurt $save-as, $data, :append;
        }
    }
    
    multi method show-report ($from-file) {
        self!load-data($from-file);
        self.show-report;
    }
    
    multi method show-report {
        die "No data to create report" if @!walks.elems < 1;

        my $long-distance    = @!walks.sort({ .sum-distance }).tail;
        my $total-distance   = @!walks».sum-distance.sum;
        my ($first, $last)   = @!walks».date.sort[0,*-1];
        my $period-in-days   = Date.new($last) - Date.new($first);
        my $average-distance = $total-distance / @!walks.elems;

        my $report = q:to/EOF/;

        REPORTE
        --------------------------------------
        Distancia total: %s km en %s días
        Mayor distancia: %s km el %s
               Promedio: %.2f km 

        EOF

        printf $report, $total-distance, $period-in-days, 
               ~$long-distance.sum-distance, ~$long-distance.date,
               $average-distance;
    }
    
    method plot ($dat-file, $save-as, $format, $size, $color) {
        my $cfg = qq:to/END/; 
            set terminal $format size $size fname "Verdana" fsize "18";
            set output "$save-as";

            set ylabel 'Distancia km';
            set xlabel "Semanas";

            set grid;
            set xtic rotate by -45;

            set xdata time;
            set timefmt "%Y-%m-%d";
            set format x "%d-%m-%Y";

            set boxwidth 3600*24 * 0.7;
            set style fill solid 0.8 noborder;

            plot "$dat-file" using 1:2 with boxes title "caminado" 
            linecolor rgb "$color"
            END

        run 'gnuplot', '-e', $cfg;
    }
        
    method from-stdin ($date, $save-as, *@distances) {
        my $head = 'Fecha' ~ ' ' x 9 ~ 'Distancia' ~ "\n" ~ '-' x 23 ~ "\n";
        my $data = $date ~ ' | ' ~ join ' ', @distances ~ "\n";
        spurt $save-as, $head unless "$save-as".IO.e;
        spurt $save-as, $data, :append;
    }
}

