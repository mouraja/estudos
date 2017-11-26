/*
 * utils.c
 *
 *  Created on: Aug 6, 2016
 *      Author: mouraja
 */

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "utils.h"

void remove_caracter( char * str, char * args ) {
    int j = 0, k = 0, i = 0, t = 0;
    char a;
    while ( str[i] != '\0' ) {
        for ( j=0; j < (int)strlen(args); j++ ) {
            if ( str[i] == args[j] ) {
                t = k = i;
                while ( str[k] != '\0' ) {
                   ++t;
                   str[k] = str[t];
                   ++k;
                }
                break;
            }
        }
        ++i;
    }
}

/* return a new string with every instance of ch replaced by repl */
char * replace(char * s, char ch, const char * repl) {
    int count = 0;
    char * t;
    for(t=s; *t; t++) {
        count += (*t == ch);
    }
    size_t rlen = strlen(repl);
    char *res = malloc(strlen(s) + (rlen-1)*count + 1);
    char *ptr = res;
    for(t=s; *t; t++) {
        if(t[0] == ch) {
            memcpy(ptr, repl, rlen);
            ptr += rlen;
        } else {
            *ptr++ = *t;
        }
    }
    *ptr = 0;
    return res;
}

void substring ( char * dst, char * base, int posicao, int comprimento ) {
    int tamanho = strlen(base);
    if ( posicao + comprimento >= tamanho ) {
        *dst = '\0';
    }
    strncpy( dst, base + posicao, comprimento );
}

int isnull(char * base) {
    if ( *base == '\0' ) {
        return STATE_SUCCESS;
    }
    return STATE_FAIL;
}

int valida_padrao( char * base, char * padrao ) {
    int padrao_ok;
    char *p;
    if (isnull(base)) {
        return STATE_FAIL;
    }
    printf("padrao %s \n", padrao);
    printf("base %s \n", base);
    //for ( i = 0; i < strlen(base); i++ ) {
    for (; *base != '\0'; base++) {
        padrao_ok = OFF;
        //for ( j = 0; j < strlen(padrao); j++) {
        p = padrao;
        for (; *p != '\0'; p++) {
            if ( base[0] == p[0] ) {
                padrao_ok = ON;
                break;
            }
        }
        if ( padrao_ok == OFF ) {
            return STATE_FAIL;
        }
    }
    return STATE_SUCCESS;
}

int tem_repeticao(char * base, char filtro, int qtde) {
    int contador = 0;
    char * temp = base;
    for ( ; *temp != '\0'; temp++ ) {
        if ( filtro == *temp ) {
            contador++;
        }
    }
    if (contador >= qtde) {
        return STATE_SUCCESS;
    }
    return STATE_FAIL;
}

/*
char * str_replace(
        char const * const original,
        char const * const pattern,
        char const * const replacement) {
    size_t const replen = strlen(replacement);
    size_t const patlen = strlen(pattern);
    size_t const orilen = strlen(original);

    size_t patcnt = 0;
    const char * oriptr;
    const char * patloc;

    // find how many times the pattern occurs in the original string
    for (oriptr = original; patloc = strstr(oriptr, pattern); oriptr = patloc + patlen) {
        patcnt++;
    }

    {
        // allocate memory for the new string
        size_t const retlen = orilen + patcnt * (replen - patlen);
        char * const returned = (char *) malloc( sizeof(char) * (retlen + 1) );

        if (returned != NULL) {
            // copy the original string,
            // replacing all the instances of the pattern
            char * retptr = returned;
            for (oriptr = original; patloc = strstr(oriptr, pattern); oriptr = patloc + patlen) {
                size_t const skplen = patloc - oriptr;
                // copy the section until the occurence of the pattern
                strncpy(retptr, oriptr, skplen);
                retptr += skplen;
                // copy the replacement
                strncpy(retptr, replacement, replen);
                retptr += replen;
            }
            // copy the rest of the string.
            strcpy(retptr, oriptr);
        }
        return returned;
    }
}
*/

int main(void) {
    char n[] = "joao augusto de moura";
    char p = 'o';
    char r[] = "N";
    printf("replace %s \n", replace( n, p, r ));
}
