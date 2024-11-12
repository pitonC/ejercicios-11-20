.global _start

.section .data
    arreglo: .word 10, 20, 30, 40, 50 // Arreglo ordenado
    longitud: .word 5                   // Longitud del arreglo
    objetivo: .word 30                  // Valor objetivo a buscar

.section .text
_start:
    // inicializar punteros y cargar longitud y objetivo
    ldr r0, =arreglo         // Cargar la dirección del arreglo
    ldr r1, =longitud        // Cargar la longitud
    ldr r1, [r1]             // Cargar la longitud
    ldr r2, =objetivo        // Cargar el valor objetivo
    ldr r2, [r2]             // Cargar el valor objetivo

    mov r3, #0              // Inicializar índice bajo
    sub r4, r1, #1          // Inicializar índice alto

busqueda_binaria:
    cmp r3, r4              // Comparar índices
    bgt no_encontrado       // Si el índice bajo es mayor que el alto, termina

    add r5, r3, r4          // Calcular el índice medio
    lsr r5, r5, #1          // Descartar el bit más bajo (división por 2)
    ldr r6, [r0, r5, lsl #2] // Cargar el valor en el índice medio
    cmp r6, r2              // Comparar con el objetivo
    beq encontrado          // Si es igual, objetivo encontrado

    blt buscar_derecha      // Si es menor, buscar en la mitad derecha
    mov r4, r5              // Si es mayor, buscar en la mitad izquierda
    b busqueda_binaria

buscar_derecha:
    add r3, r5, #1          // Mover el índice bajo a la derecha
    b busqueda_binaria

encontrado:
    mov r0, #1              // Retornar 1 para indicar que se encontró el valor
    b fin

no_encontrado:
    mov r0, #0              // Retornar 0 para indicar que no se encontró el valor

fin:
    mov r7, #1              // syscall exit
    swi 0
