%macro print 2
    MOV eax, 4            ; SYS_WRITE
    MOV ebx, 1            ; FD_STDOUT
    MOV ecx, %1           ; String start
    MOV edx, %2           ; String length
    INT 0x80              ; Call interrupt

%endmacro

%macro read 2
    MOV eax, 3            ; SYS_READ
    MOV ebx, 0            ; FD_STDIN
    MOV ecx, %1           ; memo to store read
    MOV edx, %2           ; Max read length
    INT 0x80              ; Call interrupt

%endmacro

%macro add_comma 0
    MOV BYTE [esi], ','
    INC esi
    MOV BYTE [esi], ' '
    INC esi
%endmacro

; %1 - lba
%macro atoi 1
    MOV al, [%1]                            ; Get inputted lba
    SUB al, '0'                           ; Convert to integer
    CMP BYTE [(%1 + 1)], 0x0A
    JE %%end_conversion
    MOV bl, [(%1 + 1)]
    SUB bl, '0'
    MOV cl, 10
    MUL cl                            ; *10 the first number since it is x*10^1
    ADD al, bl
    JMP %%end_conversion

%%end_conversion:
    XOR bl, bl
%endmacro

print_sectors:
    CMP ah, 10
    JGE .two_digits
    RET

.two_digits:
    MOV al, ah
    XOR ah, ah
    MOV bl, 10
    DIV bl
    ADD al, '0'
    MOV [esi], al
    INC esi
    XOR al, al
    RET
