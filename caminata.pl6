#!/usr/bin/env perl6 
#
# caminata.pl6 - Facilita el ingreso de datos y muestra un reporte
#

use v6;
use lib 'lib';
use Caminata;

multi sub MAIN (Str :$save-as = "distancia-caminada.txt") {
    from-stdin($save-as);
}

multi sub MAIN (Bool :$report, Str :$file = "distancia-caminada.txt") {
    show-report($file, True);
}

multi sub MAIN (
    Bool :$plot,
    Str  :$file    = "distancia.dat", 
    Str  :$save-as = "distancia.png",
    Str  :$size    = "800,480", )
{
    plot($file, $save-as, $size);
}

