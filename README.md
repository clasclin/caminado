Caminado
--------

La idea es simplemente facilitar el ingreso de datos y mostrar un reporte
informativo.

## Uso

```bash
# para pedir ayuda

$ caminado.pl6 --help
Usage:
  caminado.pl6 [--save-as=<Any>] [<file>]

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
Mayor distancia: 5.03
Distancia total: 40.22

# si el argumento es un archivo se muestra un reporte de ese archivo

$ caminado.pl6 distancia-caminada.txt

REPORTE
----------------------------------------
Mayor distancia: 5.03
Distancia total: 40.22

```

## Hoja de ruta

* ~Capturar datos de entrada~

* Crear un informe que incluya: total, promedio, mayor distancia

* Opcionalmente exportar como csv
