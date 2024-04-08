
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include "ldc.h"


int main(void)
{
    struct ldc *test = NULL;
    uint32_t taille;
    taille = ldc_taille(test);
    printf("Taille de la liste : %u\n", taille);

    ldc_insere_fin(&test, 1);
    ldc_affiche(test);

    taille = ldc_taille(test);
    printf("Taille de la liste : %u\n", taille);

    ldc_supprime(&test, test);
    ldc_affiche(test);

    taille = ldc_taille(test);
    printf("Taille de la liste : %u\n", taille);
}

// for (uint32_t i = 0; i < 5; i++) {
//     ldc_insere_fin(&test, i);
//     ldc_affiche(test);
//     taille = ldc_taille(test);
//     printf("Taille de la liste : %u\n", taille);
// }
// for (uint32_t i = 0; i < 5; i++) {
//     ldc_supprime(&test, test);
//     ldc_affiche(test);
//     taille = ldc_taille(test);
//     printf("Taille de la liste : %u\n", taille);
// }
