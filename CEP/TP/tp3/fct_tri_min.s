/*
void tri_min(int32_t tab[], uint32_t taille)
{
    uint32_t i, j, ix_min;
    int32_t tmp;
    for (i = 0; i < taille - 1; i++) {
        for (ix_min = i, j = i + 1; j < taille; j++) {
            if (tab[j] < tab[ix_min]) {
                ix_min = j;
            }
        }
        tmp = tab[i];
        tab[i] = tab[ix_min];
        tab[ix_min] = tmp;
    }
}
*/
    .text
    .globl tri_min
/* void tri_min(int32_t tab[], uint32_t taille) */
/* DEBUT DU CONTEXTE
Fonction :
    tri_min : feuille
Contexte :
    tab:registre a0
    taille:registre a1
    tmp:registre t1
    ix_min:registre t2
    j:registre t3
    i:registre t4
FIN DU CONTEXTE */
tri_min:
tri_min_fin_prologue:
    li t4,0  # i=t4=0 
for_i:
    mv t2,t4 # ixmin=i
    addi t3, t4, 1; # t3 = t4 + 1 # j=i+1
    addi t5,a1,-1
    bge t4, t5, tri_min_debut_epilogue # if t4 >= t5 then tri_min_epi  "i>=taille-1 
for_j:
    bge t3, a1, end_i    # if t3 < a1 then continue, else end_j
    
    slli t6, t3, 2       # t6 = t3 * 4
    add t6, a0, t6       # t6 = a0 + t6 (adresse de tab[j])
    lw t6, 0(t6)         # t6 = tab[j]
    
    slli t5, t2, 2       # t5 = t2 * 4
    add t5, a0, t5       # t5 = a0 + t5 (adresse de tab[ix_min])
    lw t5, 0(t5)         # t5 = tab[ix_min]
    
    blt t6, t5, changement_ix  # if tab[j] < tab[ix_min] then changement_ix
    
    addi t3, t3, 1       # j++
    j for_j
changement_ix:
    mv  t2, t3 # t2 = t3 #ixmin=j
    j for_j
end_i:
    slli t5,t4,2
    add t5,a0,t5
    lw t1, 0(t5) # tmp = tab[i];
    slli t5,t2,2
    add t5, a0,t5 # tab[i] = tab[ix_min];
    lw t0,0(t5)
    
    slli t6,t4,2
    add t6, a0,t6 # tab[i] = tab[ix_min];
    sw t0,0(t6) # tab[i] = tab[ix_min];
    sw t1,0(t5) # tab[ix_min] = tmp;
    
    addi t4, t4, 1; # t4 = t4 + 1 # i ++
    j for_i
    
tri_min_debut_epilogue:
    ret

