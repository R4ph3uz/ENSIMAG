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

void copie(char* source, char* dest){
    int compteur=0;
    while (source[compteur]!='\0')
    {
        dest[compteur]=source[compteur];
        compteur++;
    }
}

int main()
{
    char* s1 = "";
    char* s2 = "Bonjour l'Ensimag";
    char* s3=malloc(sizeof(char)*20);
    char* s4=malloc(sizeof(char)*20);
    copie(s1,s3);
    copie(s2,s4);
    printf("s3 :%s\n",s3);
    printf("s4 :%s\n",s4);
    free(s3);
    free(s4);
    return 0;
}
