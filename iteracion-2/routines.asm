global sumar_uno
global convertir_float_a_int

section .text

; Suma 1 al valor entero recibido en RDI y devuelve el resultado en RAX.
sumar_uno:
    push    rbp
    mov     rbp, rsp

    mov     rax, rdi
    add     rax, 1

    pop     rbp            
    ret  


convertir_float_a_int:
    push    rbp
    mov     rbp, rsp
    and     rsp, -16        ; alinea el stack a 16 bytes

    cvttss2si rax, xmm0     ; convierte el float en xmm0 a entero, resultado en rax

    mov     rsp, rbp        ; restaura rsp antes de salir
    pop     rbp
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
