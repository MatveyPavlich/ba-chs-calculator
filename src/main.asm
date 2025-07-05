%include "./src/data.asm"
%include "./src/functions.asm"

section .text
global _start

_start:
    MOV esi, output_string
    print input_lba,  input_lba_len
    read lba, 3

    ; MOV al, [lba]                       ; Get LBA
    MOV ax, [disk_heads]                  ; Move number of disk heads from memo
    MUL WORD [disk_sectors_per_track]     ; Get sectors in a cylinder
    MOV BYTE [sectors_in_cylinder], al    ; Save the value of sectors in a cylinder
    XOR eax, eax
    MOV al, [lba]
    DIV BYTE [sectors_in_cylinder]
    MOV [esi], al
    INC esi
    add_comma

    XOR al, al
    MOV al, ah                            ; Get remainding sectors
    INC al
    XOR ah, ah
    DIV WORD [disk_sectors_per_track]   ; do sectors / 
    MOV [esi], al
    INC esi
    add_comma
    MOV [esi], ah
    INC esi
    MOV BYTE [esi], 0x0A
    INC esi
    MOV BYTE [esi], 0x00
    XOR eax, eax
    MOV eax, esi
    SUB eax, output_string 

    print output_chs, output_chs_len
    print output_string, eax

    MOV eax, 1
    XOR ebx, ebx
    INT 0x80