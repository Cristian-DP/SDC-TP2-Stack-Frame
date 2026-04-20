# GDB

- [Cristian Pereyra](./informe-iteracion2-Cristian.md)
- [Nicolas Lopez](./informe-gdb-Nicolas.md)


# Docker

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

El Dockerfile esta  construido en modo multistage permitiendo separar logicas de construcción y ejecición. La Etapa de construcción se centra en obtener la librari dinamica que será utilizada por la interface. Mientras que la etapa de ejecución se ecnarga de ejecutar la api rest; tomando de la etapa de construcción el directorio donde se encuntra la libraria dinamica

## Uso

```bash
# En directorio root
make build
```

# Endpoints

Con el contenedor corriendo la API queda disponible en `http://localhost:5000`.

## `GET /values/plusone/<date_start>/<date_end>`

Recupera el índice GINI del Banco Mundial en el rango de años indicado y le aplica la rutina `middleware` (suma 1 al valor).

Los parámetros se pasan en el **path**, no como query string:

```bash
curl http://localhost:5000/values/plusone/2011/2020
```

O desde el navegador: [http://localhost:5000/values/plusone/2011/2020](http://localhost:5000/values/plusone/2011/2020).

## `GET /values/default`

Devuelve los valores por defecto definidos en el backend.

```bash
curl http://localhost:5000/values/default
```

## `GET /`

Lista en formato HTML todas las rutas registradas en la app.

# Librería en C (`libreria.so`)

La capa intermedia en C se compila como librería dinámica y Python la carga con `ctypes`. Cada iteración tiene su propio `Makefile` en el subdirectorio correspondiente (`iteracion-1/Makefile`, `iteracion-2/Makefile`).

## Targets

- `make compile` — limpia builds previos, compila `middleware.c` a objeto (`.o`), linkea la librería dinámica `libreria.so` y borra los `.o` intermedios.
- `make clean` — elimina cualquier `.o` y `.so` del directorio.

## Flags de `gcc` utilizados

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

## Uso

```bash
cd iteracion-1   # o iteracion-2
make compile     # genera libreria.so
make clean       # borra artefactos
```

## Compilación del archivo ensamblador (iteración 2)

En la iteración 2 las rutinas de bajo nivel viven en `routines.asm`, escrito en **sintaxis NASM (Intel)**. Expone dos funciones que respetan la convención System V AMD64 ABI:

| Función | Argumento | Retorno |
|---|---|---|
| `sumar_uno` | entero en `%rdi` | entero en `%rax` |
| `convertir_float_a_int` | float en `%xmm0` | entero en `%rax` |

El `middleware.c` las compone: `process_gini_value(float) = sumar_uno(convertir_float_a_int(float))`.

### Dependencia adicional: `nasm`

Como el archivo está en sintaxis NASM, **no** puede ensamblarse con `as` (GNU). Hay que instalar `nasm`:

```bash
sudo apt install nasm
```

### Comandos

El `Makefile` de `iteracion-2/` ya hace todo:

```bash
cd iteracion-2
make compile
```

Equivalente manual:

```bash
nasm -f elf64 -g -o routines.o routines.asm
gcc -c -Wall -Werror -fPIC -g -o middleware.o middleware.c
gcc -shared -o libreria.so middleware.o routines.o
```

Notas:

- `-f elf64`: formato de objeto ELF de 64 bits (Linux x86-64).
- `-g` (en `nasm` y `gcc`): símbolos de debug para inspeccionar las rutinas desde gdb con `disassemble` o `layout asm`.

<<<<<<< HEAD
Para más detalle de las rutinas y la convención de llamadas ver [`iteracion-2/README.md`](./iteracion-2/README.md).
=======
Para más detalle de las rutinas y la convención de llamadas ver [`iteracion-2/README.md`](./iteracion-2/README.md).
>>>>>>> origin/informe/cristian
