#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    char c;
    do
    {
        printf("Entrez une majuscule :");
        c = getchar( );
        char character;
        do
        {
            character=getchar();
        } while (character!='\n');
        
    } while (!isupper(c));
    printf("Vous avez entré la majuscule %c\n",c);
    
    return EXIT_SUCCESS;
}
