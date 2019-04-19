%include "io.inc"

section .data

section .bss

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_DEC 4, eax          ;Recebe um decimal e guarda em eax.
    GET_DEC 4, ebx          ;Recebe um decimal e guarda em ebx.
    call Divisao            ;aqui chamo a função de Divisão (Pode ser qualquer operação).
    PRINT_UDEC 4,eax        ;Printo o resultado da operação chamada acima
    ;write your code here
    xor eax, eax
    ret
    
    Soma:
    ;Requires:EAX,EBX
    add eax,ebx             ;Add o valor de ebx em eax.
    ret                     ;Faz o retorno da função.
    
    Subtracao:              ;Sub o vaode ebx de eax.
    sub eax, ebx
    ret                     ;Faz o retorno da função.
    
    Multiplicacao:
    mov ecx ,ebx            ;Salvo o valor de ebx em ecx.
    mov edx, eax            ;Salvo o valor de eax em edx.
    mov eax, 0              ;salvo 0 em eax.
    
        l1:
        add eax,edx         ;Adicion edx em eax.
        loop l1             ;Repito ater que ecx seja seja zero.

    ret                     ;Faz o retorno da função.
    
    Divisao:
    mov ecx, eax
    mov edx,0    
        l2:
        inc edx
        call Subtracao
        js l3
        loop l2
    l3:
    dec edx
    mov eax, edx
      ret
       
    
    
    
    
    
    
    
    
    
    
    