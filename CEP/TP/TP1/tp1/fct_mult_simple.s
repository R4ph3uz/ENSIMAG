/*
uint32_t x, y;  // dans la mémoire globale et allouées dans le fichier C
uint32_t res;   // dans la mémoire globale et à allouer en langage d'assemblage

uint32_t mult_simple(void)
{
    res = 0;
    while (y != 0) {
        res = res + x;
        y--;
    }
    return res;
}
*/
    .text
    .globl mult_simple
/* DEBUT DU CONTEXTE
Fonction :
    mult_simple : feuille
Contexte :
    x  : mémoire      # allouée par pgcd.c
    y  : mémoire      # allouée par pgcd.c
    res  : mémoire   
FIN DU CONTEXTE */
mult_simple:
mult_simple_fin_prologue:
    lw t0, x # stocke dans t0 x 
    lw t1, y # stocke dans t1 y 
    # lw t2, res # stocke dans t2 res
    li t2,0 # mets 0 dans res=t2
while:
    beq t1, zero, fin; # if t1 == zero then fin
    add t2, t2, t0; # t2 = t2 + t0
    addi t1, t1, -1; # t1 = t1 + -1
    j while
fin:
    sw t2, res,t4 # remet dans res t0
    mv a0, t2 

mult_simple_debut_epilogue:
    ret


    .data
    .globl res
/* uint32_t res; */
res:
    .word 0
