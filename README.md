Caminata
--------

La idea es simplemente facilitar el ingreso de datos y mostrar un reporte
en pantalla, con la posibilidad de exportar en un gráfico y mantener simples
los archivos para permitir editarlos manualmente de ser necesario.
Ejemplo de salida del gráfico que ayuda a armar.

![render gnuplot](/imgs/distancia.png)

## Uso típico.

```bash
# ingreso datos pasando las distancias como argumentos
$ caminata.pl6 1.24 2.52 3.3
# preparar datos para gráficar
$ caminata.pl6 --export
# crear el gráfico
$ caminata.pl6 --plot
```

### Adicionalmente se puede pedir un reporte

```bash
$ caminata.pl6 --report

REPORTE
--------------------------------------
Distancia total: 56.64 km en 60 días
Mayor distancia: 5.58 km el 2017-10-03
       Promedio: 3.15 km 
```

### La ayuda muestra todas las opciones disponibles

```bash
$ caminata.pl6 --help
Usage:
  ./caminata.pl6 [--date=<Str>] [--save-as=<Str>] '[<distance> ...]' 
  ./caminata.pl6 [--report] [--from-file=<Str>] 
  ./caminata.pl6 [--export] [--from-file=<Str>] [--save-as=<Str>] 
  ./caminata.pl6 [--plot] [--file=<Str>] [--format=<Str>] [--save-as=<Str>] [--size=<Str>] [--color=<Str>] 
```

## Hoja de ruta

* ~Capturar datos de entrada~

* ~Crear un informe que incluya: total, promedio, mayor distancia~

* ~Exportar datos para gráficar~

* ~Finalmente gráficar los datos exportados~

* Volcar los datos a una planilla **[parcialmente implementado con errores ver bugs]**

## Bugs

La planilla de cálculo no muestra correctamente los datos, en algunos casos
dando un error #508, siendo que las formulas se muestran correctamente.
Para corregirlo hay que borrar uno de los parentesis
y volver a añadirlo.

## Requisitos

* [perl6](http://perl6.org/)
* [gnuplot](http://gnuplot.info/) para crear el gráfico

Para vocar datos a la planilla se requiere de:

* [perl](http://www.perl.org/)
* [Excel::Writer::XLSX](http://metacpan.org/pod/Excel::Writer::XLSX)
* [utf8::all](https://metacpan.org/pod/utf8::all)

