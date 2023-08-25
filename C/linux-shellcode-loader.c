#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>

unsigned char buf[] = "";

int main() {
    // Allocate executable memory using mmap
    void *mem = mmap(NULL, sizeof(buf), PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    
    if (mem == MAP_FAILED) {
        perror("mmap");
        return 1;
    }
    
    // Copy buf to the allocated memory
    memcpy(mem, buf, sizeof(buf));
    
    // Cast the allocated memory as a function and execute
    void (*func)() = (void (*)())mem;
    func();

    // Clean up memory
    munmap(mem, sizeof(buf));

    // Return value of 3
    return 3;
}
