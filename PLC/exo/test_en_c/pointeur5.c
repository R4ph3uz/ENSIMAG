#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

/* On définit le type "struct rationnel" contenant deux champs :
 * un numérateur et un dénominateur. */
struct rationnel {
    uint32_t numerateur;
    uint32_t denominateur;
};

int main(void)
{
    /* Initialisation contractée : les champs apparaissent dans
        * l'ordre dans lequel ils ont été placés dans la définition
        * du type struct rationnel. */
    struct rationnel un_demi = { 1, 2 };

    /* Copie de structure: copie bit à bit de tous les champs. */
    struct rationnel pression = un_demi;

    /* Accès aux champs via l'opérateur '.' */
    struct rationnel deux_tiers;
    deux_tiers.numerateur = 2;
    deux_tiers.denominateur = 3;

    /* Initialisation contractée en faisant explicitement
        * référence au nom du champ qu'on initialise. */
    struct rationnel un_quart = { .denominateur = 4,
                                    .numerateur = 1 };

    /* Définition d'un pointeur, ici le type de l'objet pointé
        * est bien "struct rationnel". */
    struct rationnel *bar = &pression;

    /* On peut accéder aux champs d'une structure à partir d'un
        * pointeur à l'aide de la notation contractée "->".
        * On préférera TOUJOURS cette notation à la notation
        * "(*bar).numerateur".  */
    printf("%u/%u\n", bar->numerateur, pression.denominateur);
    /* Pour afficher la même chose */
    printf("%u/%u\n", pression.numerateur, bar->denominateur);

    return EXIT_SUCCESS;
}