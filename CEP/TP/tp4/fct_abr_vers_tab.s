/*
void abr_vers_tab(struct noeud_t *abr)
{
    struct noeud_t *fd;
    if (abr != NULL) {
        abr_vers_tab(abr->fg);
        *ptr = abr->val;
        ptr++;
        fd = abr->fd;
        free(abr);
        abr_vers_tab(fd);
    }
}
*/

    .text
    .globl abr_vers_tab
/* DEBUT DU CONTEXTE
Fonction :
    abr_vers_tab : non feuille
Contexte :
    abr : registre a0; pile *(sp+0)
    fd : pile *(sp+4)
    ptr : mémoire
    ra : pile *(sp+8)
FIN DU CONTEXTE */
abr_vers_tab:
    addi sp, sp, -12; # sp = sp + -12
    sw a0, 0(sp)
    sw t0,4(sp)
    sw ra, 8(sp)
abr_vers_tab_fin_prologue:
    beqz a0,abr_vers_tab_debut_epilogue
    lw a0,4(a0)
    call abr_vers_tab
    lw a0,0(sp)
    lw t1,0(a0)
    lw t0,ptr
    sw t1,0(t0)
    lw a1,ptr
    addi a1, a1, 4
    sw a1,ptr,t4
    lw t2,8(a0)
    sw t2, 4(sp)
    call free
    mv a0,t2
    call abr_vers_tab
abr_vers_tab_debut_epilogue:
    lw ra, 8(sp)
    addi sp,sp,12
    ret

.data
.globl ptr
ptr:
    .word 0

