#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>  // in-out, fonctions des entrées-sorties

/*
    Retourne l'entier naturel entré au clavier, en effectuant
    une lecture caractère par caractère.
*/
uint32_t get_natural(void)
{
    uint32_t entier = 0;
    char chiffre_lu;

    char lo = getc(stdin);
    while (lo != '\n') {
        chiffre_lu = lo - '0';
        entier = 10 * entier + chiffre_lu;
        lo = getc(stdin);
    }

    return entier;
}


int main(void)
{
    printf("Entrez un entier naturel : ");
    uint32_t entier = get_natural();

    printf("Entrez un entier signé : ");
    /*
        10 caractères ASCII suffisent pour stocker les chiffres
        d'un entier 32 bits. Le 11e caractère permet de stocker
        le caractère de fin de chaîne, '\0'.
    */
    char tampon[11];
    fgets(tampon, 11, stdin);
    int32_t signe = atoi(tampon);

    printf("Vous avez saisi %u et %i.\n", entier, signe);

    return EXIT_SUCCESS;
}