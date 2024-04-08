/*
bool palin(const char *ch)
{
    uint32_t inf, sup;
    inf = 0;
    sup = strlen(ch) - 1;
    while (inf < sup && ch[inf] == ch[sup]) {
        inf++;
        sup--;
    }
    return inf >= sup;
}
*/
    .text
    .globl palin
	.type palin, @function
    /* bool palin(char *ch) */
/* DEBUT DU CONTEXTE
Fonction :
    palin : non feuille
Contexte :
    ra  : pile *(sp+12)
    ch : registre a0; pile *(sp+8)
    sup : pile *(sp+4)
    inf : pile *(sp+0)
FIN DU CONTEXTE */
palin:
    addi sp,sp, -16
    sw ra,12(sp)
    sw a0, 8(sp) # a0=>sp 
    sw t1, 4(sp) # t1=>sp 
palin_fin_prologue:
    li t0,0
    jal strlen
    mv t1,a0 # recupere le resultat de strlen
    lw a0, 8(sp) # remet a0 dans a0
    addi t1, t1, -1; # t1 = t1 + -1
while:
    ble t1, t0, sortie # if t1 <= t0 then sortie
    # calculer ch[inf] et ch[sup]
    add t3,a0,t0
    lbu t3,0(t3)
    add t4,a0,t1
    lbu t4,0(t4)
    bne t3, t4, sortie # if t3 != t4 then sortie
    addi t0, t0, 1; # t0 = t0 + 1
    addi t1, t1, -1; # t1 = t1 + -1
    j while
sortie:
    bge t0, t1, oui # if t0 >= t1 then oui
    li a0,0
    j palin_debut_epilogue
oui:
    li a0,1
palin_debut_epilogue:
    lw ra,12(sp)
    addi sp,sp, 16
    ret
	.size palin, . - palin
