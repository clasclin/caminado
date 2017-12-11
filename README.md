Caminata
--------

La idea es simplemente facilitar el ingreso de datos y mostrar un reporte
en pantalla, con la posibilidad de exportar en un gráfico y mantener simples
los archivos para permitir editarlos manualmente de ser necesario.

![render gnuplot](/imgs/distancia.png)

## Uso

```bash
### ayuda

$ caminata.pl6 --help
Usage:
  caminata.pl6 [--save-as=<Str>] 
  caminata.pl6 [--report] [--file=<Str>] 
  caminata.pl6 [--plot] [--file=<Str>] [--save-as=<Str>] [--size=<Str>]

### ingresar datos

# sin argumentos se pueden ingresar datos, simplemente con enter se acepta
# la fecha por defecto
$ caminata.pl6
Fecha [2017-09-10]:
Distancia: 1.2
Distancia:

# se especifica en donde tiene que guardar el archivo de texto
$ caminata.pl6 --save-as='septiembre-2017'

### reporte

# reporte en pantalla 
$ caminata.pl6 --report

    REPORTE
    --------------------------------------
    Distancia total: 56.64 km en 60 días
    Mayor distancia: 5.58 km el 2017-10-03
           Promedio: 3.15 km 

        *** Datos exportados ***

# reporte en pantalla y exportando datos
$ caminata.pl6 --report --file='septiembre-2017'

### plot se ocupa del graficar

# usando archivos por defecto
$ caminata.pl6 --plot

# modifica el tamaño de la imagen
$ caminata.pl6 --plot --size="1280,600"

# especificando  el archivo que conviene los datos exportados
$ caminata.pl6 --plot --file='archivo.dat'

# idem al anterior + le pido que cambie el nombre del archivo grafico
# a guardar
$ caminata.pl6 --plot --file='archivo.dat' --save-as='septiembre.png'

# volcar los datos a una planilla de cálculo
$ crear-planilla.pl --dat-file distancia.dat --output caminata.xlsx

```

## Hoja de ruta

* ~Capturar datos de entrada~

* Crear un informe que incluya: total, promedio, mayor distancia
  **[parcialmente implementado]**

* ~Opcionalmente exportar como csv~ **[exporta como tsv para graficar]**

* ~Graficar los datos exportados~ **[mediante la opción plot]**

* Volcar los datos a una planilla **[parcialmente implementado]**

## Bugs

La planilla de cálculo no muestra correctamente los datos en algunos casos
dando un error #508, siendo que las formulas se muestran correctamente.
Para corregirlo hay que borrar uno de los parentesis
y volver a añadirlo.

## Requisitos
* [gnuplot](http://gnuplot.info/)
* [Excel::Writer::XLSX](http://metacpan.org/pod/Excel::Writer::XLSX)
