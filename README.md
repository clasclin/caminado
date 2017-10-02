Caminado
--------

La idea es simplemente facilitar el ingreso de datos y mostrar un reporte
informativo.

## Uso

```bash
# para pedir ayuda

$ caminado.pl6 --help
Usage:
  caminado.pl6 [--export] [--save-as=<Any>] [<file>]

# sin argumentos se pueden ingresar datos, simplemente con enter se acepta
# la fecha por defecto (la del día de hoy) al igual que si no se ingresan
# datos en la distancia se guardan los datos y se muestra un reporte al
# finalizar

$ caminado.pl6
Fecha [2017-09-10]:
Distancia: 1.2
Distancia:

REPORTE
----------------------------------------
Distancia total: 40.22 km
        periodo: 32 días
Mayor distancia: 5.03 km
          fecha: 2017-08-13
         semana: 32
       Promedio: 2.87 km

# si el argumento es un archivo se muestra un reporte de ese archivo

$ caminado.pl6 distancia-caminada.txt

REPORTE
----------------------------------------
Distancia total: 40.22 km
        periodo: 32 días
Mayor distancia: 5.03 km
          fecha: 2017-08-13
         semana: 32
       Promedio: 2.87 km


# --export crea un archivo adicional 'distancia.dat' que contiene la
# fecha y la distancia de ese día

$ caminado.pl6 --export distancia-caminada.txt

REPORTE
----------------------------------------
Distancia total: 40.22 km
        periodo: 32 días
Mayor distancia: 5.03 km
          fecha: 2017-08-13
         semana: 32
       Promedio: 2.87 km

Datos exportados

```

## Hoja de ruta

* ~Capturar datos de entrada~

* Crear un informe que incluya: total, promedio, mayor distancia
  [parcialmente implementado]

* ~Opcionalmente exportar como csv~ [exporta como tsv para graficar]

* Graficar los datos exportados
