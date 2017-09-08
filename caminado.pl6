#!/usr/bin/env perl6

use v6;


sub MAIN ($file) {
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

    say "REPORTE";
    say '-' x 40;
    say "Mayor distancia: $long-distance";
    say "Distancia total: $total-distance";
}
