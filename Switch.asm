%include "io.inc"

section .data
    CaseTable DD 0  
    DD 300      ; lookup value
    DD Process_A           ; address of procedur
    EntrySize EQU ($ - CaseTable)
    DD 301
    DD 500
    DD Process_B
    DD 501
    DD 700
    DD Process_C
    DD 701
    DD 800
    DD Process_D
    DD 801
    DD 1000
    DD Process_E
    DD 1001
    DD 1001
    DD Process_F
    NumberOfEntries EQU ($ - CaseTable) / EntrySize
    
    msgA DB "50%",0
    msgB DB "40%",0
    msgC DB "30%",0
    msgD DB "20%",0
    msgE DB "10%",0        
    msgF DB "5%",0
   
    Tambyte EQU 4
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    ;jb menor que
    ;ja maior
    ;jbe menor igual
    ;jae maior igual
    mov ebp, esp; for correct debugging
    GET_UDEC 4,eax
    mov ebx, CaseTable            ; point EBX to the table
    mov ecx, NumberOfEntries      ; loop counter
L1: cmp eax,[ebx]                 ; comparando com o limite inferior
    jnae L2
    cmp eax,[ebx+(1 *Tambyte)]    ; comparando com o limite superior  
    jnbe L2
    
    call [ebx+(2 *Tambyte)]       ; 
    PRINT_STRING [EDX]              ; display message
    NEWLINE
    jmp L3
                            ; and exit the loop
L2: add ebx,EntrySize             ; point to next entry
    dec ecx
    JNZ L1                        ; repeat until ECX = 0
    call Process_F
L3:
    xor eax, eax
    ret
    
Process_A:
mov edx, msgA
ret
Process_B:
mov edx, msgB
ret
Process_C:
mov edx, msgC
ret
Process_D:
mov edx, msgD
ret
Process_E:
mov edx, msgE
ret
Process_F:
mov edx, msgF
ret