#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "ldc.h"
// struct ldc {
//     uint8_t numero;
//     struct ldc* suiv;
//     struct ldc* prev;
// };


/* Implémentation du module liste doublement chaînée circulaire */
void ldc_affiche(struct ldc* l){
    struct ldc* premier = l;
    struct ldc* actuel = l;
    if (l==NULL)
    {
        fprintf(stderr,"La liste est vide\n");
    }
    else{ // si la liste n'est pas vide j'affiche le 1er
        fprintf(stderr,"%u->",actuel->numero);
        actuel=actuel->suiv;
        while(actuel != premier){ // puis tant qu'on retombe pas dessus on affiche les voleurs
            fprintf(stderr,"%u->",actuel->numero);
            actuel=actuel->suiv;
        }
        fprintf(stderr,"FIN\n");
    }
}

uint32_t ldc_taille(struct ldc* l){
    struct ldc* premier = l;
    if (l==NULL)
    {
        return 0;
    }
    else{
        struct ldc* actuel = l->suiv;
        uint32_t compteur=1;
        while(actuel != premier){ // on itère de nouveau pour savoir combien il y a de voleurs
            compteur++;
            actuel=actuel->suiv;
        }
        return compteur;
    }
}

void ldc_insere_fin(struct ldc** pl, uint32_t n){
    struct ldc *cellule=malloc(sizeof(struct ldc));
    cellule->numero=n;
    if (*pl==NULL) // si nul, on renvoie lui meme
    {
        cellule->prev=cellule;
        cellule->suiv=cellule;
        *pl=cellule;
    }
    else if ((*pl)->suiv==*pl)
    {
        cellule->prev=*pl;
        cellule->suiv=*pl;
        (*pl)->suiv=cellule;
        (*pl)->prev=cellule;
    }
    else
    {
    struct ldc *depart=*pl;
    struct ldc *fin=depart->prev;

    cellule->suiv = depart;
    cellule->prev=fin;
    fin->suiv=cellule;
    depart->prev=cellule;
    
}
}

struct ldc* ldc_recupere_nieme(struct ldc* e, uint8_t n){
    struct ldc *cell=e;
    for (size_t i = 0; i < n; i++)
    {
        cell=cell->suiv;
    }
    return cell;    
}

void ldc_supprime(struct ldc** pl, struct ldc* e){
    struct ldc *debut=*pl;
    if (ldc_taille(*pl)==1)
    {
        free(e);
        *pl=NULL;
    }
    
    else if (debut == e)
    {
        debut->prev->suiv=debut->suiv;
        debut->suiv->prev=debut->prev;
        *pl=debut->suiv;
        free(debut);
    }
    else{
    struct ldc *actuel=debut->suiv;
    while (actuel!=e)
    {
        actuel = actuel->suiv;
    }
    actuel->prev->suiv=actuel->suiv;
    actuel->suiv->prev=actuel->prev;
    free(actuel);
    }    
}
void ldc_libere(struct ldc* l){
    while (l->suiv==NULL)
    {
        ldc_supprime(&l, l->suiv);
    }
    free(l);
}
