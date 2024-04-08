CC=gcc
CFLAGS=-std=c99 -Wall -Wextra -g

all: alibaba

.PHONY: clean check

check:
	make -C tests/ check

clean:
	rm -f *~ *.o alibaba

.PHONY: progress

progress:
	@../../../.progress/update $(shell basename "$(shell pwd)")
