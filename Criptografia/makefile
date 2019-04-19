all: app

app: encriptar.o main.o decriptar.o
	@gcc -m32 -o main main.o encriptar.o decriptar.o 
main.o: encriptar.o
	@gcc -m32 -c main.c
encriptar.o:
	@nasm -f elf32 encriptar.asm

decriptar.o:
	@nasm -f elf32 decriptar.asm
clean:
	@rm *.o main
