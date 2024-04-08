#include<stdint.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<sys/time.h>

uint32_t calcul_somme(uint32_t entiers[], uint32_t taille)
{
    uint32_t total = 0;
    for(uint32_t i = 0 ; i < taille ; i++) {
        total += entiers[i];
    }
    return total;
}

uint32_t calcul_nombre_partitions(uint32_t entiers[], uint32_t taille)
{
    int32_t somme=calcul_somme(entiers,taille);
    if (somme%2==1)
    {
        return 0;
    }
    uint32_t cible = somme / 2;
    uint32_t nombre_partitions = 0;

    for (uint32_t comb = 0; comb < 1<<taille; comb++)
    {
        uint32_t summm =0;
        uint32_t bits=comb;
        for (uint32_t j = 0; j < taille; j++)
        {
            uint8_t bit = bits%2;
            summm+=bit*entiers[j];
            bits>>=1;
        }
        if (summm==cible){
            nombre_partitions++;
        }
    }
    return nombre_partitions;
}

int main(int argc, char **argv) {
    uint32_t entiers[25] = {
        285762, 1287946, 260518, 702569, 183183, 1180, 909976, 1261857, 1665545, 1888537,
        1741007, 200924, 1659988, 359942, 1009604, 909891, 1261628, 317651, 822956, 843816,
        689772, 1894228, 648054, 198750, 1409020
    };
    uint32_t nombre_partitions = calcul_nombre_partitions(entiers, 25);
    printf("nombre de partitions: %d\n", nombre_partitions);
}

