CC=gcc
CFLAGS=-std=c99 -Wall -Wextra -g

all: brainfuck

brainfuck:
	$(CC) $(CFLAGS) brainfuck_main.c brainfuck_helper.c -o main


.PHONY: clean
clean:
	rm -f *~ *.o $(TARGETS)

.PHONY: test
test:
	./main ./tests/affiche6facile.bf
	./main ./tests/affiche6loop.bf
	./main ./tests/ensimag.bf
	./main ./tests/tictactoe.bf
