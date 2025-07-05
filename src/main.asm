%define num1 memory_buffer
%define num2 memory_buffer + 3

%macro print 2
    MOV eax, 4            ; SYS_WRITE
    MOV ebx, 1            ; FD_STDOUT
    MOV ecx, %1           ; String start
    MOV edx, %2           ; String length
    INT 0x80              ; Call interrupt

%endmacro

%macro read 2
    MOV eax, 3            ; SYS_READ
    MOV ebx, 1            ; FD_STDIN
    MOV ecx, %1           ; memo to store read
    MOV edx, %2           ; Max read length
    INT 0x80              ; Call interrupt

%endmacro

section .data
    input_lba               DB "Enter LBA: ", 0x00
    input_lba_len           EQU $ - input_lba
    
    output_chs              DB "CHS: ", 0x0A, 0x00
    output_chs_len          EQU $ - output_chs
    
    disk_heads              DB 2
    disk_sectors_per_track  DB 18


section .bss
    memory_buffer RESB 10

section .text
global _start

_start:
    print input_lba,  input_lba_len
    read num1, 3
    print output_chs, output_chs_len

    MOV eax, 1
    XOR ebx, ebx
    INT 0x80