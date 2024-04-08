/*
uint32_t taille_chaine(const char *chaine)
{
    uint32_t taille = 0;
    while (chaine[taille] != '\0') {
        taille++;
    }
    return taille;
}
*/
    .text
    .globl taille_chaine
/* uint32_t taille_chaine(const char *chaine) */
/* DEBUT DU CONTEXTE
Fonction :
    taille_chaine : feuille
Contexte :
    taille: registre t0
    chaine: registre a0
FIN DU CONTEXTE */
taille_chaine:
taille_chaine_fin_prologue:
    li t0,0
    li t2, 0 # t2 = 0
while:
    lbu t1, 0(a0)
    beq t1, t2, taille_chaine_debut_epilogue; # if t1 == t0 then taille_chaine_debut_epilogue
    addi t0, t0, 1; # t0 = t0 + 1
    addi a0, a0, 1; # a0 = a0 + 1
    j while
taille_chaine_debut_epilogue:
    mv a0,t0
    ret
