#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

#include "tableau.h"

void affiche(int32_t tab[], uint32_t taille)
{
    for (size_t i = 0; i < taille; i++)
    {
        printf("element du tableau %li : %d\n",i, tab[i]);
    }
    
}

void init_interactive(int32_t tab[], uint32_t taille)
{
    for (size_t i = 0; i < taille; i++)
    {
        char tampon[10];
        int number=0;
        printf("quel nombre voulez vous entrer :");
        number=atoi(fgets(tampon, sizeof(tampon), stdin));
        tab[i]=number;
    } 
}

void init_aleatoire(int32_t tab[], uint32_t taille)
{
    for (size_t i = 0; i < taille; i++)
    {
        tab[i]= rand()%10001;
    }
    
}

void tri_insertion(int32_t tab[], uint32_t taille)
{
    for (size_t i = 0; i < taille; i++)
    {
        int x= tab[i];
        int j= i;
        while (j>0 && tab[j-1]>x)
        {
            tab[j]=tab[j-1];
            j--;
        }
        tab[j]=x;      
    }
}
