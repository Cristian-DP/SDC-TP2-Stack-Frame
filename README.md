# TP2 - Stack Frame

- **Integrantes:** {cristian.pereyra,francisco.coschica,nicolas.lopez.casanegra}@mi.unc.edu.ar
- **Profesor:** Javier Jorge

## Objetivo

Para aprobar el TP#2 se debe diseñar e implementar calculos en ensamblador.

La capa superior recuperará información de una api REST. Se recomienda el uso de API Rest y python. Los datos de consulta realizados deben ser entregados a un programa en C que convocará rutinas en ensamblador para que hagan los cálculos de conversión y devuelvan los resultados a las capas superiores.
Luego el programa en C o python mostrará los cálculos obtenidos.-

Se debe utilizar el stack para convocar, enviar parámetros y devolver resultados. O sea utilizar las convenciones de llamadas de lenguajes de alto nivel a bajo nivel.-

Las presentaciones de los trabajos se realizarán utilizando GitHub (una cuenta privada). Cada grupo debe asignar un responsable (con email institucional) como usuario de la cuenta de GitHub. Se debe realizar un commit brevemente comentado con cada funcionalidad implementada y validada.-

## Enunciado

**[Enunciado](https://docs.google.com/document/d/1iR36JSzibt84sx7Pg65Ty6jhb3hQ4PmNnv7oCygqSwY/edit?hl=es&tab=t.0#heading=h.l9frjjl9vc9b)**

Enunciado y condiciones de aprobación

Para aprobar el TP#1 se debe diseñar e implementar una interfaz que muestre el índice GINI.
La capa superior recuperará la información del [banco mundial](https://api.worldbank.org/v2/en/country/all/indicator/SI.POV.GINI?format=json&date=2011:2020&per_page=32500&page=1&country=%22Argentina%22). Se recomienda el uso de API Rest y Python. Los datos de consulta realizados deben ser entregados a un programa en C (capa intermedia) que convocará rutinas en ensamblador para que hagan los cálculos de conversión de float a enteros y devuelva el índice de un país como Argentina u otro sumando uno (+1). Luego el programa en C o python mostrará los datos obtenidos.-

Se debe utilizar el stack para enviar parámetros y devolver resultados. O sea utilizar las convenciones de llamadas de lenguajes de alto nivel a bajo nivel.

Por más info sobre stack frame en 64 bits:
https://eli.thegreenplace.net/2011/09/06/stack-frame-layout-on-x86-64

- **En una primera iteración** resolverán todo el trabajo práctico usando c con python sin ensamblador.
- **En la segunda iteración** usarán los conocimientos de ensamblador para completar el tp.

IMPORTANTE: en esta segunda iteración deberán mostrar los resultados con gdb, para ello pueden usar un programa de C puro. Cuando depuren muestran el estado del área de memoria que contiene el stack antes, durante y después de la función.

## condiciones de aprobación

La defensa del trabajo es GRUPAL.

Las presentaciones de los trabajos se realizan utilizando GitHub (una cuenta privada). Cada grupo debe asignar un responsable (con email institucional) como usuario de la cuenta de GitHub. Cada usuario tendrá un fork de ese otro usuario. Todos los repositorios estarán sincronizados. Se debe realizar un commit brevemente comentado con cada funcionalidad implementada y validada.- Los usuarios que no sean el representante deberán hacer pull request.

Casos de prueba, diagramas de bloques, diagrama de secuencia, pruebas de performance para comparar c y python son bienvenidos, profiling de la app de c es un plus.

## Docker

El proyecto incluye un `Dockerfile` y un `Makefile` para construir y ejecutar el contenedor sin necesidad de `docker-compose`.

Targets disponibles:

- `make build` — construye la imagen
- `make run` — ejecuta el contenedor en primer plano (Ctrl+C para detener, se elimina al salir)
- `make stop` — detiene el contenedor
- `make rm` — elimina el contenedor de forma forzada
- `make logs` — muestra los logs del contenedor en ejecución
- `make rebuild` — elimina el contenedor y reconstruye la imagen sin caché

Por defecto la app queda expuesta en `http://localhost:5000`. Para usar otro puerto:

```bash
make run PORT=8080
```

## Endpoints

Con el contenedor corriendo la API queda disponible en `http://localhost:5000`.

### `GET /values/plusone/<date_start>/<date_end>`

Recupera el índice GINI del Banco Mundial en el rango de años indicado y le aplica la rutina `middleware` (suma 1 al valor).

Los parámetros se pasan en el **path**, no como query string:

```bash
curl http://localhost:5000/values/plusone/2011/2020
```

O desde el navegador: [http://localhost:5000/values/plusone/2011/2020](http://localhost:5000/values/plusone/2011/2020).

### `GET /values/default`

Devuelve los valores por defecto definidos en el backend.

```bash
curl http://localhost:5000/values/default
```

### `GET /`

Lista en formato HTML todas las rutas registradas en la app.

## Librería en C (`libreria.so`)

La capa intermedia en C se compila como librería dinámica y Python la carga con `ctypes`. Cada iteración tiene su propio `Makefile` en el subdirectorio correspondiente (`iteracion-1/Makefile`, `iteracion-2/Makefile`).

### Targets

- `make compile` — limpia builds previos, compila `middleware.c` a objeto (`.o`), linkea la librería dinámica `libreria.so` y borra los `.o` intermedios.
- `make clean` — elimina cualquier `.o` y `.so` del directorio.

### Flags de `gcc` utilizados

| Flag        | Significado                                                                                                                                                                                                                                  |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-c`        | Compila a archivo objeto (`.o`) sin linkear.                                                                                                                                                                                                 |
| `-Wall`     | Habilita warnings comunes (variables sin usar, comparaciones sospechosas, etc.).                                                                                                                                                             |
| `-Werror`   | Trata cualquier warning como error: si hay warnings, no compila.                                                                                                                                                                             |
| `-pedantic` | Exige cumplimiento estricto del estándar C, rechaza extensiones de GCC.                                                                                                                                                                      |
| `-shared`   | Genera una librería dinámica (`.so`) en lugar de un ejecutable.                                                                                                                                                                              |
| `-fPIC`     | _Position Independent Code_. Obligatorio para librerías dinámicas: el código usa direcciones relativas al instruction pointer en vez de absolutas, así puede cargarse en cualquier dirección que decida el loader en runtime.                |
| `-g`        | Incluye símbolos de debug (DWARF) en el binario. Necesario para poder inspeccionar con **gdb** nombres de funciones, variables y números de línea. El enunciado pide mostrar el stack con gdb en la iteración 2, por eso es obligatorio acá. |
| `-o <file>` | Nombre del archivo de salida.                                                                                                                                                                                                                |

### Uso

```bash
cd iteracion-1   # o iteracion-2
make compile     # genera libreria.so
make clean       # borra artefactos
```

### Compilación del archivo ensamblador (iteración 2)

En la iteración 2 hay además un archivo en ensamblador (`floatToIntPlusOne.s`) que implementa la rutina que antes estaba en C. El mismo `gcc` sabe compilar archivos `.s`: internamente invoca al ensamblador (`as`) para generar el `.o` y luego lo linkea.

```bash
gcc -c -g floatToIntPlusOne.s -o floatToIntPlusOne.o
gcc -shared -fPIC -g -o libreria.so middleware.o floatToIntPlusOne.o
```

Notas:

- `-g`: agrega los símbolos de debug necesarios para ver las instrucciones de `floatToIntPlusOne` desde gdb con `disassemble` o `layout asm`.

## Informe

- [ ] [Informe - Iteracion 1 - Python + C](./Informe/informe-iteracion1.md)
- [ ] [Informe - Iteracion 2 - Python + C + ASM](./Informe/informe-iteracion2.md)

## Branch

```bash
						 /-- integrante --\			   /-- integrante --\
						/				   \	      /				     \
					 /-+- interacion1 ------+--\   /-+- interacion2 ------+-\
					/				        	\ /				    	  	 \
		 /-- dev --+-----------------------------+----------------------------+---
    	/																	     \
master +--------------------------------------------------------------------------+----
```
