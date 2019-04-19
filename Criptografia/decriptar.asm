;A file copy program                                               file_copy.asm
;
;Objective: To copy a file using the int 0x80 services.
;    Input: Requests names of the input and output files.
;   Output: Creates a new output file and copies contents of the input file.

;%include "io.inc"

%define BUF_SIZE 256

section .data

section .bss

out_file_name resb 30
fd_in resd 1
fd_out resd 1
in_buf resd BUF_SIZE

section .text
global descriptografar
descriptografar:
    mov esi,0
    mov eax,[esp+8]
        
init:                               ;Para mudar o nome do arquivo de saida
    cmp byte[eax+esi], '_'          ;subtituindo '_' por '.' e colocando crpt
    je ponto                        ;como tipo de arquivo.
    mov bl,[eax+esi]
    mov byte[out_file_name+esi],bl  
    inc esi
    jmp init
      
    ponto:
    mov bl, '.'
    mov byte[out_file_name+esi],bl
    inc esi
    
    mov bl,[eax+esi]
    mov byte[out_file_name+esi],bl  
    inc esi
    mov bl,[eax+esi]
    mov byte[out_file_name+esi],bl  
    inc esi
    mov bl,[eax+esi]
    mov byte[out_file_name+esi],bl
        
    ;open the input file
    mov EAX,5            ;file open
    mov EBX,[esp+8] ;input file name pointer
    mov ECX,0            ;access bits (read only)
    mov EDX,0700         ;file permissions
    int 0x80
    mov [fd_in],EAX      ;store fd for use in read routine    
    
    cmp EAX,0
    jge create_file
;    PRINT_STRING in_file_err_msg
;    NEWLINE
    jmp done
    
create_file:
;create output file
mov EAX,8                ;file create
mov EBX,out_file_name    ;output file name pointer
mov ECX,777             ;r/w/e by owner only
int 0x80
mov [fd_out],EAX         ;store fd for use in write routine
cmp EAX,0                ;create error if fd < 0
jge repeat_read
;PRINT_STRING out_file_err_msg
;NEWLINE
jmp close_exit

repeat_read:
; read input file
    mov EAX,3             ;file read
    mov EBX, [fd_in]      ;file descriptor
    mov ECX, in_buf       ;input buffer
    mov EDX, BUF_SIZE     ;size
    int 0x80

    ;emcriptar
        xor esi,esi
        mov ebx,[esp+4]
    criptacao:
        ;xor [in_buf+esi], ebx       ;Xor para modificar caractere a caractere do que está 
        sub [in_buf+esi], ebx
        inc esi                     ;no arquivo, com uma KEY que foi guardada por ebx
        cmp eax,esi                 ;por exemplo o nome lucas com a chave 3.
        jne criptacao

  ;write to output file
    mov EDX,EAX           ;byte count
    mov EAX,4             ;file write
    mov EBX,[fd_out]      ;file descriptor
    mov ECX,in_buf        ;input buffer
    int 0x80
    
    cmp EDX,BUF_SIZE      ; EDX = # bytes read
    jl  copy_done         ; EDX < BUF_SIZE indicates end-of-file
    
    jmp repeat_read
    
copy_done:
    mov EAX,6             ;close output file
    mov EBX,[fd_out]
    int 0x80
close_exit:   
    mov EAX,6             ;close input file
    mov EBX,[fd_in]
    int 0x80
done:
    mov eax,1
    int 0x80
    ret