#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <assert.h>
#include "alibaba.h"





int main(void){
    struct cellule sentinelle = {-1,NULL,NULL};
    struct ldc *liste=malloc(sizeof(struct ldc));
    liste->sent = &sentinelle;
    for (uint32_t i = 1; i<42;i++){
	ldc_insere_fin(&liste,i);
    }
    const uint32_t pas =3;
    struct ldc l = *liste;
    struct cellule *cell = l.sent;
    uint32_t n = ldc_taille(liste);
    struct cellule sentinelle2 = {-1,NULL,NULL};
    struct ldc *morts = malloc(sizeof(struct ldc));
    morts->sent = &sentinelle2;
    while (n>2){
	for (uint32_t i =1;i < pas;i++){
	    cell = cell->suiv;
	    if (cell->val == -1){
		cell = cell->suiv;
	    }
	}
	if (cell->suiv->val == -1){
	    cell = cell->suiv;
	}
	ldc_insere_fin(&morts,cell->suiv->val);
	ldc_supprime_suiv(&cell);
	n = ldc_taille(liste);
    }
    ldc_affiche(morts);
    ldc_affiche(liste);
    return EXIT_SUCCESS;
}
