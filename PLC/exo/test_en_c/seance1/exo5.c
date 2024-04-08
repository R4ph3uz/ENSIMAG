#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

void modifie_message(char msg[]){
    msg[0]='B';
    msg[1]='y';
    msg[2]='e';
    msg[3]=' ';
    msg[4]=' ';
}

int main()
{
    char *msg1="Hello world !";
    modifie_message(msg1);
    char msg2[]="Hello world !";
    printf("%s et %s\n",msg1,msg2);
}