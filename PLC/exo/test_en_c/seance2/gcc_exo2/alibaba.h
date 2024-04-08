#ifndef _ALIBABA_H_
#define _ALIBABA_H_
#include <stdint.h>

struct cellule
{
    uint32_t val;
    struct cellule *prec;
    struct cellule *suiv;
};

struct ldc
{
    struct cellule *sent;
};

extern void ldc_insere_fin(struct ldc **pl, uint32_t n);

extern void ldc_affiche(struct ldc *l);

extern uint32_t ldc_taille(struct ldc *l);

extern void ldc_supprime_suiv(struct cellule **cell);

#endif /* _ALIBABA_H_ */
