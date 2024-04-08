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
/*  void tri_nain(int32_t tab[], uint32_t taille) */
    .globl tri_nain
/* DEBUT DU CONTEXTE
Fonction :
    tri_nain : feuille
Contexte :
    tab: registre a0
    taille: registre a1
    i : registre t0
    tmp : registre t5
FIN DU CONTEXTE */
tri_nain:
tri_nain_fin_prologue:
    li t0,0 #t0=i
    addi t6,a1,-1 # t6=taille -1
    li t3,4
while:
    bge t0, t6, tri_nain_debut_epilogue # if t0 >= t6 then tri_nain_debut_epilogue
    mul t4,t0,t3
    add t1,a0,t4 # stocke dans t1 tab[i]
    lw t1,0(t1)
    add t2,a0,t4 # stocke dans t2 tab[i+1]
    addi t2,t2,4
    lw t2,0(t2)
    bgt t1, t2, if # if t1 > t2 then target
    addi t0,t0,1
    j while
if:

    add t1,a0,t4
    lw t5,0(t1)
    addi t2,t1,4
    lw  t2,0(t2)
    sw t2, 0(t1)
    addi t2,t1,4
    sw t5, 0(t2)
    bgt t0, zero, moinsun # if t0 > zero then moinsun
    j while
moinsun:
    addi t0, t0, -1; # t0 = t0 + -1
    j while
tri_nain_debut_epilogue:
    ret
