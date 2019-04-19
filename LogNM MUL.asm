%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    GET_UDEC 4, EBX
    GET_UDEC 4, ECX
    mov edi, 0
    mov eax, 1
    
    CALL Log
    div ecx
    mov edx, 0
    cmp ebx, eax
    ja Trat
    
    PRINT_UDEC 4, edi
    jmp fim
    
    Trat:
    inc edi
    PRINT_UDEC 4, edi
    
    fim:
    
    xor eax, eax
    ret 
    
Log:
    enter 0,0
    mul ecx
    cmp eax, ebx
    ja EndLog
    inc edi

    call Log
    
EndLog:
    LEAVE
ret 

