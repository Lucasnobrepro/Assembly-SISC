
section .bss

value resd 1000000

section .text

global soma

soma:

mov eax, 0
mov edx, [esp+4]
mov ebx, [esp+8]
mov esi, 0
mov ecx, 1000000

L1:
	
	add eax, [edx+esi]
	add eax, [ebx+esi]
	mov [value+esi], eax
	add esi,4
	mov eax, 0

loop L1

mov eax, value

ret
