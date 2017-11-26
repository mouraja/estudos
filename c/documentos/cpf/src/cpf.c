/*
 * cpf.c
 *
 *  Created on: Aug 6, 2016
 *      Author: mouraja
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../../../utils/utils/src/utils.h"
#include "../../../utils/calculos/src/calculos.h"
#include "cpf.h"

int valida_padrao_cpf(char * base) {
	return valida_padrao( base, CARACTERES_CPF_VALIDOS );
}

int valida_tamanho_cpf(char * base) {
	if ( strlen(base) != TAMANHO_CPF ) {
		return STATE_FAIL;
	}
	return STATE_SUCCESS;
}

int tem_repeticao_cpf(char * base) {
	if (tem_repeticao(base, base[0], TAMANHO_CPF)) {
		return STATE_SUCCESS;
	}
	return STATE_FAIL;
}

int valida_digitos_cpf(char * base) {
	char * temp;
	int dc, i;
	for ( i = 9; i < TAMANHO_CPF; i++ ) {
		memcopy(temp, base, 9);
		int dv = atoi(cpf[i]);
		dc = modulo11( base, 2, 11, ON );
		if ( dc != dv ) {
			return STATE_FAIL;
		}
	}
	return STATE_SUCCESS;
}

void limpa_cpf(char * base)) {
	remove_caracter(cpf, CARACTERES_CPF_VALIDOS);
}

int valida_cpf(char * base) {
	if ( ! valida_padrao_cpf(base) ) { return STATE_FAIL; }
	limpa_cpf(base);
	if ( ! valida_tamanho_cpf(base) ) { return STATE_FAIL; }
	if ( tem_repeticao_cpf(base) ) { return STATE_FAIL; }
	if ( ! valida_digitos_cpf(base) ) { return STATE_FAIL; }
	return STATE_SUCCESS;
}

/**
 * funcao para fins de teste
int main(void) {
	char testeCpf[20];
	scanf("Digite o CPF para teste: ", &testeCpf);
	print("Cpf eh %s", (valida_cpf(testeCpf)))
}
*/
