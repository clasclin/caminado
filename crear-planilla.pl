#!/usr/bin/env perl
#
# crear-planilla.pl - Volcar datos de fecha y distancia a una planilla
#                     y crear un reporte
#

use strict;
use warnings;
use autodie;
use utf8::all;

use Getopt::Long 'GetOptions';
use Pod::Usage   'pod2usage';

use Excel::Writer::XLSX;

my ( $help, $man, $dat_file, $output );

GetOptions(
    'help|?'     => \$help,
    'man'        => \$man,
    'dat-file=s' => \$dat_file,
    'output=s'   => \$output,
);

if ($help) {
    pod2usage( -verbose => 1 );
}
elsif ($man) {
    pod2usage( -verbose => 2 );
}
elsif ( $dat_file && $output ) {
    my $workbook    = Excel::Writer::XLSX->new($output);
    my $distancias  = $workbook->add_worksheet( 'Distancias' );
    my $date_format = $workbook->add_format( num_format => 'dd/mm' );
    
    $distancias->write( 'A1', 'Fechas');
    $distancias->write( 'B1', 'Distancias');    

    open my $dat, '<', $dat_file;
    
    my ( $row, $col ) = ( 1, 0 );
    my $last_row = 0;

    while (<$dat>) {
        my ( $date, $distance ) = split;
        $date = $date . 'T00:00';
        $distancias->write_date_time( $row, $col, $date, $date_format );
        $distancias->write( $row, ++$col, $distance );
        --$col;
        $row++;
        $last_row = $row;
    }

    close $dat;
    
    my $report_format = $workbook->add_format( valign => 'vcenter', align => 'center' );
    $distancias->merge_range( 'D2:H2', 'Reporte', $report_format );

    $distancias->write( 'D3', 'Distancia recorrida' );
    $distancias->write( 'D4', 'Mayor distancia' );
    $distancias->write( 'D5', 'Promedio' );
    $distancias->write( 'H3', 'días' );
    $distancias->write( 'F3', 'km' );
    $distancias->write( 'F4', 'km' );
    $distancias->write( 'F5', 'km' );
    $distancias->write_formula( 'E3', '=SUM(B:B)' );
    $distancias->write_formula( 'E4', '=MAX(B:B)' );
    $distancias->write_formula( 'E5', '=AVERAGE(B:B)' );
    $distancias->write_formula( 'G3', '=DATEDIF(A2;A' . $last_row . ',"d")' );
    $distancias->write_formula( 
        'G4', '=INDIRECT(ADDRESS(MATCH(MAX(B2:B' . $last_row . ');B1:B' . $last_row . ';1);1;))'
    );

    my $grafico = $workbook->add_worksheet( 'Gráfico' );
    $workbook->close();
}
else {
    pod2usage(
        -msg     => "Missing required args or there is a wrong number of them",
        -verbose => 1,
    );
}

__END__

=pod

=head1 NAME

crear-planilla - Volcar datos de fecha y distancia a una planilla
                 y crear un reporte

=head1 SYNOPSIS

    Options
        --help          Show help.
        --man           More help. 
        --dat-file      Input data
        --output        Name of the xlsx file

=head1 EXAMPLES

=head1 LICENSE

MIT License

=head1 AUTHOR

clasclin - clasclin@gmail.com

=head1 BUGS

It is perfect, no bugs haha.

=cut

