.global _start

.section .data
    arreglo: .word 50, 40, 30, 20, 10 // Arreglo desordenado
    longitud: .word 5                   // Longitud del arreglo

.section .text
_start:
    // inicializar puntero y cargar longitud
    ldr r0, =arreglo         // Cargar la dirección del arreglo
    ldr r1, =longitud        // Cargar la longitud
    ldr r1, [r1]             // Cargar la longitud

    sub r1, r1, #1           // Establecer el límite para las comparaciones

burbuja_loop:
    mov r2, #0              // Inicializar el índice en 0
    mov r3, #0              // Bandera para verificar si hubo cambios

paso_burbuja:
    cmp r2, r1              // Comparar índice con el límite
    bge fin_burbuja         // Si el índice alcanza el límite, termina el ciclo

    ldr r4, [r0, r2, lsl #2] // Cargar el valor en la posición de índice
    ldr r5, [r0, r2, lsl #2 + 4] // Cargar el siguiente valor
    cmp r4, r5              // Comparar los dos valores
    ble siguiente_elemento   // Si están ordenados, continuar con el siguiente elemento

    // Intercambiar los valores
    str r5, [r0, r2, lsl #2] // Guardar el valor mayor en la posición actual
    str r4, [r0, r2, lsl #2 + 4] // Guardar el valor menor en la siguiente posición

    mov r3, #1              // Marcar que hubo un intercambio

siguiente_elemento:
    add r2, r2, #1          // Incrementar el índice
    b paso_burbuja

fin_burbuja:
    cmp r3, #0              // Comprobar si hubo intercambio
    beq fin_ordenamiento    // Si no hubo intercambio, ya está ordenado

    sub r1, r1, #1           // Reducir el límite para la siguiente iteración
    b burbuja_loop

fin_ordenamiento:
    mov r7, #1              // syscall exit
    swi 0
