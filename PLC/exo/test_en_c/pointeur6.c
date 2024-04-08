#include <stdlib.h>
#include <stdint.h>

uint32_t somme(uint32_t a, uint32_t b)
{
    // la **valeur** des paramètres x et y
    // de la fonction main est capturée (copiée)
    // dans le contexte d'exécution de l'appel
    // "somme(x=1, y=2)" sous la forme de deux
    // variables locales a et b.
    return a + b;
}

int main()
{
    // quelques variables sur la pile
    uint32_t x = 1;
    uint32_t y = 2;
    uint32_t res = 0;

    // appel à calloc => allocation dans le tas
    float* tableau = calloc(10, sizeof(float));

    // appel de fonction => empilement d'un nouveau
    // contexte d'exécution pour "somme(x=1, y=2)"
    res = somme(x, y);
    printf("%i",res);

    // libération du bloc mémoire qui nous a été
    // attribué en ligne 22.
    free(tableau);

    return EXIT_SUCCESS;
}
