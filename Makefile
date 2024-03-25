all: test test-nostdlib

test: test.c tinyalloc.c tinyalloc.h
	gcc -Wall -g -m32 --coverage -c test.c tinyalloc.c -DTA_USE_STDLIB
	gcc -Wall -g -m32 --coverage -o test test.o tinyalloc.o

test-nostdlib: test.c tinyalloc.c tinyalloc.h
	gcc -Wall -g -m32 -o test-nostdlib test.c tinyalloc.c

cov: test
	./test
	gcov tinyalloc.c

run-all: cov test-nostdlib
	./test-nostdlib

clean:
	rm -f test test-nostdlib *.o *.gcda *.gcno *.gcov
