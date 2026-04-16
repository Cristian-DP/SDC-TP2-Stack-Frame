compile: clean routines.o middleware.o
	gcc -shared -o libreria.so middleware.o routines.o
	rm -f *.o

routines.o:
	nasm -f elf64 -g -o routines.o routines.asm

middleware.o:
	gcc -c -Wall -Werror -fPIC -g -o middleware.o middleware.c

clean:
	rm -f *.o *.so
