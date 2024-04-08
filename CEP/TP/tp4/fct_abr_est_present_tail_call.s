/*
bool abr_est_present_tail_call(uint32_t val, struct noeud_t *abr)
{
   if (abr == NULL) {
       return false;
   } else if (val == abr->val) {
       return true;
   } else if (val < abr->val) {
       return abr_est_present_tail_call(val, abr->fg);
   } else {
       return abr_est_present_tail_call(val, abr->fd);
   }
}
*/
    .text
    .globl abr_est_present_tail_call
/* DEBUT DU CONTEXTE
Fonction :
    abr_est_present_tail_call : feuille
Contexte :
    val : registre a0
    abr : registre a1
FIN DU CONTEXTE */
abr_est_present_tail_call:
abr_est_present_tail_call_fin_prologue:
abr_est_present_fin_prologue:
    beqz a1,faux
    lw t1, 0(a1) # 
    beq a0,t1,vrai
    blt a0, t1, gauche # if a0 < t1 then gauche
    lw t1, 8(a1)
    mv a1,t1
    j abr_est_present_tail_call
    j abr_est_present_tail_call_debut_epilogue
gauche:
    lw t1,4(a1)
    mv a1,t1
    j abr_est_present_tail_call
    j abr_est_present_tail_call_debut_epilogue
vrai:
    li a0,1
    j abr_est_present_tail_call_debut_epilogue
faux:
    li a0,0
    j abr_est_present_tail_call_debut_epilogue

abr_est_present_tail_call_debut_epilogue:
    ret
