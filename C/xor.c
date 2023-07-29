#include <stdio.h>

int main() {
    unsigned char buf[] = "";

    char key = 'X';
    printf("[+] Encrypted Shellcode: \r\n");
    for (int i = 0; i < sizeof(buf); i++) {
        printf("\\x%02x", buf[i] ^ key);
    }
    printf("\n");
    return 0;
}
