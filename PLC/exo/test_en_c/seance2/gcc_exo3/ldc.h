#ifndef _TABLEAU_H_
#define _TABLEAU_H_

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

struct ldc {
    uint32_t val;
    struct ldc *suiv;
    struct ldc *prec;
};

// insere la valeur n en fin de la liste pointee par pl
extern void ldc_insere_fin(struct ldc **pl, uint32_t n);

// affiche le contenu de la liste l
extern void ldc_affiche(struct ldc *l);
//
// // retourne le nombre d'elements contenus dans l
extern uint32_t ldc_taille(struct ldc *l);
//
// // supprime l'element e de la liste pointee par pl.
// // precondition: *pl non vide, e non null, e dans *pl
extern void ldc_supprime(struct ldc **pl, struct ldc *e);
//
// // vide la liste pointee par pl, et libere la memoire.
// // En sortie, *pl == NULL
// extern void ldc_libere(struct ldc **pl);
//

#endif
