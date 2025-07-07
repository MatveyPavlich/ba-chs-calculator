; Support for 2 digits only

%include "./src/data.asm"
%include "./src/functions.asm"

section .text
global _start

_start:
    MOV   esi,        output_string
    print input_lba,  input_lba_len
    read  lba,        3

    MOV   ax,         [disk_heads]        ; Move number of disk heads from memo
    MUL WORD [disk_sectors_per_track]     ; Get sectors in a cylinder
    MOV bl, al                            ; Move sectors / cylinder to bl
    PUSH ebx                              ; Save the value of sectors in a cylinder
    
    XOR eax, eax
    XOR ebx, ebx
    XOR ecx, ecx
    atoi lba                              ; Convert imputted string to int

    POP ebx
    DIV bl   
    ADD al, '0'
    MOV BYTE [esi], 'C'
    INC esi
    MOV BYTE [esi], '='
    INC esi
    MOV [esi], al
    INC esi
    add_comma

    XOR al, al
    MOV al, ah                            ; Get remainding sectors
    INC al
    XOR ah, ah
    DIV BYTE [disk_sectors_per_track]     ; do sectors / (sectors in a cylinder)
    ADD al, '0'
    MOV BYTE [esi], 'H'
    INC esi
    MOV BYTE [esi], '='
    INC esi
    MOV [esi], al
    INC esi
    add_comma
    MOV BYTE [esi], 'S'
    INC esi
    MOV BYTE [esi], '='
    INC esi
    
    CALL print_sectors
    ADD ah, '0'
    MOV [esi], ah
    INC esi
    MOV BYTE [esi], 0x0A
    INC esi
    SUB esi, output_string 

    print output_chs, output_chs_len

    XOR eax, eax
    XOR ebx, ebx
    XOR ecx, ecx
    XOR edx, edx
    print output_string, esi

    MOV eax, 1
    XOR ebx, ebx
    INT 0x80