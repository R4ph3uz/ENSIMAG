#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

int main()
{
    uint32_t *tableau=malloc(4*sizeof(uint32_t));
    tableau[0]=12;
    tableau[1]=34;
    tableau[2]=56;
    tableau[3]=78;

    free(tableau);
    return EXIT_SUCCESS;
}