#include "ldc.h"
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

void ajouter_voleurs(ldc **l, int nb);
void elimination_perdants(ldc **vol,ldc **perd, int inc, bool suiv);
void elimination_tour(ldc **vol, ldc **perd, int inc, bool suiv);