section .data
    input_lba               DB "Enter LBA: ", 0x00
    input_lba_len           EQU $ - input_lba
    
    output_chs              DB "CHS: ", 0x00
    output_chs_len          EQU $ - output_chs
    
    disk_heads              DW 2
    disk_sectors_per_track  DW 18

section .bss
    lba                     RESB 2
    sectors_in_cylinder     RESB 1
    output_string           RESB 20
