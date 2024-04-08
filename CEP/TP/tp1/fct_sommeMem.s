/*
uint32_t res;

uint32_t sommeMem(void)
{
    uint32_t i;
    res = 0;
    for (i = 1; i <= 10; i++) {
        res = res + i;
    }
    return res;
}
*/

    .text
    .globl sommeMem
/* DEBUT DU CONTEXTE
Fonction :
    sommeMem : feuille 
Contexte :
    res : mémoire # alloué par sommeMem.c
    i  : registre t1
FIN DU CONTEXTE */
sommeMem:
sommeMem_fin_prologue:
    li t0,0 # mets t0 à 0
    sw t0, res,t4 # mets 0 dans res
    li t1, 1 # t1= i=1
    li t3, 11 # t3 = 11
for:
    beq t1, t3, fin
    lw t0, res # met t0 dans res
    add t0, t0, t1; # t0 = t0 + t1 / res = res + i;
    sw t0, res,t4 # restocke res
    addi t1, t1, 1; # t1 = t1 + 1 / i++
    j for

fin:
    sw t0, res, t4 # remet dans res t0
    mv a0, t0 

sommeMem_debut_epilogue:
    ret

    .data 
    .globl res
/* uint32_t res;
  La variable globale res étant définie dans ce fichier, il est nécessaire de
  la définir dans la section .data du programme assembleur.
*/
res:
    .word 0
