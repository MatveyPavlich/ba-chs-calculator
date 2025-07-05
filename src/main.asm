section .data

section .bss
    memory_buffer RESB 10

section .text
global _start

_start:
    mov ax, 0
    INT 0x80