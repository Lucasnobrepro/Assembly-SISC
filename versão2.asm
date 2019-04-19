%include "io.inc"

section .bss
   
    vet1 resd 25  ;d reserva 4 bytes por isso 25
    vet2 resd 25  
    
section .data

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ebp, esp
    ;Como exemplo pego ecx como 5
    GET_DEC 4, ecx
    mov esi,25
    mov [vet1+(esi*4)], ecx 		;Movo para ultima posição de de vet1 o valor de ecx = 5

    call FATORIAL
    ;PRINT_HEX 4, [vet1+(23*4)]
    ;PRINT_HEX 4, [vet2+(24*4)]
    PRINT_HEX 4, [vet2+(esi*4)]
    
    xor eax, eax
    
    ret
;------------------------------
FATORIAL:
;parametro ecx, endereço de memoria de 100bytes
;retorno endereço de memoria de 100bytes

jmp posvet 				;Serve para garantir que quando exercutar o fatorial não entre diretamente 
          				;na função carry e pule dela para posvet.

carry:     				;Função que ativa quando tem carry que pegar em qual posição que vc ta dos 100 bytes
           				;e passa para a anterio somando 1. EXEMPLO: esi é 25, então a posição de memoria é 100
           				;como houve carry se adiciona na posição 100-4 ou seja na 96. 
    mov edx, 1
    add dword[vet2+((esi*4)-4)], edx  	;Adiciono 1 na proxima posição
    jmp  L3
    
;------------------------------
posvet:
    soma:
    ;Função de referencia       
    ;mov [vet2+(esi*4)], [vet1+(esi*4)]
    mov eax, [vet1+(esi*4)]         ;Copia de o que tem na posição(esi*4)de vet1
    mov [vet2+(esi*4)],eax          ;para o vet2 através do eax.
    
    and dword[vet1+(esi*4)],0       ;zero todo o vet1

    push ecx                        ;enpilho o ecx = 5, primeiro empilhamento
    dec ecx                         ;ecx = 4.

        l1:                         ;Esse 1º loop serve para soma na mesma posição o mesmo valor ecx
                                    ;vezes e quando tiver um carry adicionar 1 na proxima posição.
        js l2                       ;js serve para verificar se ecx é menor que Zero.
        ;Função de referencia
        ;add [vet1+(esi*4)], [vet2+(esi*4)]
        mov eax,[vet2+(esi*4)]
        add [vet1+(esi*4)], eax

        jo carry
        L3:                          ;Após ocorrencia do carry retorna para a leibó.
        loop l1                      ;Loop irá executar 4 vezes quando ecx receber 5.
    l2:
    pop ecx                          ;Desempilha ecx fazendo ele voltar para 5
    dec esi                          ;Decremento ESI para poder me movimentar
    jnz soma                         ;Esse jmp é para fazer a soma de todos os bytes em 4 em 4 bytes.
    dec ecx
    mov esi, 25
    js l4                            ;Se eu decrementar ecx para menos que zero.
    loop posvet                      
    l4:
ret


        
