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
global criptografia
criptografia: 
    mov esi,0
    mov eax,[esp+8]
        
inicial:
    cmp byte[eax+esi], '.'
    je ponto
    cmp byte[eax+esi], 0
    je fim
    mov bl,[eax+esi]
    mov byte[out_file_name+esi],bl  
    inc esi
    jmp inicial
      
    ponto:
    mov bl, '_'
    mov byte[out_file_name+esi],bl
    inc esi
    jmp inicial
    
    fim:
    
    mov byte[out_file_name+esi],'.' 
    mov byte[out_file_name+esi+1],'c'
    mov byte[out_file_name+esi+2],'r'
    mov byte[out_file_name+esi+3],'p'
    mov byte[out_file_name+esi+4],'t'
    ;PRINT_STRING in_fn_prompt
    ;GET_STRING in_file_name, 30
    ;PRINT_STRING out_fn_prompt
    ;GET_STRING out_file_name,30
        
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

    xor esi,esi
    mov ebx,[esp+4]
    codificar:
        ;xor [in_buf+esi], ebx
        add [in_buf+esi], ebx
        inc esi
        cmp eax,esi
        jne codificar

  
; mov ecx, eax
;mov ebx, [esp+4]
;xor esi, esi
;A:
;xor [in_buf+(esi)], ebx
;inc esi
;loop A
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