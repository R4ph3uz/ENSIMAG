#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>


void echange_vrai(uint32_t *a, uint32_t *b){
    int t=*a;
    *a=*b;
    *b=t;
}


int main(void)
{
    uint32_t x = 17;
    uint32_t y = 42;
    printf("Avant : x=%u, y=%u\n", x, y);
    echange_vrai(&x, &y);
    printf("Après : x=%u, y=%u\n", x, y);

    return EXIT_SUCCESS;
}