/*
	Los datos de consulta realizados deben ser entregados a un programa en C (capa intermedia) hagan los cálculos de conversión de float a enteros
    y devuelva el índice de un país como Argentina u otro sumando uno (+1).
*/

#include <stdio.h>

extern int sumar_uno(int valor);

extern int convertir_float_a_int(float valor);

int process_gini_value(float value) {
    return sumar_uno(convertir_float_a_int(value));
}

int main(int argc, char const *argv[])
{
    process_gini_value(1.0);
    return 0;
}