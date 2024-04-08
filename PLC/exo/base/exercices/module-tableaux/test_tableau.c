#include <stdlib.h>

#include "tableau.h"

int main(void)
{
    // int tabaff[]={1,2,3};
    // affiche(tabaff,3);

    // int tabint[5];
    // init_interactive(tabint,5);
    // affiche(tabint,5);

    int tabrd[5];
    init_aleatoire(tabrd,5);
    affiche(tabrd,5);

    tri_insertion(tabrd,5);
    affiche(tabrd,5);

    return EXIT_SUCCESS;
}
