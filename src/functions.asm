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

%macro add_comma 0
    MOV BYTE [esi], ','
    INC esi
    MOV BYTE [esi], ' '
    INC esi
%endmacro