#include <stdlib.h>
#include <stdio.h>

int main(void)
{
    int *panul; // valeur indéterminée ! beurk...

    /*
        Consignes :
        1. Déclarez un pointeur sur panul ;
        2. Utilisez ce pointeur pour passer la valeur de panul à NULL.
    */
    // TODO : à compléter !
    panul=NULL;

    if (panul == NULL) {
        printf("J'ai jamais été aussi content d'être nul !\n");
    }

    return EXIT_SUCCESS;
}