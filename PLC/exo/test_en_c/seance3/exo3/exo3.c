#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include "annexe3.h"

int main()
{
    const char *message="salut";
    affiche_message(&message);
    return 0;
}

// exo.c: In function ‘main’:
// exo.c:7:48: warning: passing argument 1 of ‘strlen’ from incompatible pointer type [-Wincompatible-pointer-types]
//     7 |     printf("Taille de message = %ld\n", strlen(param));
//     |                                                ^~~~~
//     |                                                |
//     |                                                char **
// In file included from exo.c:2:
// /usr/include/string.h:407:35: note: expected ‘const char *’ but argument is of type ‘char **’
// 407 | extern size_t strlen (const char *__s)