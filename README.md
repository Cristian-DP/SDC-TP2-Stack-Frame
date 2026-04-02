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

Las presentaciones de los trabajos se realizan utilizando GitHub (una cuenta privada). Cada grupo debe asignar un responsable (con email institucional) como usuario de la cuenta de GitHub. Cada usuario tendrá un fork de ese otro usuario. Todos los repositorios estarán sincronizados. Se debe realizar un commit brevemente comentado con cada funcionalidad implementada y validada.-  Los usuarios que no sean el representante deberán hacer pull request. 

Casos de prueba, diagramas de bloques, diagrama de secuencia, pruebas de performance para comparar c y python son bienvenidos, profiling de la app de c es un plus.

## Informe

- [ ] [Informe - Iteracion 1 - Python + C](./Informe/informe-iteracion1.md)
- [ ] [Informe - Iteracion 2 - Python + C + ASM](./Informe/informe-iteracion2.md)

## Branch

```bash
						 /-- integrante --\			   /-- integrante --\
						/				   \	      /				     \
					 /--- interacion1 ------+--\   /--- interacion2 ------+-\
					/				        	\ /				    	  	 \
		 /-- dev --+-----------------------------+----------------------------+---
    	/																	     \
master +--------------------------------------------------------------------------+----
```
