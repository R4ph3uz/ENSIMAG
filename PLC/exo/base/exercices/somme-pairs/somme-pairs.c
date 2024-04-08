#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

int main(void)
{
    uint16_t tab[] = {0,2,4,6,8,10,12,14,16,18};
    uint16_t somme=0;
    uint8_t taille=10;
    for (size_t i = 0; i < taille; i++)
    {
        somme+=tab[i];
    }
    printf("%d",somme);
    return EXIT_SUCCESS;
}
