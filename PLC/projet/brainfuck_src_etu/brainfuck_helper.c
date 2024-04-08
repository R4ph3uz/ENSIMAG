#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <stdio.h>
#include "brainfuck_helper.h"

/**
 * @brief Récupère le programme Brainfuck à interpréter depuis un fichier
 *
 * @param input_filename le nom du fichier Brainfuck à récupérer
 * @return un tableau de caractère terminé par le caractère '\0' ou NULL si input_filename
 *         n'existe pas dans le répertoire courant
 */
char* get_input_prog(char* input_filename){
    FILE *file;
    if ((file = fopen(input_filename, "r")) ) {

    fseek(file,0,SEEK_END); // recupère la taille
    long taille_fichier=ftell(file);
    rewind(file);

    char* ret=malloc(sizeof(char)*(taille_fichier+1));
    int compteur=0;
        // Boucle de lecture des caractères un à un
        int caractereActuel = 0;
        while (caractereActuel != EOF){// On continue tant que fgetc n'a pas retourné EOF (fin de fichier)
            caractereActuel = fgetc(file); // On lit le caractère
            ret[compteur]=caractereActuel; // on le met dans au pointeur
            compteur++;
        }
        ret[compteur-1]='\0';
        fclose(file);
        return ret;
    } else {
        return NULL;
    }
}

/**
 * @brief Libère ce qui a été alloué par get_input_prog.
 *
 * @param loops
 */
void free_input_prog(char* input_prog){
    free(input_prog);
}

/**
 * @brief Exécute l'instruction pointée par le pointeur pointé par ipp,
 *........et incrémente ce pointeur.
 *
 * @param ipp un pointeur vers le pointeur d'instructions
 * @param dpp un pointeur vers le pointeur de données
 * @param loops le "quelque chose" représentant les boucles, cf 'build_loops'.
 */
void execute_instruction(char** ipp, uint8_t** dpp, void* loops){
    typedef struct
    {
	    int compteur_param;
        char* premier_char;
        int* ouvrante;
        int* fermante;
    } listes;
	listes* boucles=loops;

    switch (**ipp) {
        case '>':
            *dpp = *dpp+1;
            (*ipp)++;
            break;
        case '<':
            *dpp=*dpp-1;
            (*ipp)++;
            break;
        case '+':
            **dpp = **dpp+1;
            (*ipp)++;
            break;
        case '-':
            **dpp = **dpp-1;
            (*ipp)++;
            break;
        case '.':
            printf("%c",**dpp);
            (*ipp)++;
            break;
        case ',':
            **dpp = getchar();
            (*ipp)++;
            break;
        case '[':
                // fprintf(stderr,"ipp avant:%i",**ipp);
                if (**dpp==0)
                {
                    // fprintf(stderr,"ipp avant b:%d",**ipp);
                    for (int i = 0; i < boucles->compteur_param; i++)
                    {
                        // fprintf(stderr,"en boucle");
                        if (boucles->ouvrante[i]==((*ipp)-boucles->premier_char))
                        {
                            *ipp = boucles->premier_char +boucles->fermante[i]+1;
                            break;
                        }
                        
                    }
                    // fprintf(stderr,"ipp après b:%d",**ipp);
                }
                else{
                    (*ipp)++;
                }
            break;
        case ']':
            if (**dpp==0){
             
                // fprintf(stderr,"ipp retour avant:%i",**ipp);
                (*ipp)++;
                // fprintf(stderr,"ipp retour apres continue:%i",**ipp);
            }
            else{
                // fprintf(stderr,"ipp fin b:%d",**ipp);
                for (int i = 0; i < (boucles->compteur_param); i++)
                    {
                        // fprintf(stderr,"i=%i",i);
                        if (boucles->fermante[i]==(*ipp)-boucles->premier_char)
                        {
                            *ipp = boucles->premier_char +boucles->ouvrante[i]+1;
                            break;
                        }
                        
                    }
                // fprintf(stderr,"ipp fin apres b:%d",**ipp);
                // *ipp-=(int)(boucles->fermante[boucles->compteur_param] - boucles->ouvrante[boucles->compteur_param] +1);
            }   
            break;
        default:
            // printf("instruction invalide : %c\n",**ipp);
            (*ipp)++;
            break;
    };
}

/**
 * @brief Analyse le programme Brainfuck passé en paramètre pour construire "quelque chose"
 *        qui représente les boucles du programme. Ce "quelque chose" sera ensuite utilisé
 *        lors de l'exécution des instructions, cf 'execute_instruction'.
 *        C'est à vous de décider ce que sera "quelque chose".
 *
 * @param input_prog le programme BrainFuck à analyser
 * @return "quelque chose" qui représente les boucles du programme
 */
void* build_loops(char* input_prog){
    typedef struct
    {
	    int compteur_param;
        int premiere_case;
        char* premier_char;
        int* ouvrante;
        int* fermante;
    } listes;

    int longueur= strlen(input_prog);

    listes* deuxListes = (listes*)malloc(sizeof(listes));
    deuxListes->premier_char=input_prog;
    deuxListes->compteur_param=0;
    deuxListes->ouvrante =(int *) malloc(sizeof(int)*longueur);
    deuxListes->fermante =(int *) malloc(sizeof(int)*longueur);
    for (int i = 0; i < longueur; i++)
    {
        deuxListes->ouvrante[i]=0;
        deuxListes->fermante[i]=0;
    }
    int compteur_car=0;
    int compteur_par=0;
    while (input_prog[compteur_car] != '\0')
    {
        // fprintf(stderr,"%c",input_prog[compteur_car]);
        if (input_prog[compteur_car]=='['){
	        // fprintf(stderr,"%i\n",compteur_car);
            deuxListes->ouvrante[compteur_par]=compteur_car;
            compteur_par++;
        }
        else if (input_prog[compteur_car]==']'){
           int indice_rev=0;
           for (int j = 0; j < compteur_par; j++)
           {
	            // fprintf(stderr,"%i\n",compteur_car);
                indice_rev=compteur_par-j-1;
                // fprintf(stderr,"indice rev: %i",indice_rev);
                // fprintf(stderr,"numero asso %i",deuxListes->fermante[indice_rev]);
                if (deuxListes->fermante[indice_rev]==0){
                    deuxListes->fermante[indice_rev]=compteur_car;
                    break;
                }
           }
        }
        compteur_car++;
    }
    deuxListes->compteur_param=compteur_par;
    // printf("compteur %i",(deuxListes->compteur_param));
    // for (int i = 0; i < longueur; i++)
    // {
    //     printf("%d ", deuxListes->ouvrante[i]);
    // }
    // printf("\n");
    
    // printf("fermante : ");
    // for (int i = 0; i < longueur; i++)
    // {
    //     printf("%d ", deuxListes->fermante[i]);
    // }
    // printf("\n");
    return deuxListes;
}


/**
 * @brief Libère ce qui a été alloué par build_loops.
 *
 * @param loops
 */
void free_loops(void* loops){
    typedef struct
    {
	    int compteur_param;
        char* premier_char;
        int* ouvrante;
        int* fermante;
    } listes;
	listes* boucles=loops;

	free(boucles->ouvrante);
	free(boucles->fermante);
	free(boucles);
}
