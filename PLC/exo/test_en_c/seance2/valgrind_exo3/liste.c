#include "liste.h"

#include <stdlib.h>

void liste_inserer_queue(Liste *liste, int valeur) {

  Cellule *queue = (Cellule *)malloc(sizeof(Cellule));
  queue->precedent = liste->queue;
  queue->valeur = valeur;
  queue->suivant = NULL;

  if (liste->tete == NULL) {
    liste->tete = queue;
  }

  if (liste->queue) {
    liste->queue->suivant = queue;
  }

  liste->queue = queue;
  ++liste->taille;
}

void liste_supprimer_premiere_occurence(Liste *liste, int valeur) {
  Cellule *courant = liste->tete;

  while (courant) {
    if (courant->valeur == valeur) {
      if (courant->precedent) {
        courant->precedent->suivant = courant->suivant;
      }
      if (courant->suivant) {
        courant->suivant->precedent = courant->precedent;
      }
      free(courant);
      --liste->taille;
      return;
    }
    courant = courant->suivant;
  }
}
