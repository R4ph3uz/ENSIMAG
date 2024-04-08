/*
uint32_t somme(void)
{
    uint32_t i;
    uint32_t res = 0;
    for (i = 1; i <= 10; i++) {
        res = res + i;
    }
    return res;
}
*/
    .text
    .globl somme
/* DEBUT DU CONTEXTE
Fonction :
    somme : feuille
Contexte :
    res  : registre t0
    i  : registre t1
FIN DU CONTEXTE */
somme:
somme_fin_prologue:
    li t2, 0 # uint32_t res = 0;
    li t1, 1 # t1= i=1
    li t3, 10 # t3 = 10
    
for:
    beq t1, t3, fin
    add t2, t2, t1; # t2 = t2 + t1
    addi t1, t1, 1; # t1 = t1 + 1
    j for

fin:
    add t2, t2, t1; # t2 = t2 + i
    mv a0, t2

somme_debut_epilogue:
    ret
