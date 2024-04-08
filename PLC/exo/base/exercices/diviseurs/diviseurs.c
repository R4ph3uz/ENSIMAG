#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

int main(int argc, char **argv)
{
    /* Affiche un message d'erreur si l'utilisateur oublie l'argument
       à passer en ligne de commandes. */
    if (argc < 2) {
        fprintf(stderr, "Usage: %s nombre\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    /* Convertit l'argument passé par l'utilisateur en entier non signé. */
    int32_t au_cas_ou = atoi(argv[1]);
    if (au_cas_ou < 1) {
        fprintf(stderr, " on a dit \"strictement positif\", le nombre! Pas %d...\n", au_cas_ou);
        exit(EXIT_FAILURE);
        /* Tiens et si ca tient pas sur 32 bits? A voir... */
    }
    bool changed=false;
    uint32_t nombre = (uint32_t) au_cas_ou;

    for (uint32_t i = 2; i < nombre-1; i++)
    {
        if (nombre%i==0)
        {
            changed=true;
            printf("%u est un diviseur de %u\n",i,nombre);
        }
        
    }
    if (!changed){
        printf("%u est un nombre premier\n",nombre);
    }
    

    return EXIT_SUCCESS;
}
