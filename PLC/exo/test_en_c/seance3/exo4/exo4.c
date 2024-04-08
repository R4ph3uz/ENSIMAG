int main(void)
{
    double nb_en_or = (1 + sqrt(5))/2;
    printf("le nombre d'or vaut %f\n",nb_en_or);
    return 0;
}

// exo.c: In function ‘main’:
// exo.c:2:28: warning: implicit declaration of function ‘sqrt’ [-Wimplicit-function-declaration]
//     2 |     double nb_en_or = (1 + sqrt(5)) / 2;
//     |                            ^~~~
// exo.c:1:1: note: include ‘<math.h>’ or provide a declaration of ‘sqrt’
// +++ |+#include <math.h>
//     1 | int main(void) {
// exo.c:2:28: warning: incompatible implicit declaration of built-in function ‘sqrt’ [-Wbuiltin-declaration-mismatch]
//     2 |     double nb_en_or = (1 + sqrt(5)) / 2;
//     |                            ^~~~
// exo.c:2:28: note: include ‘<math.h>’ or provide a declaration of ‘sqrt’
// exo.c:3:5: warning: implicit declaration of function ‘printf’ [-Wimplicit-function-declaration]
//     3 |     printf("le nombre en or vaut %f\n", nb_en_or);
//     |     ^~~~~~
// exo.c:1:1: note: include ‘<stdio.h>’ or provide a declaration of ‘printf’
// +++ |+#include <stdio.h>
//     1 | int main(void) {
// exo.c:3:5: warning: incompatible implicit declaration of built-in function ‘printf’ [-Wbuiltin-declaration-mismatch]
//     3 |     printf("le nombre en or vaut %f\n", nb_en_or);
//     |     ^~~~~~
// exo.c:3:5: note: include ‘<stdio.h>’ or provide a declaration of ‘printf’