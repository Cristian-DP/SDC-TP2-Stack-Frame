global sumar_uno
global convertir_float_a_int

section .text

; Convención de llamadas: System V AMD64 ABI


; ------------------------------------------------------------
; sumar_uno: recibe un entero en RDI, devuelve RDI + 1 en RAX
; ------------------------------------------------------------
sumar_uno:
    push    rbp             ; Guarda el marco y
    mov     rbp, rsp        ; establece el nuevo stack frame

    mov     rax, rdi        ; Copia el argumento al registro de retorno
    add     rax, 1          ; suma 1

    pop     rbp             ; Restaura el marco del llamador
    ret                     ; Retorna con resultado en RAX

; ------------------------------------------------------------
; convertir_float_a_int: recibe un float en XMM0,
; lo trunca a entero y devuelve el resultado en RAX
; ------------------------------------------------------------
convertir_float_a_int:
    push    rbp             ; Guarda el marco y
    mov     rbp, rsp        ; establece el nuevo stack frame
    and     rsp, -16        ; Alinea el stack a 16 bytes (requerido para XMM)

    cvttss2si rax, xmm0     ; Convierte float → entero truncando decimales

    mov     rsp, rbp        ; Restaura RSP antes de salir
    pop     rbp             ; Restaura el marco del llamador
    ret                     ; Retorna con resultado en RAX

section .note.GNU-stack noalloc noexec nowrite progbits