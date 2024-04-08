#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

int main()
{
    int entier = 1;
    uint32_t tab[4]={12,34,56,78};
    for (size_t i = 0; i < 10; i++)
    {
        printf("%u->",tab[i]);
    }
    
    return 0;
}
