Caminado
--------

La idea es simplemente facilitar el ingreso de datos y mostrar un reporte
en pantalla, con la posibilidad de exportar en un gráfico y mantener simples
los archivos para permitir editarlos manualmente de ser necesario.

El reporte gráfico:
![render gnuplot](/imgs/distancia.png)

El archivo donde se guardan las fechas y distancias
```bash
Fecha        Distancia
----------------------
2017-08-07 | 4.51
2017-08-08 | 3.15
2017-08-10 | 2.52 1.74
2017-08-12 | 2.08
2017-08-13 | 5.03
2017-08-14 | 1.98
2017-08-17 | 2.52 1.68
2017-08-19 | 1.98
2017-08-20 | 1.60
2017-08-23 | 1.59
2017-08-24 | 2.52
2017-08-25 | 2.52
2017-08-29 | 1.13
2017-09-08 | 2.52 1.15
```

## Uso

```bash
### ayuda

$ caminado.pl6 --help
Usage:
  caminado.pl6 [--save-as=<Any>] 
  caminado.pl6 [--reporte] [--file=<Any>] 
  caminado.pl6 [--plot] [--file=<Any>] [--save-as=<Any>]

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
$ caminado.pl6 --reporte 

REPORTE
----------------------------------------
Distancia total: 40.22 km
        periodo: 32 días
Mayor distancia: 5.03 km
          fecha: 2017-08-13
         semana: 32
       Promedio: 2.87 km

# reporte en pantalla y exportando datos
$ caminado.pl6 --reporte --file='septiembre-2017'

REPORTE
----------------------------------------
Distancia total: 40.22 km
        periodo: 32 días
Mayor distancia: 5.03 km
          fecha: 2017-08-13
         semana: 32
       Promedio: 2.87 km

Datos exportados

### plot se ocupa del graficar

# usando archivos por defecto
$ caminado.pl6 --plot

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
