%include "io.inc"

section .bss
    parcela RESB 100
    total RESB 100
    cont RESB 4

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ebp, esp
    GET_DEC 4, ecx
    mov ebx,0
    call FATORIAL
    PRINT_HEX 4, [total+4]
    PRINT_HEX 4, eax
    
    
    xor eax, eax
    
    ret
;------------------------------
FATORIAL:
;parametro ecx, endereço de memoria de 100bytes
;retorno endereço de memoria de 100bytes
;------------------------------
    mov [total],ecx       ;move valor de ecx para edx
    dec ecx           ;decrementa ecx
.l2:
    call MULTIPLICACAO;chama a função multiplicação
   ; jo 
    mov [total], eax
    dec ecx
    jnz .l2     
    ret
;------------------------------
MULTIPLICACAO:
;parametro ecx, edx
;retorne eax
;------------------------------
    push ecx
    mov eax, 0
.l1:
    add eax,[total]
;   mov [parcela], eax
    loop .l1
    pop ecx
    ret
    
comCarry:

    L3:
    add ebx,4
    mov edx, 1
    add [cont],edx
    
    add [total+ebx],edx
    add [parcela+ebx], edx
    
    
    .l1:
    
    loop .l1
    ret
    
    
    
    
    
    
    
    
    
    