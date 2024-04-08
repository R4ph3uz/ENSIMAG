CC=gcc
CFLAGS=-std=c99 -Wall -Wextra -g
LDFLAGS=
EXEC=alibaba
SRC=alibaba.c ldc.c
OBJ= $(SRC:.c=.o)

all: $(EXEC)

alibaba: $(OBJ)
	$(CC) -o $@ $^ $(LDFLAGS)

alibaba.o: ldc.h

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

.PHONY: clean

clean:
	rm -f *~ *.o


