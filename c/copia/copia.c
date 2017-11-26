/*
 * copia.c
 *
 *  Created on: 7 de nov de 2016
 *      Author: mouraja
 */
#include <stdio.h>
#include <string.h>
int main() {
    char * src = "Joao Augusto de Moura";
    char dst[4];
    memcpy( dst, src+9, 4 );
    printf("%s", dst);
    return 0;
}
