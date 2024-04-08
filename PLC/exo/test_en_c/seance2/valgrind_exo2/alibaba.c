#include "alibaba.h"

/**
 * Ajout dans la liste de tous les valeurs
 */
void ajouter_voleurs(ldc **l, int nb) {
    for(int i = 0; i < nb; i++) {
        ldc_insere_fin(l,i+1);
    }
}

/**
 *  Propose une méthode d'élimination des perdants selon un facteur
 *  et selon un certain sens.
 */
void elimination_perdants(ldc **vol, ldc **perd, int inc, bool suiv) {
    int taille = ldc_taille(*vol);
    while(taille > 2) {
        elimination_tour(vol, perd, inc, suiv);
        taille--;
    }
}

/**
 *  Fonction qui élimine un perdant durant un tour.
 */ 
void elimination_tour(ldc **vol, ldc **perd, int inc, bool suiv) {
    int i = 1;
    ldc *c = *vol;
    while(i < inc) {
        c = suiv ? c->suiv : c->pred;
        i++;
    }
    ldc_insere_fin(perd, c->num);
    *vol = suiv ? c->suiv : c->pred;
    ldc_supprime(vol, c);
}

int main(void) {
    ldc *voleurs = NULL, *perdants = NULL;
    ajouter_voleurs(&voleurs, 41);
    printf("---- Voleurs ----\n");
    ldc_affiche(voleurs);
    elimination_perdants(&voleurs, &perdants, 3, true);
    printf("---- Perdants ----\n");
    ldc_affiche(perdants);
    printf("---- Gagnants ----\n");
    ldc_affiche(voleurs);

    ldc_libere(&voleurs);
    ldc_libere(&perdants);
}