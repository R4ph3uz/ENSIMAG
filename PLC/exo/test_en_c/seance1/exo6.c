#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

int main(int argc, char const *argv[])
{
    // char* msg1 = "hello";
    // char* msg2 = "world !";
    // char *phrase=malloc(sizeof(msg1) +sizeof(msg2));
    // phrase[0]=*msg1;
    // phrase[1]=*msg2;
    char *phrase[2]={"hello","world"}; // "hello" 'hello'
    printf("%s %s",phrase[0], phrase[1]);
    return 0;
}
