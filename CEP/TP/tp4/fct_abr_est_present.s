/*
bool abr_est_present(uint32_t val, struct noeud_t *abr)
{
   if (abr == NULL) {
       return false;
   } else if (val == abr->val) {
       return true;
   } else if (val < abr->val) {
       return abr_est_present(val, abr->fg);
   } else {
       return abr_est_present(val, abr->fd);
   }
}
*/

    .text
    .globl abr_est_present
/* DEBUT DU CONTEXTE
Fonction :
    abr_est_present : non feuille
Contexte :
    val : registre a0;pile *(sp+0)
    abr : registre a1; pile *(sp+4)
    ra  : pile *(sp+8)
FIN DU CONTEXTE */
abr_est_present:
    addi sp, sp, -12; # sp = sp + -16
    sw ra, 8(sp)
    sw a1, 4(sp)
    sw a0, 0(sp)
abr_est_present_fin_prologue:
    beqz a1,faux
    lw t1, 0(a1) # 
    beq a0,t1,vrai
    blt a0, t1, gauche # if a0 < t1 then gauche
    lw t1, 8(a1)
    mv a1,t1
    call abr_est_present
    j abr_est_present_debut_epilogue
gauche:
    lw t1,4(a1)
    mv a1,t1
    call abr_est_present
    j abr_est_present_debut_epilogue
vrai:
    li a0,1
    j abr_est_present_debut_epilogue
faux:
    li a0,0
    j abr_est_present_debut_epilogue

abr_est_present_debut_epilogue:
    lw ra,8(sp)
    addi sp, sp, 12; # sp = sp + 12
    ret
