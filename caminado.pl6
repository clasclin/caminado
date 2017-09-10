#!/usr/bin/env perl6

use v6;

sub show-report ($file) {
    # create a report with statistics

    my @walks;
    for "$file".IO.lines -> $line {
        next unless $line ~~ /^ \d+  /;

        my ($date, $distance) = $line.split(' | ');
        my @roads = $distance.words;
        my $day-walk;

        for @roads -> $road {
            $day-walk += $road;
        }

        $date = Date.new($date);
        my $week-number = $date.week-number;
        @walks.push: { 
            date => $date, 
            week => $week-number, 
            distance => $day-walk,
        }
    }
    my $long-distance  = [max] @walks»{'distance'};
    my $total-distance = [+] @walks»{'distance'};

    say "";
    say "REPORTE";
    say '-' x 40;
    say "Mayor distancia: $long-distance";
    say "Distancia total: $total-distance";
    say "";
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

    my $data = $date ~ ' | ' ~ join ' ', @total-distance ~ "\n";
    spurt $save-as, $data, :append;
}

sub MAIN ($file?, :$save-as = 'distancia-caminada.txt') {
    with $file {
        show-report($file);
    }
    else {
        from-stdin($save-as);
        show-report($save-as);
    }
}

