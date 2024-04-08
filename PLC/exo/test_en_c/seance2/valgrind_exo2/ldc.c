#include "ldc.h"

/**
 * Fonction d'insertion en fin d'une liste chaînée.
 */
void ldc_insere_fin(ldc **l, int num) {
    // Cas d'une liste vide
    if(*l == NULL) {
        (*l) = malloc(sizeof(ldc));
        (*l)->num = num;
        (*l)->pred = *l;
        (*l)->suiv = *l;
        return;
    }

    // Création nouvelle queue
    ldc *c = malloc(sizeof(ldc));
    c->num = num;
    c->pred = (*l)->pred;
    c->suiv = (*l);

    // Création de la nouvelle queue
    if((*l)->pred != *l) {
        (*l)->pred->suiv = c;
    } else {
        (*l)->suiv = c;
    }
    (*l)->pred = c;
}


/**
 * Fonction d'affichage des valeurs des éléments d'une liste chaînée.
 */
void ldc_affiche(ldc *l) {
    // Cas d'une liste vide
    if(l == NULL) {
        printf("Liste vide, pas de valeur.\n");
        return;
    }

    // Cas général, affichage
    ldc *c = l;
    do {
        printf("Numéro : %i\n", c->num);
        c = c->suiv;
    } while(c != l);
}


/**
 * Fonction qui renvoie la taille d'une liste chaînée.
 */
int ldc_taille(ldc *l) {
    
    // Cas d'une liste vide
    int taille = 0;
    if(l == NULL) {
        return taille;
    }

    // Cas général, calcul de la taille 
    ldc *c = l;
    do {
        taille++;
        c = c->suiv;
    }while (c != l);
    return taille;
}

/**
 * Fonction qui supprime un élément dans la liste si celui-ci
 * est à l'intérieur.
 */
void ldc_supprime(ldc **pl,ldc *e) {
    // Cas d'une liste vide
    if(*pl == NULL) {
        return;
    }

    // Cas général, suppression
    ldc *c = *pl;
    while(c != e) {
        c = c->suiv;
        // Parcours de tous le éléments
        if(c == (*pl)->pred && c != e) {
            return;
        }
    }

    // Cas plus qu'un seul élément
    if(c->pred->suiv == c->suiv) {
        free(c);
        *pl = NULL;
        return;
    }

    // Suppression général
    c->pred->suiv = c->suiv;
    c->suiv->pred = c->pred;
    free(c);

}



/** 
 * Fonction qui libère l'intégralité de la mémoire d'une liste chaînée.
 */
void ldc_libere(ldc **pl) {
    // Cas d'une liste vide
    if(*pl == NULL) {
        return;
    }

    // Cas général, vider la liste
    ldc *c = (*pl)->suiv;
    ldc *tmp = NULL;
    while(c != *pl) {
        tmp = c->suiv;
        free(c);
        c = tmp;
    }
    free(*pl);
    *pl = NULL;
}

/**
 * Fonction principale contenant les tests.
 */
void test(void) {
    ldc *liste = NULL;

    printf("---- INSERTION & TAILLE ----\n");
    // Tests insertions & taille
    for(int i=0; i<10;i++) {
        ldc_insere_fin(&liste, i);
        printf("Taille : %i\n",ldc_taille(liste));
    }
    // Test affichage
    printf("---- AFFICHAGE ----\n");
    ldc_affiche(liste);


    ldc *c = liste->suiv->suiv;
    // Tests suppression
    printf("---- SUPPRESION ----\n");
    ldc_supprime(&liste, c);
    ldc_affiche(liste);

    ldc_libere(&liste);
    ldc_affiche(liste);

}