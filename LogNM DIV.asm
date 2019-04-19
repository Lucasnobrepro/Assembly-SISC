%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    mov eax, 8
    mov ecx, 2
    mov ebx, 0
    mov edx, 0
   
    call Log
    PRINT_UDEC 4, EBX
   
    xor eax, eax
    ret
    
Log:
    enter 0,0
    div ecx
    sub eax, 0
    jz EndLog
    call Log
    inc ebx
    
EndLog:
    leave
    ret