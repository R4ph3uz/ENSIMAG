#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

static bool est_palindrome(const char *mot)
{
    int taille= strlen(mot);
    bool pal=true;
    for (int i = 0; i < taille/2; i++)
    {
        if (mot[i]!=mot[taille-i-1])
        {
            pal=false;
        }
    }
    return pal;
}

/*
    Ce prototype de fonction main permet de récupérer les arguments
    passés au programme sur la ligne de commande (ici, le mot sur
    lequel travailler).
*/
int main(int argc, char *argv[])
{
    if (argc != 2) {
        fprintf(stderr, "Usage: %s mot\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    if (est_palindrome(argv[1])) {
        printf("%s est bien un palindrome!\n", argv[1]);
    } else {
        printf("%s n'est pas un palindrome...\n", argv[1]);
    }

    return EXIT_SUCCESS;
}
