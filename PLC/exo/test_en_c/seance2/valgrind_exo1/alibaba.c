#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>

/* Structure de données décrivant un élément d'une liste. */
struct cellule
{
    /* La valeur d'une cellule est un entier. */
    uint32_t val;
    /* Pointeur vers la cellule suivant dans la liste. */
    struct cellule *suiv; //
    struct cellule *prec;
};
static void afficher(struct cellule *l)
{
    /* A implémenter! */
    if (l!=NULL){
        struct cellule *fin = l->prec;
        while(l!=fin){
            printf("%d-> ",l->val);
            l=l->suiv;
        }
        printf("%d-> ",fin->val);
    }
    printf("fin\n");
}

/*
static void inserer_tete(struct cellule **pl, uint32_t v)
{

    struct cellule *cel=(struct cellule*)malloc(sizeof(struct cellule));
    cel->val = v;
    if(*pl ==NULL){
        cel->prec = cel;
        cel->suiv = cel;
    }else{
        cel->suiv = *pl;
        cel->prec = (*pl)->prec;
        cel->suiv->prec = cel;
        cel->prec->suiv = cel;
    }
    // cel->suiv = *pl;
    *pl = cel;
}
*/
static void insere_fin(struct cellule **pl, uint32_t v){
    struct cellule *cel=(struct cellule*)malloc(sizeof(struct cellule));
     cel->val = v;
    if(*pl ==NULL){
        cel->prec = cel;
        cel->suiv = cel;
        *pl = cel;
    }else{
        struct cellule *fin = (*pl)->prec;
        cel->prec = fin;
        cel->suiv = *pl;
        fin->suiv = cel;
        (*pl)->prec = cel;
    }
}


static uint32_t cellue_taille(struct cellule *l){
    uint32_t compte = 0;
    if (l!=NULL){
           struct cellule *fin = l->prec;
           while(l!=fin){
               compte++;
               l=l->suiv;
           }
        compte++;
       }
    return compte;
}

// supprime l'element e de la liste pointee par pl.
// precondition: *pl non vide, e non null, e dans *pl
static void cellule_supprime(struct cellule **pl, struct cellule *e){
    if((e->prec)==e){
           *pl=NULL;
    }else{
        if(e == *pl){
            *pl=e->suiv;
        }
        e->prec->suiv=e->suiv;
        e->suiv->prec=e->prec;
    }
    free(e);
}
static void vider_liste(struct cellule **pl)
{
    // fonctionne mais pas exactement ce qui est demandé 
    // while (*pl!=NULL)
    // {
    //     cellule_supprime(&(*pl),*pl);
    // }
    
    struct cellule *temp = *pl;
    struct cellule *fin = (*pl)->prec;
    while((*pl)->suiv!=fin){
        *pl = (*pl)->suiv;
        free(temp);
    }
    free(*pl); // corrextion car pl n'est pas libéré sinon mais que celi d'après
    free(fin);
    *pl=NULL;
}

struct cellule* methode_alibaba(struct cellule **pl){
    int cpt = 0;
    struct cellule *list_sup=NULL;
    for(int i=1;i<=41;i++){
        insere_fin(pl,i);
    }
    afficher(*pl);
    struct cellule *cel = (*pl)->suiv->suiv;
    struct cellule *temp=cel->suiv;
    insere_fin(&list_sup, cel->val);
    cellule_supprime(pl, cel);
    
    while(cellue_taille(*pl)>2){
        printf("compte:%d\n",cpt);
        cel=temp->suiv->suiv;
        temp=cel->suiv;
        insere_fin(&list_sup, cel->val);
        cellule_supprime(pl,cel);
        afficher(*pl);
        
        cpt++;
    }
    afficher(*pl);
    return list_sup;
}

int main(void){
    struct cellule *liste = NULL;
    struct cellule *liste_perdante=methode_alibaba(&liste);
    afficher(liste_perdante);
    afficher(liste);
    vider_liste(&liste_perdante);
    vider_liste(&liste);
//    for (uint32_t i = 0; i < 10; i++) {
//        insere_fin(&liste, i);
//        afficher(liste);
//    }
//    printf("%d\n",cellue_taille(liste));
//    cellule_supprime(&liste, liste->suiv);
//    afficher(liste);
//
//    printf("-----");
//    vider_liste(&liste);
//    afficher(liste);
//    printf("-------");
//    for (uint32_t i = 5; i > 0; i--) {
//        insere_fin(&liste, i);
//        afficher(liste);
//    }


return 0;
}
