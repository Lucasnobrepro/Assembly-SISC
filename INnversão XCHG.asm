%include "io.inc"

section .data
    array DW 1,2,3,4

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    mov  ax, [array]
    XCHG ax, [array+6]
    XCHG ax, [array]
    mov  ax, [array+4]
    XCHG ax, [array+2]
    XCHG ax, [array+4] 
    
    xor eax, eax
    ret