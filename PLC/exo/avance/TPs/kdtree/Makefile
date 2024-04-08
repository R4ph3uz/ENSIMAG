CC = gcc
CFLAGS = -g -std=c99 -Wall -Wextra -Iinclude
# Option pour supprimer les warnings du type "unused variable..."
# A supprimer quand vous aurez complété le squelette de code !
CFLAGS+=-Wno-unused-variable

# Bibliothèques à lier avec l'exécutable du projet (lm => lib maths, lz => lib gzip)
LDFLAGS = -g -lm -lz

# Fichiers objet prof, à remplacer par vos propres fichiers objet quand vous 
# aurez implémenté les modules correspondants
OBJ_PROF =  obj_profs/array.o obj_profs/image.o obj_profs/kdtree.o obj_profs/NN.o

# Liste des fichiers objet à compléter avec vos propres modules
OBJ_FILES = obj/recognize.o

EXEC = bin/recognize

all: $(EXEC)

bin/recognize: $(OBJ_FILES) $(OBJ_PROF)
	$(CC) $^ -o $@ $(LDFLAGS)

obj/%.o: src/%.c
	$(CC) $(CFLAGS) -c $^ -o $@

clean:
	rm -f $(OBJ_FILES) $(EXEC)

.PHONY: clean

.PHONY: progress

progress:
	@../../../.progress/update $(shell basename "$(shell pwd)")
