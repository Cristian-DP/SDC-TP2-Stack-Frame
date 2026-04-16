compile: clean floatToIntPlusOne.o middleware.o
	gcc -shared -o libreria.so middleware.o floatToIntPlusOne.o
	rm -f *.o

floatToIntPlusOne.o:
	as --64 -g -o floatToIntPlusOne.o floatToIntPlusOne.s

middleware.o:
	gcc -c -Wall -Werror -fPIC -g -o middleware.o middleware.c

clean:
	rm -f *.o *.so