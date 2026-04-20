compile: clean middleware.o
	gcc -shared -fPIC -o libreria.so middleware.o
	rm -f *.o
middleware.o:
	gcc -c -Wall -Werror -pedantic middleware.c -o middleware.o
clean:
	rm -f *.o *.so

	
