CC=gcc
CFLAGS=-std=c99 -Wall -Wextra -g

all: test_ldc

test_ldc: test_ldc.o ldc.o

ldc.o: ldc.c ldc.h

.PHONY: clean
clean:
	rm -f *~ *.o test_ldc

.PHONY: progress

progress:
	@../../../.progress/update $(shell basename "$(shell pwd)")
