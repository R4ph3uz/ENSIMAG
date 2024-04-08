#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

typedef struct ldc ldc;
struct ldc {
    int num;
    struct ldc *suiv;
    struct ldc *pred;
};

void ldc_insere_fin(ldc **l, int num); 
void ldc_affiche(ldc *l);
int ldc_taille(ldc *l);
void ldc_supprime(ldc **pl,ldc *e);
void ldc_libere(ldc **pl);