.global _start

.section .data
    arreglo: .word 10, 20, 30, 50, 40 // Arreglo de ejemplo
    longitud: .word 5                   // Longitud del arreglo

.section .text
_start:
    // Inicializar puntero y cargar la longitud
    ldr r0, =arreglo         // Cargar la dirección del arreglo
    ldr r1, =longitud        // Cargar la longitud
    ldr r1, [r1]             // Cargar el valor de longitud

    mov r2, #0              // Inicializar el índice en 0
    ldr r3, [r0, r2, lsl #2] // Cargar el primer valor del arreglo en r3 (el máximo hasta ahora)

max_loop:
    cmp r2, r1              // Comparar el índice con la longitud
    bge end_max             // Si el índice es mayor o igual a la longitud, terminar

    ldr r4, [r0, r2, lsl #2] // Cargar el siguiente valor del arreglo
    cmp r3, r4              // Comparar el máximo actual con el nuevo valor
    bge next_item           // Si el máximo no cambia, ir al siguiente elemento

    mov r3, r4              // Si es mayor, actualizar el máximo

next_item:
    add r2, r2, #1          // Incrementar el índice
    b max_loop

end_max:
    // El  máximo encontrado está en r3
    mov r0, r3              // Devolver el valor máximo
    mov r7, #1              // syscall exit
    swi 0

