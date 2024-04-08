#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "annexe3.h"

void affiche_message(const char **param){
    printf("Taille de message = %ld\n", strlen(param));
}