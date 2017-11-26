/*
 * utils.h
 *
 *  Created on: Aug 6, 2016
 *      Author: mouraja
 */

#ifndef UTILS_H_
#define UTILS_H_

#define STATE_SUCCESS 1
#define STATE_FAIL 0
#define OFF 0
#define ON 1
#define MAIUSCULAS "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define MINUSCULAS "abcdefghijklmnopqrstuvwxyz"

void remove_caracter( char * base, char * args );

char * replace( char * s, char ch, const char * repl );

/*
char * str_replace(
    char const * const original,
    char const * const pattern,
    char const * const replacement
);
*/

void substring( char *dst, char * base, int posicao, int comprimento );

int valida_padrao( char * base, char * padrao );

int tem_repeticao(char * base, char filtro, int qtde);

int isnull(char * base);

#endif /* UTILS_H_ */
