#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

int main(void)
{
    int i =0;
    char c='a';
    float f=0.0;
    printf("--> i = %i, c = %c, f = %f\n", i, c, f);
    
    int *ptr_i=&i;
    char *ptr_c=&c;
    float *ptr_f=&f;
    printf("--> i = %i, c = %c, f = %f\n", i, c, f);

    *ptr_i=42;
    *ptr_f=1.0;
    *ptr_c='z';
printf("--> i = %i, c = %c, f = %f\n", i, c, f);

    return 0;
}
