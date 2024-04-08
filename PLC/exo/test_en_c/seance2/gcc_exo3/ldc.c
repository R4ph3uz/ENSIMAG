#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <assert.h>
#include "ldc.h"

void ldc_insere_fin(struct ldc **pl, uint32_t n)
{
    struct ldc *fin = malloc(sizeof(struct ldc));
    fin->val = n;
    struct ldc *courant = *pl;

    if (courant == NULL) {
        fin->suiv = fin;
        fin->prec = fin;
        *pl = fin;
    } else {
        struct ldc *precedent = courant->prec;
        precedent->suiv = fin;
        courant->prec = fin;
        fin->suiv = courant;
        fin->prec = precedent;
    }
}


void ldc_affiche(struct ldc *l)
{
    printf("[");
    struct ldc *courant = l;

    if (courant == NULL) {
        printf("]\n");
    } else {
            while (courant->suiv != l) {
                printf("%u, ", courant->val);
                courant = courant->suiv;
        }
        printf("%u]\n", courant->val);
    }
}

uint32_t ldc_taille(struct ldc *l)
{
    uint32_t taille = 0;
    struct ldc *courant = l;

    if (l == NULL) {
        return taille;
    } else {
        while (courant->suiv != l) {
            taille++;
            courant = courant->suiv;
        }
    return taille + 1;
    }
}

// supprime l'element e de la liste pointee par pl.
// precondition: *pl non vide, e non null, e dans *pl
extern void ldc_supprime(struct ldc **pl, struct ldc *e)
{
  assert(*pl != NULL && e != NULL);
  // necessite aussi e dans pl
  struct ldc *courant = *pl;
  uint32_t taille = ldc_taille(*pl);

  if (taille == 1) {
      *pl = NULL;
  } else {
      while (courant->suiv != *pl) {
        if (courant == e) {
          struct ldc *suivant = courant->suiv;
          courant->prec->suiv = suivant;
          suivant->prec = courant->prec;
          if (courant == *pl) {
            *pl = suivant;
            return;
          }
          return;
      }
    }
  }
}
