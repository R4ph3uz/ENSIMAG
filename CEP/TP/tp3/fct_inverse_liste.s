/*
void inverse_liste(struct cellule_t **l)
{
   struct cellule_t *res, *suiv;
   res = NULL;
   while (*l != NULL) {
       suiv = (*l)->suiv;
       (*l)->suiv = res;
       res = *l;
       *l = suiv;
   }
   *l = res;
}
*/
    .text
    .globl inverse_liste
/* void inverse_liste(struct cellule_t **l) */
/* DEBUT DU CONTEXTE
Fonction :
    inverse_liste : feuille
Contexte :
    l   : registre a0
    res : registre t0
    suiv: registre t1
FIN DU CONTEXTE */
inverse_liste:
inverse_liste_fin_prologue:
    li t0, 0 # t0 = 0
while:
    lw t4, 0(a0)
    beq t4,zero, sortie; # if O(t0) == 0 then sortie #while (*l != NULL) {
    lw t1, 4(t4) # charge (*l)->suiv dans suiv
    sw t0, 4(t4) # res => (*l)->suiv
    lw t0, 0(a0) # res = *l;
    sw t1,0(a0)  # *l = suiv;
    j while
sortie:
    sw t0,0(a0)
inverse_liste_debut_epilogue:
    ret
