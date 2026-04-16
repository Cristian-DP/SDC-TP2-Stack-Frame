all:
	nasm	-f	elf64	-g	-o	routines.o	routines.asm
	gcc	-g	-O0	-c	-o	main.o	main.c
	gcc	-o	programa	main.o	routines.o

clean:
	rm	-f	*.o	programa
