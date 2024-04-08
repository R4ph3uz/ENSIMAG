CC=gcc
CFLAGS=-std=c99 -Wall -Wextra -g

all: alibaba

.PHONY: clean
clean:
	rm -f *~ *.o alibaba
	rm -rf *.dSYM # mac-erie

.PHONY: progress

progress:
	@../../../.progress/update $(shell basename "$(shell pwd)")
