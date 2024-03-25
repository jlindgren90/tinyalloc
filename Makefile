all: malloc_test stress_test test test-nostdlib

malloc_test: malloc_test.cpp tinyalloc.c tinyalloc.h
	g++ -Wall -g -o malloc_test malloc_test.cpp tinyalloc.c \
	  -DTA_USE_STDLIB -Wno-alloc-size-larger-than

stress_test: stress_test.c tinyalloc.c tinyalloc.h
	gcc -Wall -g -o stress_test stress_test.c tinyalloc.c -DTA_USE_STDLIB

test: test.c tinyalloc.c tinyalloc.h
	gcc -Wall -g -m32 --coverage -c test.c tinyalloc.c -DTA_USE_STDLIB
	gcc -Wall -g -m32 --coverage -o test test.o tinyalloc.o

test-nostdlib: test.c tinyalloc.c tinyalloc.h
	gcc -Wall -g -m32 -o test-nostdlib test.c tinyalloc.c

cov: test
	./test
	gcov tinyalloc.c

run-all: cov malloc_test stress_test test-nostdlib
	./malloc_test
	./stress_test -mem 1048576 -max 32768 -free 50
	./test-nostdlib

clean:
	rm -f malloc_test stress_test test test-nostdlib *.o *.gcda *.gcno *.gcov
