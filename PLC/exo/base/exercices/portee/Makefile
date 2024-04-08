CC=gcc
CFLAGS=-std=c99 -Wall -Wextra -g
LDFLAGS=-lm

all: portee

portee: portee.o point.o
	$(CC) -o portee portee.o point.o $(LDFLAGS)

.PHONY: clean
clean:
	rm -f *~ *.o portee

.PHONY: progress

progress:
	@../../../.progress/update $(shell basename "$(shell pwd)")
