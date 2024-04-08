#include <stdlib.h>
#include <stdio.h>

enum jour{
    lundi,
    mardi,
    mercredi,
    jeudi,
    vendredi,
    samedi,
    dimanche
};

int main(int argc, char** argv) {
    /* Affiche un message d'erreur si l'utilisateur oublie l'argument
       à passer en ligne de commandes. */
    if (argc < 2) {
        fprintf(stderr, "Usage: %s nombre\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    /* Convertit l'argument passé par l'utilisateur en entier. */
    enum jour nombre = atoi(argv[1]);
    --nombre;
    switch(nombre){
        case lundi:
        printf("Le nombre entré correspond à un jour de semaine.\n");
        break;
        case mardi:
        printf("Le nombre entré correspond à un jour de semaine.\n");
        break;
        case mercredi:
        printf("Le nombre entré correspond à un jour de semaine.\n");
        break;
        case jeudi:
        printf("Le nombre entré correspond à un jour de semaine.\n");
        break;
        case vendredi:
        printf("Le nombre entré correspond à un jour de semaine.\n");
        break;
        case samedi:
        printf("Le nombre entré correspond à un jour du week-end.\n");
        break;
        case dimanche:
        printf("Le nombre entré correspond à un jour du week-end.\n");
        break;
        default:
        printf("Le nombre entré doit être compris entre 1 et 7!\n");
    }

    return nombre;
}
