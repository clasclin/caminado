#!/usr/bin/env perl6 
#
# caminata.pl6 - Facilita el ingreso de datos, muestra un reporte
#                y crea un gráfico
#

use v6;
use lib 'lib';
use Caminata;

my $walks = Walks.new;

multi sub MAIN (
    Str :$date    = ~Date.today,
    Str :$save-as = 'distancia-caminada.txt', 
    *@distance ) 
{
    $walks.from-stdin($date, $save-as, @distance); 
}

multi sub MAIN (Bool :$report, Str :$from-file = 'distancia-caminada.txt') {
    $walks.show-report($from-file);
}

multi sub MAIN (
    Bool :$export,
    Str  :$from-file = 'distancia-caminada.txt',
    Str  :$save-as   = 'distancia.dat' )
{
    $walks.export-data-for-graphics(:$from-file, :$save-as);
}

multi sub MAIN (
    Bool :$plot,
    Str  :$file         = 'distancia.dat',
    Str  :$format       = 'svg',
    Str  :$save-as      = 'distancia.' ~ "$format",
    Str  :$size is copy = '1366x768',
    Str  :$color        = 'skyblue' )
{
    $size = $size.subst(/x|':'/, ',');
    $walks.plot($file, $save-as, $format, $size, $color);  
}

