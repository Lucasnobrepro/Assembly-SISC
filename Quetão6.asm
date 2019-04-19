%include "io.inc"

section .data

array dw 10,20,30,40
size equ ($-array)/2

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ecx, size-1
    
    mov eax, [array+(ecx*2)]
    mov esi,ecx
    l1:
    
    ;mov [array+(esi*2)],[array+(esi*2)-2],
    
    mov ebx, [array+(esi*2)-2]
    mov [array+(esi*2)], ebx
    dec esi
    loop l1
    mov esi, 0
    mov [array], ax
    
    PRINT_DEC 2, eax
        PRINT_DEC 2, [array+2]
            PRINT_DEC 2, [array+4]
                PRINT_DEC 2, [array+6]
    xor eax, eax
    ret