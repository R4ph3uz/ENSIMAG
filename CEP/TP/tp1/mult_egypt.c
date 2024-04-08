#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

extern uint32_t mult_egypt(void);
static uint32_t mult_c(void);

uint32_t x, y;

static uint32_t mult_c(void)
{
   return x * y;
}
uint32_t mult_egt(void)
{
    uint32_t res = 0;
    while (y != 0) {
        if (y % 2 == 1) {
            res = res + x;
        }
        x = x << 1 ;
        y = y >> 1;
    }
    return res;
}

static void test(uint32_t xi, uint32_t yi)
{
   printf("Multiplication de %" PRIu32 " par %" PRIu32 ":\n", xi, yi);
   x = xi;
   y = yi;
   printf("Résultat attendu :%" PRIu32 "\n", mult_c());
   x = xi;
   y = yi;
   printf("Résultat de mult_egypt: %" PRIu32 "\n\n", mult_egypt());
}

int main(void)
{
   test(8, 7);
   test(5, 16);
   test(20, 54);

   return 0;
}
