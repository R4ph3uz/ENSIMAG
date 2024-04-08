#pragma once

typedef struct Liste {
  int taille;
  struct Cellule *tete;
  struct Cellule *queue;
} Liste;

typedef struct Cellule {
  struct Cellule *precedent;
  int valeur;
  struct Cellule *suivant;
} Cellule;

void liste_inserer_queue(Liste *liste, int valeur);

void liste_supprimer_premiere_occurence(Liste *liste, int valeur);
