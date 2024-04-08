#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

int mesure_longueur(char *s){
    int compteur=0;
    while (s[compteur]!='\0')
    {
        compteur++;
    }
    return compteur;
}

int main()
{
    char* s1 = "";
    char* s2 = "Bonjour l'Ensimag";
    printf("s1 :%i\n",mesure_longueur(s1));
    printf("s2 :%i\n",mesure_longueur(s2));
    printf("s1 :%s\n",s2);
    return 0;
}
