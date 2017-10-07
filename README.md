Caminado
--------

La idea es simplemente facilitar el ingreso de datos y mostrar un reporte
en pantalla, con la posibilidad de exportar en un gráfico y mantener simples
los archivos para permitir editarlos manualmente de ser necesario.

![render gnuplot](/imgs/distancia.png)

## Uso

```bash
### ayuda

$ caminado.pl6 --help
Usage:
  caminado.pl6 [--save-as=<Str>] 
  caminado.pl6 [--report] [--file=<Str>] 
  caminado.pl6 [--plot] [--file=<Str>] [--save-as=<Str>] [--size=<Str>]

### ingresar datos

# sin argumentos se pueden ingresar datos, simplemente con enter se acepta
# la fecha por defecto
$ caminado.pl6
Fecha [2017-09-10]:
Distancia: 1.2
Distancia:

# le especifico en donde tiene que guardar el archivo de texto
$ caminado.pl6 --save-as='septiembre-2017'
Fecha [2017-09-10]:
Distancia: 1.2
Distancia:

### reporte

# reporte en pantalla 
$ caminado.pl6 --report

    REPORTE
    --------------------------------------
    Distancia total: 56.64 km en 60 días
    Mayor distancia: 5.58 km el 2017-10-03
           Promedio: 3.15 km 

        *** Datos exportados ***

# reporte en pantalla y exportando datos
$ caminado.pl6 --report --file='septiembre-2017'

    REPORTE
    --------------------------------------
    Distancia total: 56.64 km en 60 días
    Mayor distancia: 5.58 km el 2017-10-03
           Promedio: 3.15 km 

        *** Datos exportados ***

### plot se ocupa del graficar

# usando archivos por defecto
$ caminado.pl6 --plot

# modifica el tamaño de la imagen
$ caminado.pl6 --plot --size="1280,600"

# especificando  el archivo que conviene los datos exportados
$ caminado.pl6 --plot --file='archivo.dat'

# idem al anterior + le pido que cambie el nombre del archivo grafico
# a guardar
$ caminado.pl6 --plot --file='archivo.dat' --save-as='septiembre.png'

```

## Hoja de ruta

* ~Capturar datos de entrada~

* Crear un informe que incluya: total, promedio, mayor distancia
  **[parcialmente implementado]**

* ~Opcionalmente exportar como csv~ **[exporta como tsv para graficar]**

* ~Graficar los datos exportados~ **[mediante la opción plot]**

## Requisitos
* [gnuplot](http://gnuplot.info/)
