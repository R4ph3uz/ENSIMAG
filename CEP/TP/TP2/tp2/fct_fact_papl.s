/*
uint32_t fact_papl(uint32_t n)
{
    if (n <= 1) {
        return 1;
    } else {
        uint64_t tmp = n*fact_papl(n-1);
        if ((tmp >> 32) > 0)
            erreur_fact(n);
        return (uint32_t)tmp;
    }
}
*/

    .text
    .globl fact_papl
    /* uint32_t fact_papl(uint32_t n) */
/* DEBUT DU CONTEXTE
Fonction :
    fact_papl : non feuille
Contexte :
    ra : pile *(sp+12)
    tmp: pile *(sp+4)
    n  : registre a0;pile *(sp+0)
FIN DU CONTEXTE */
fact_papl:
    addi sp, sp , -4*4
    sw ra,12(sp)
    sw a1,4(sp) # res de fact
    sw a0,0(sp) # n
fact_papl_fin_prologue:
    li t0, 1 # t0 = 1
    ble a0, t0, fact_papl_debut_epilogue # if a0 <= t0=1 then factbase
    addi a0, a0,-1
    li a1,1
    call fact_papl
    mv a1,a0
    sw a1,4(sp)
    lw a0,0(sp) # remet n dans a0
    mulh t1,a0,a1
    mul a1, a0, a1
    bgt t1, zero, erreur
    sw a1, 4(sp)
    j fact_papl_debut_epilogue
erreur:
    lw a0,0(sp)
    call erreur_fact
fact_papl_debut_epilogue:
    lw ra, 12(sp)
    lw a0, 4(sp)
    addi sp, sp, 4*4; # sp = sp + 3*4
    ret

