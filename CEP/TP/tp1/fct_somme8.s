/*
uint8_t res8;

uint8_t somme8(void)
{
    uint8_t i;
    res8 = 0;
    for (i = 1; i <= 30; i++) {
        res8 = res8 + i;
    }
    return res8;
}
*/

    .text
    .globl somme8
/* DEBUT DU CONTEXTE
Fonction :
    somme8 : feuille
Contexte :
    res8 : mémoire
    i    : registre t1
FIN DU CONTEXTE */
somme8:
somme8_fin_prologue:
    li t0,0 # i vaut 1
    sb t0, res8, t4 # stocke res8 dans t0 
    li t1,1 # i vaut 1
    li t2,31
for:
    beq t1, t2, fin; # if i == 31 then fin
    lbu t0, res8 # remets la valeur de res8 dans t0
    add t0, t0, t1; # t0 = t0 + t1
    addi t1, t1, 1; # t1 = t1 + 1
    sb t0, res8,t4 # re ecris t0 dans res8
    j for
fin:
    sb t0, res8, t4 # remet t0 dans res
    mv a0, t0


somme8_debut_epilogue:
    ret

    .data
    .globl res8
/* uint8_t res8;
  La variable globale res8 étant définie dans ce fichier, il est nécessaire de
  la définir dans la section .data du programme assembleur.
*/
res8:
    .byte 0
