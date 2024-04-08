CC ?= clang
CFLAGS ?= -O3

all: alibaba

alibaba: main.c liste.c
	$(CC) -o alibaba $(CFLAGS) $^

clean:
	rm -rf alibaba
