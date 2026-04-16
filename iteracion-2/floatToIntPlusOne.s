.section .text
    .globl  floatToIntPlusOne      
    .type   floatToIntPlusOne, @function

floatToIntPlusOne:
    # Prólogo — preparamos el stack frame
    pushq   %rbp        # pushq indica QuadWord que es una palabra de 8bytes -> 64 bits 
    movq    %rsp, %rbp

    # En x86-64 Linux, el primer float llega por el registro %xmm0 por convención 

    cvttss2si %xmm0, %eax   # cvttss2si convierte el valor de punto flotante en xmm0 a un entero (truncando) y lo guarda en eax
    incl      %eax          # incrementa el valor de eax en 1

    # Epílogo — restauramos el estado anterior
    popq    %rbp        # restaurar el valor original de rbp 
    ret                 # retornar al llamador con el resultado en eax

    # Registra el tamaño de la función en la tabla de símbolos del ELF.
    # El '.' es el "location counter": la dirección actual donde está el ensamblador (justo después del 'ret').

    # Restarle la etiqueta 'floatToIntPlusOne' (su dirección de inicio) da como
    # resultado la cantidad de bytes que ocupa la función.
    # Esto sirve para que gdb, objdump y el linker sepan dónde termina la función:
    # sin este .size el debugger no puede mostrar correctamente los límites al
    # hacer 'disassemble floatToIntPlusOne'.
    .size   floatToIntPlusOne, .-floatToIntPlusOne

# Marcar que este objeto NO requiere stack ejecutable.
# Sin esta línea el linker marca el .so como "necesita exec stack" y el kernel
# rechaza cargarlo (error: cannot enable executable stack as shared object requires).
.section .note.GNU-stack,"",@progbits
