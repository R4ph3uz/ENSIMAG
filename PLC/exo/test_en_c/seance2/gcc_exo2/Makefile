CC=gcc
CFLAGS=-std=c99 -Wall -Wextra -g

all: resol

resol: resol.o  alibaba.o

alibaba.o: alibaba.c alibaba.h

.PHONY: clean
clean:
	rm -f *~ *.o resol

.PHONY: progress

progress:
	@../../../.progress/update $(shell basename "$(shell pwd)")
