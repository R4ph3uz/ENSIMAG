#include <stdlib.h>
#include <stdio.h>


void cat_file(const char *file_name){
FILE *fptr;

// Open a file in read mode
fptr = fopen(file_name, "r");

if (fptr == NULL) {
        /*
            fopen renvoie NULL en cas d'erreur (cf man fopen). La
            variable errno est alors positionnée à une valeur
            explicite (un code), indiquant le type de l'erreur. La
            fonction perror affiche, en plus de la chaine de
            caractères passée en paramètre, une description de
            l'erreur correspondant au code stocké dans errno.
        */
        perror("cat_file: ouverture du fichier");
        exit(EXIT_FAILURE);
    }


char c=fgetc(fptr); 
while (c!=EOF){
printf("%c",c);
c=fgetc(fptr);
}

// Close the file
fclose(fptr); 
}

int main(int argc, char **argv)
{
    /* Affiche un message d'erreur si l'utilisateur oublie l'argument
       à passer en ligne de commandes. */
    if (argc < 2) {
        fprintf(stderr, "Usage: %s nom_fichier1 nom_fichier2 ...\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    for(int i = 1; i < argc; i++) {
        cat_file(argv[i]);
    }
    
    return EXIT_SUCCESS;
}
