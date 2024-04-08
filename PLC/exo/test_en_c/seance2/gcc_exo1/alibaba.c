#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

struct ldc
{
    int numero;
    struct ldc *suiv;
    struct ldc *prec;
};



static void ldc_affiche(struct ldc *l)
{
    if (l != NULL){
        int premier = l->numero; 
        printf("%i - ", l->numero);
        l = l->suiv;

        while (l->numero != premier){
            printf("%i - ", l->numero);
            l = l->suiv;
        }
        printf("\n");        
    }

}

static void ldc_insere_fin(struct ldc **pl, uint32_t n)
{
    struct ldc *ajout = malloc(sizeof(struct ldc));
    ajout->numero = n;

    if (*pl != NULL){
        (*pl)->prec->suiv = ajout;
        ajout->prec = (*pl)->prec->suiv;    
        (*pl)->prec = ajout;
        ajout->suiv = *pl;     
    }
    else{
        *pl = ajout;
        ajout->suiv = ajout; 
        ajout->prec = ajout;
    }
}

static int ldc_taille(struct ldc *l)
{
    int taille = 0;
    if (l == NULL) return taille;
    else {
        int premier = l->numero; 
        l = l->suiv;
        taille++;

        while (l->numero != premier){
            l = l->suiv;
            taille++;
        }
        return taille;
    }
}

static void ldc_supprime(struct ldc **pl, struct ldc *e)
{
    // struct ldc *premier = *pl;
    if (ldc_taille(*pl) == 1){
        *pl = NULL;
    }
    else {
        while (*pl != e) {
            printf("Courant : %i\n", (*pl)->numero);
            (*pl) = (*pl)->suiv; 
        }  
        printf("Courant : %i\n", (*pl)->numero);
        printf("Actuel : %i et Précédent : %i et Suivant : %i\n", (*pl)->numero, (*pl)->prec->numero, (*pl)->suiv->numero);
        (*pl)->prec->suiv = (*pl)->suiv;
        (*pl)->suiv->prec = (*pl)->prec;
    }
}


int main(void)
{
    struct ldc *liste = NULL;  //  Définition d'un pointeur, ici le type de l'objet pointé est "struct cellule".
    for (uint32_t i = 6; i < 10; i++) {
        ldc_insere_fin(&liste, i);
        ldc_affiche(liste);
    }
    printf("Taille actuelle : %i\n", ldc_taille(liste));
    for (uint32_t i = 5; i > 0; i--) {
        ldc_insere_fin(&liste, i);
        ldc_affiche(liste);
    }
    printf("Taille actuelle : %i\n", ldc_taille(liste));

    ldc_supprime(&liste, liste->suiv->suiv);
    ldc_affiche(liste);
    return 0;
}
