#include <stdlib.h>
#include <stdint.h>

static char encode_lettre(char c)
{
    return (((c - 'a') + 7) % 26) + 'a';
}

static void encode(size_t iter, char* message, size_t len)
{
    for (size_t i = 0; i < len; i++) {
        message[i] = encode_lettre(message[i]);
    }
}

int main(void)
{
    char message[] = { 'h', 'e', 'l', 'l', 'o' };
    for (size_t i = 0; i < 1000000; i++) {
        encode(i, message, 5);
    }
    return EXIT_SUCCESS;
}