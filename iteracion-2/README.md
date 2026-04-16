# Rutinas ASM — Iteración 2

## Descripción

Este módulo implementa dos rutinas en lenguaje ensamblador x86-64 (NASM) que forman la capa de bajo nivel del TP. Son invocadas desde C usando la convención de llamadas **System V AMD64 ABI**.

---

## Archivos

| Archivo | Descripción |
|---|---|
| `routines.asm` | Implementación de las rutinas en ensamblador |

---

## Funciones implementadas

### `sumar_uno`

Recibe un número entero, le suma 1 y devuelve el resultado.

- **Parámetro:** entero en `%rdi` (primer argumento entero según System V ABI)
- **Retorno:** resultado en `%rax`

### `convertir_float_a_int`

Recibe un número de punto flotante (`float`), lo convierte a entero truncando los decimales y devuelve el resultado.

- **Parámetro:** float en `%xmm0` (primer argumento de punto flotante según System V ABI)
- **Retorno:** resultado en `%rax`
- **Instrucción clave:** `cvttss2si` (Convert Truncate Scalar Single to Signed Integer)

---

## Cómo invocar desde C

### Declaración

Antes de usar las funciones en C, declararlas con `extern`:

```c
extern int sumar_uno(int valor);
extern int convertir_float_a_int(float valor);
```

### Ejemplo de uso

```c
#include <stdio.h>

extern int sumar_uno(int valor);
extern int convertir_float_a_int(float valor);

int main() {
    int resultado1 = sumar_uno(42);
    printf("sumar_uno(42) = %d\n", resultado1);  // 43

    int resultado2 = convertir_float_a_int(42.7);
    printf("convertir_float_a_int(42.7) = %d\n", resultado2);  // 42

    return 0;
}
```

---

## Compilación y linkeo

### Requisitos

```bash
sudo apt install nasm gcc
```

### Pasos

**1. Ensamblar el archivo ASM:**

```bash
nasm -f elf64 -g -o routines.o routines.asm
```

**2. Compilar el archivo C:**

```bash
gcc -g -O0 -c -o main.o main.c
```

**3. Linkear:**

```bash
gcc -o programa main.o routines.o
```

**4. Ejecutar:**

```bash
./programa
```

### Usando Make

Si el repositorio incluye un `Makefile`, simplemente ejecutar:

```bash
make        # compila todo
make clean  # elimina binarios generados
```

---

## Convención de llamadas (System V AMD64 ABI)

Las rutinas respetan la convención estándar de Linux x86-64:

| Argumento | Tipo entero/puntero | Tipo float |
|---|---|---|
| 1ro | `%rdi` | `%xmm0` |
| 2do | `%rsi` | `%xmm1` |
| Retorno | `%rax` | `%xmm0` |

Cada función implementa el prólogo y epílogo estándar:

```nasm
; Prólogo
push rbp
mov  rbp, rsp

; ... cuerpo de la función ...

; Epílogo
pop  rbp
ret
```

El valor de retorno siempre queda en `%rax` al momento de ejecutar `ret`.
