.global _start

.section .data
    matriz1: .word 1, 2, 3, 4, 5, 6
    matriz2: .word 6, 5, 4, 3, 2, 1
    resultado: .word 0, 0, 0, 0, 0, 0
    longitud: .word 6

.section .text
_start:
    // inicializar punteros y cargar longitud
    ldr r0, =matriz1         // Cargar la dirección de la primera matriz
    ldr r1, =matriz2         // Cargar la dirección de la segunda matriz
    ldr r2, =resultado       // Cargar la dirección del resultado
    ldr r3, =longitud        // Cargar la longitud
    ldr r3, [r3]             // Cargar la longitud

    mov r4, #0               // Inicializar el índice
sumar_matrices:
    cmp r4, r3               // Si el índice es igual a la longitud, termina
    bge fin_suma

    ldr r5, [r0, r4, lsl #2] // Cargar el valor de la primera matriz
    ldr r6, [r1, r4, lsl #2] // Cargar el valor de la segunda matriz
    add r7, r5, r6           // Sumar los valores
    str r7, [r2, r4, lsl #2] // Guardar el resultado

    add r4, r4, #1           // Incrementar el índice
    b sumar_matrices

fin_suma:
    mov r7, #1               // syscall exit
    swi 0
