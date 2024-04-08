#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>

/**
 * @brief Structure de données décrivant un élément d'une liste.
 *
 */
struct cellule
{
    uint32_t val;           /**< La valeur d'une cellule est un entier */
    struct cellule* suiv;   /**< Pointeur vers la cellule suivant dans la liste */
};

/**
 * @brief Affiche sur la sortie standard les valeurs des cellules d'une liste.
 *
 * @param l la liste à afficher
 */
static void afficher(struct cellule* l)
{
    while (l!=NULL)
    {
        printf("%i ->",l->val);
        l=l->suiv;
    }
    printf("FIN\n");
}

/**
 * @brief Insère une nouvelle cellule en tête d'une liste.
 *
 * @param pl l'adresse de la tête de la liste à étendre
 * @param v la valeur de la nouvelle cellule à créer et insérer
 */
static void inserer_tete(struct cellule** pl, uint32_t v)
{

    struct cellule *cell=malloc(sizeof(struct cellule));
    cell->val=v;
    cell->suiv=*pl;
    *pl=cell;
}

/**
 * @brief Insère une nouvelle cellule en dernière position d'une liste.
 *
 * @param pl l'adresse de la tête de la liste à étendre
 * @param v la valeur de la nouvelle cellule à créer et insérer
 */
static void inserer_queue(struct cellule** pl, uint32_t v)
{
    struct cellule sentinelle = {-1,*pl};
    struct cellule *actuel = &sentinelle;
    
    while (actuel->suiv !=NULL)
    {
        actuel=actuel->suiv;
    }
    actuel->suiv= malloc(sizeof(struct cellule));
    actuel->suiv->val=v;
    actuel->suiv->suiv=NULL;
    *pl = sentinelle.suiv;
}

/**
 * @brief Supprime la première occurrence d'une valeur dans une liste.
 *
 * @param pl l'adresse de la tête de la liste sur laquelle appliquer la suppression
 * @param v la valeur que l'on souhaite supprimer de la liste
 */
static void supprimer_premiere_occurrence(struct cellule** pl, uint32_t v)
{
    struct cellule sentinelle={-1,*pl};
    struct cellule *actuelle=&sentinelle;
    int dedans=1;
    if (actuelle->suiv == NULL)
    {
        printf("La valeur %u n'est pas dedans\n",v);
        dedans=0;
    }
    
    while (actuelle->suiv->val!=v)
    {
        if (actuelle->suiv->suiv == NULL)
        {
            printf("La valeur %u n'est pas dedans\n",v);
            dedans=0;
            break;
        }
        actuelle=actuelle->suiv;
    }
    if (dedans==1)
    {
    printf("j'enleve %u : ",v);
    struct cellule *p=actuelle->suiv; 
    actuelle->suiv=actuelle->suiv->suiv;
    free(p);
    }
    *pl=sentinelle.suiv;
    
    
    
}

/**
 * @brief Point d'entrée du programme.
 *
 * @return int 0 (EXIT_SUCCESS) si tout s'est bien passé
 */
int main(void)
{
    struct cellule* liste = NULL;
    for (uint32_t i = 6; i < 10; i++) {
        inserer_queue(&liste, i);
        afficher(liste);
    }
    
    for (uint32_t i = 5; i > 0; i--) {
        inserer_tete(&liste, i);
        afficher(liste);
    }


    /*
        Initialisation du générateur de nombres aléatoires
        (nécessaire pour que rand() retourne des valeurs différentes à chaque
        exécution du programme).
    */
    srand(time(NULL));

    while (liste != NULL) {
        supprimer_premiere_occurrence(&liste, rand() % 10);
        afficher(liste);
    }
    return EXIT_SUCCESS;
}
