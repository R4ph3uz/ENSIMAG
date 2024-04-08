#include <inttypes.h>
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "ldc.h"


int main(void) {
    struct ldc *voleurs;
    voleurs=NULL;

    for (uint32_t i = 0; i < 41; i++)
    {
        ldc_insere_fin(&voleurs,i+1);
    } // tablau des voleurs créés

    struct ldc *assomes;
    assomes=NULL;
    //pas d'assome encore
    struct ldc* voleur_assome=voleurs;
    voleur_assome=ldc_recupere_nieme(voleur_assome,2);
    ldc_insere_fin(&assomes,voleur_assome->numero);
    struct ldc* temp_voleur=voleur_assome;
    for (size_t i = 0; i < 38; i++)
    {
        voleur_assome=ldc_recupere_nieme(voleur_assome,3);
        ldc_supprime(&voleurs,temp_voleur);
        temp_voleur=voleur_assome;
        ldc_insere_fin(&assomes,voleur_assome->numero);
    }
    ldc_supprime(&voleurs,voleur_assome);
    printf("les gens mourront dans cet ordre\n");
    ldc_affiche(assomes);
    printf("Et il restera\n");
    ldc_affiche(voleurs);
    
    
    ldc_libere(voleurs);
    return EXIT_SUCCESS;
}


