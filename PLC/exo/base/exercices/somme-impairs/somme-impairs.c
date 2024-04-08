#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

void init_tab(uint32_t tab[], size_t length){
    for (size_t i = 0; i < length; i++)
    {
        tab[i]=2*i+1;
    }    
}

uint32_t somme_tab(uint32_t tab[], size_t length){
    uint32_t somme=0;
    for (size_t i = 0; i < length; i++)
    {
        somme+=tab[i];
    }
    return somme;
}

int main(void)
{
    uint32_t sum;
    uint32_t tableau[5000];
    init_tab(tableau,5000);
    sum= somme_tab(tableau,5000);
    printf("%lu\n",sum);
    return sum;
}
