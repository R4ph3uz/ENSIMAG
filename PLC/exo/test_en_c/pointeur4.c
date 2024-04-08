#include <stdlib.h>
#include <stdio.h>

static void init_zero(int *x)
{
    *x = 0;
}

static void init_zero_float(float *f)
{
    *f = 0.0;
}

static void init_null(int **ptr)
{
    *ptr = NULL;
}

int main(void)
{
    int x = 1;
    float f = 1.0f;
    int *ptr = &x;

    init_zero(&x);
    init_zero_float(&f);
    init_null(&ptr);

    printf("x = %i\n", x);   // doit afficher 'x = 0'
    printf("f = %f\n", f);   // doit afficher 'f = 0.000000'
    printf("ptr = %p\n", ptr); // doit afficher 'ptr = (nil)'

    return EXIT_SUCCESS;
}
