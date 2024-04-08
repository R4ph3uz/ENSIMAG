#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <assert.h>

/*
    A insérer ici les implémentations des fonctions :
    - void incremente(...) qui doit incrémenter la valeur d'un entier
      récupéré par l'intermédiaire d'un paramètre ;
    - void met_a_zero(..., size_t len) qui doit mettre les len cases
      du tableau récupéré par l'intermédiaire d'un paramètre à 0 ;
    - void met_a_null(...) qui passe le pointeur récupéré par l'intermédiaire
      d'un paramètre à la valeur NULL.

    Les ... dans les prototypes détaillés ci-dessus sont à remplacer par ce qui
    vous semble adéquat.
*/
void met_a_null(char **string){
  *string=NULL;
}

void incremente(int8_t *valeur){
  *valeur=*valeur+1;
}

void met_a_zero(int8_t *number, int len){
  for (size_t i = 0; i < len; i++)
  {
    number[i]=0;
  }
}


int main(void)
{
    char* coucou = "hello !";
    // TODO : insérer ici un appel à la fonction met_a_null pour mettre coucou à NULL
    met_a_null(&coucou);
    assert(coucou == NULL);

    int8_t toto = 0;
    // TODO : insérez ici un appel à la fonction incremente pour modifier la valeur de toto
    incremente(&toto);
    assert(toto == 1);

    int8_t pouet[] = { 1, 2, 3 };
    // TODO : insérer ici un appel à la fonction met_a_zero pour mettre toutes les cases de pouet à 0
    met_a_zero(&pouet,3);
    assert(pouet[0] == 0 && pouet[1] == 0 && pouet[2] == 0);


    printf("Bravo, si vous arrivez jusqu'ici, c'est que tout fonctionne bien !\n");

    return EXIT_SUCCESS;
}
