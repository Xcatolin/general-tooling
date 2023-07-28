#include <stdio.h>

void xor_encrypt(unsigned char* buffer, char key) {
    for (int i = 0; i < sizeof(buffer); i++) {
        buffer[i] ^= key;
    }
}

int main() {
    unsigned char buf[] = "\xc8\x94\x9b\xb0\xa1\xa7\xa7\xa7\x00";
    char key = 'X';

    xor_encrypt(buf, key);

    printf("\n[+] Encrypted Shellcode: \r\n");
    for (int i = 0; i < sizeof(buf); i++) {
        printf("\\x%02x", buf[i]);
    }
    printf("\n");
    return 0;
}
