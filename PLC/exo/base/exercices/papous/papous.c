#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

static void afficher_papous(bool est_papa, bool a_poux)
{
    if (est_papa && a_poux)
    {
        printf("y'a des papous papa à poux\n");
    }
    else if (est_papa && !a_poux )
    {
        printf("y'a des papous papa pas à poux\n");
    }
    else if(!est_papa && a_poux)
    {
        printf("y'a des papous pas papa à poux\n");
    }
    else{
        printf("y'a des papous pas papa pas à poux\n");
    }
    
}

int main(void)
{
    printf("Chez les papous...\n");
    afficher_papous(true, true);
    afficher_papous(true, false);
    afficher_papous(false, true);
    afficher_papous(false, false);

    return EXIT_SUCCESS;
}
