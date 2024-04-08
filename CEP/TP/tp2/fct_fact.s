/*
uint32_t fact(uint32_t n)
{
    if (n <= 1) {
        return 1;
    } else {
        return n * fact(n - 1);
    }
}
*/

    .text
    .globl fact
    /* uint32_t fact(uint32_t n) */
/* DEBUT DU CONTEXTE
Fonction :
    fact : non feuille
Contexte :
    ra : pile *(sp+4)
    n  : registre a0;pile *(sp+0)
FIN DU CONTEXTE */
fact:
    addi sp, sp, -8; # sp = sp + -4
    sw a0, 0(sp) # 
    sw ra, 4(sp) # 
fact_fin_prologue:
    li t0, 1 # t0 = 1
    ble a0, t0, fact_debut_epilogue # if a0 <= t0=1 then factbase
    addi a0,a0,-1
    call fact
    mv t1,a0

    lw a0,0(sp) # remet n dans a0
    mul a0, a0, t1

fact_debut_epilogue:
    lw ra, 4(sp)
    addi sp, sp, 8; # sp = sp + 8
    ret
