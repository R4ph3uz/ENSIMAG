/*
void tri_nain(int32_t tab[], uint32_t taille)
{
    uint32_t i = 0;
    while(i < taille - 1) {
        if (tab[i] > tab[i+1]) {
            int32_t tmp = tab[i];
            tab[i] = tab[i+1];
            tab[i + 1] = tmp;
            if (i > 0) {
                i = i - 1;
            }
        } else {
            i = i + 1;
        }
    }
}
*/

    .text
    .globl tri_nain_superopt
/* Version encore plus optimisée sans rien respecter (tout se perd ma bonne dame !).

Optimisations effectuées:
  - Partage des lectures mémoires et des calculs d'adresses
  - Calcul de taille - 1 en dehors de la boucle
  - À compléter avec vos autres optimisations

DEBUT DU CONTEXTE
  Fonction :
    tri_nain_superopt : feuille
  Contexte :
    tab: registre a0
    taille: registre a1
    i : registre t0
    tmp : registre t5
    tab[i]: mémoire; registre t1
    &tab[i]: registre s0
    tab[i+1]: mémoire; registre s2
FIN DU CONTEXTE */
tri_nain_superopt:
tri_nain_superopt_fin_prologue:
    li t0,0 #t0=i
    addi t6,a1,-1 # t6=taille -1
    mv s0,a0
    addi t2,s0,4 
    lw t1,0(s0)# stocke dans t1 tab[i]
    lw s2,0(t2)
while:
    bge t0, t6, tri_nain_superopt_debut_epilogue # if t0 >= t6 then tri_nain_debut_epilogue
    bgt t1, s2, if # if t1 > t2 then target
    addi t0,t0,1
    addi s0,s0,4
    addi t2,s0,4
    mv t1,s2
    lw s2,0(t2)
    j while
if:
    mv t5,t1
    mv t1,s2
    sw s2,0(s0)
    sw t5,0(t2)
    mv s2,t5
    bgt t0, zero, moinsun # if t0 > zero then moinsun
    j while
moinsun:
    addi t0, t0, -1; # t0 = t0 + -1
    addi s0,s0,-4
    addi t2,s0,4
    mv s2,t1
    lw t1,0(s0)
    j while
tri_nain_superopt_debut_epilogue:
    ret
