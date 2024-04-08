/*
uint32_t x, y;

uint32_t mult_native(void)
{
    return x*y;
}
*/
    .text
    .globl mult_native
/* DEBUT DU CONTEXTE
Fonction :
    mult_native : feuille
Contexte :
    x:mémoire
    y:mémoire
FIN DU CONTEXTE */
mult_native:
mult_native_fin_prologue:
    lw t0, x # x dans t0
    lw t1, y # y dans t1
    mul t0,t0,t1
    mv a0,t0

mult_native_debut_epilogue:
    ret
   .data 
    .globl x,y
