/*
void hello(void)
{
	affiche_HelloWorld();
}
*/

    .text
    .globl hello
    /* void hello(void) */
/*
  Pas de paramètre, Pas de variable locale.
  ra doit être sauvegardé dans la pile pour ne pas être écrasé lors de l'appel de fonction.

DEBUT DU CONTEXTE
  Fonction :
    hello : non feuille
  Contexte :
    ra  : pile *(sp+0)
FIN DU CONTEXTE */
hello:
hello_fin_prologue:
  sw ra, 1*4(sp)
  jal affiche_HelloWorld  # jump to affiche_HelloWorld and save position to ra
  lw ra, 1*4(sp)
hello_debut_epilogue:
    ret
