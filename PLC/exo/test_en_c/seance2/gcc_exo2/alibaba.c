#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>
#include "alibaba.h"

// struct cellule
// {
//     uint32_t val;
//     struct cellule *prec;
//     struct cellule *suiv;
// };

// struct ldc
// {
//     struct cellule *sent;
// };

void ldc_affiche(struct ldc *l){
    struct cellule *senti = l->sent;
    struct cellule *queue = senti->suiv;
    while (queue->val != senti->val){
	printf("%i ->",queue->val);
	queue = queue->suiv;
    }
    printf("\n");
}
  

void ldc_insere_fin(struct ldc **pl, uint32_t n){
    struct ldc *l = *pl;
    struct cellule *senti = l->sent;
    struct cellule *ajout = malloc(sizeof(struct cellule));
    ajout->suiv = senti;
    ajout->val = n;
    if (senti->suiv !=NULL){
	senti->prec->suiv = ajout;
	senti->prec = ajout;
 
    }
    else{
	senti->suiv = ajout;
	senti->prec = ajout;
    }
    struct ldc *new_liste = malloc(sizeof(struct cellule));
    new_liste->sent = senti;
    *pl = new_liste;
}

uint32_t ldc_taille(struct ldc *l){
    struct cellule *senti = l->sent;
    struct cellule *queue = senti->suiv;
    uint32_t compt = 0;
    while (queue->val != senti->val){
	compt += 1;
	queue = queue->suiv;
    }
    return compt;
}

void ldc_supprime_suiv(struct cellule **cell){
    struct cellule *c=*cell;
    struct cellule *inter = c->suiv;
    c->suiv = inter->suiv;
    inter ->suiv->prec = c;
}

