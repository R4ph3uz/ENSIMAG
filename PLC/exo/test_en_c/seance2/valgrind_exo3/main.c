#define NUM_JOUEURS 41

#include <stdio.h>
#include <stdlib.h>

#include "liste.h"

/**
 * On mélange les numéros des joueurs en utilisant
 * l'algorithme de Knuth-Fisher-Yates
 */
static void init_joueurs(Liste *joueurs) {
  int numeros[NUM_JOUEURS] = {0};
  for (int i = 1; i < NUM_JOUEURS; ++i) {
    numeros[i] = i;
  }
  // TODO: Quelle boucle offre les meilleures performances (cache vs
  // soustraction) ?
  /*for (int i = 1; i < NUM_JOUEURS; ++i) {
    int j = i + rand() % (NUM_JOUEURS - i);
    int tmp = numeros[i];
    numeros[i] = numeros[j];
    numeros[j] = tmp;
    liste_inserer_queue(joueurs, numeros[i]);
  }*/
  for (int i = NUM_JOUEURS; i > 0; --i) {
    int j = rand() % i;
    int tmp = numeros[i];
    numeros[i] = numeros[j];
    numeros[j] = tmp;
    liste_inserer_queue(joueurs, numeros[i]);
  }
}

int main(void) {
  Liste joueurs = {0};
  init_joueurs(&joueurs);

  while (joueurs.taille > 2) {
    int perdant = joueurs.tete->suivant->suivant->valeur;
    printf("%d a perdu\n", perdant);
    liste_supprimer_premiere_occurence(&joueurs, perdant);
  }
  printf("Les deux gagnants sont %d et %d.\n", joueurs.tete->valeur,
         joueurs.tete->suivant->valeur);

  return 0;
}
