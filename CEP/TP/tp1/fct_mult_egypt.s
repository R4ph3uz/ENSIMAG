/*
uint32_t x, y;

uint32_t mult_egypt(void)
{
    uint32_t res = 0;
    while (y != 0) {
        if (y % 2 == 1) {
            res = res + x;
        }
        x = x << 1 ;
        y = y >> 1;
    }
    return res;
}
*/
    .text
    .globl mult_egypt
/* Attention, res est une variable locale que l'on mettra dans t0 */
/* DEBUT DU CONTEXTE
Fonction :
    mult_egypt: feuille
Contexte :
    x  : mémoire      # allouée par pgcd.c
    y  : mémoire      # allouée par pgcd.c
    res: registre t0
FIN DU CONTEXTE */
mult_egypt:
mult_egypt_fin_prologue:
    li t0, 0 # res
    lw t1,x
    lw t2,y

while:
    beqz t2, fin; # if t2 == zero then fin
    andi t4,t2,1 # verifie si t0 est impair
    addi t4,t4,-1
    beqz t4, if
    j endif
if:
    add t0, t0, t1; # t0 = t0 + t1
    j endif

endif:
    slli t1,t1,1
    srli t2,t2,1
    sw t1,x,t4 # stocke t1 dans x 
    sw t2,y,t4
    j while

fin:
    mv a0, t0
mult_egypt_debut_epilogue:
    ret
