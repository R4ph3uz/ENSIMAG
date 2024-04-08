CC = gcc
LD = gcc

CFLAGS = -Wall -Wextra -std=c99 -g
LDFLAGS= -lcriterion

all: alibaba test_ldc

test_ldc: ldc.o test_ldc.o
	$(CC) $^ -o $@ $(LDFLAGS)

alibaba: alibaba.o ldc.o
	$(CC) $(CFLAGS) $^ -o $@

alibaba.o : alibaba.c
	$(CC) $(CFLAGS) -c $< -o $@

ldc.o : ldc.c ldc.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f alibaba.o ldc.o test_ldc.o alibaba test_ldc


.PHONY: progress

progress:
	@../../../.progress/update $(shell basename "$(shell pwd)")
