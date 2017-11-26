/*
 * cnpj.c
 *
 *  Created on: Aug 6, 2016
 *      Author: mouraja
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../../../utils/utils/src/utils.h"
#include "../../../utils/calculos/src/calculos.h"
#include "cnpj.h"

int valida_padrao_cnpj(char * base) {
	if ( ! valida_padrao(base, CARACTERES_CNPJ_VALIDOS) ) {
		return STATE_FAIL;
	}
	return STATE_SUCCESS;
}

int valida_tamanho_cnpj(char * base) {
	if ( strlen(*base) != TAMANHO_CNPJ ) {
		return STATE_FAIL;
	}
	return STATE_SUCCESS;
}

int tem_repeticao_cnpj(char * base) {
	if (tem_repeticao(base, *base, TAMANHO_CNPJ)) {
		return STATE_FAIL;
	}
	return STATE_FAIL;
}

int valida_digitos_cnpj(char * base) {
	int dc, i;
	char temp[14];
	for ( i = 9; i < TAMANHO_CNPJ; i++ ) {
		//base = substring(cnpj, 0, i);
		memcopy(temp, base, i);
		int dv = atoi(cnpj[i]);
		dc = modulo11(temp, 9, 2, OFF);
		if ( dc != dv ) {
			return STATE_FAIL;
		}
	}
	return STATE_SUCCESS;
}

void limpa_cnpj() {
	cnpj = remove_caracter(cnpj, CARACTERES_CNPJ_VALIDOS);
}

int valida_cnpj(char * base) {
	if ( ! valida_padrao_cnpj(base) ) { return STATE_FAIL; }
	limpa_cnpj();
	if ( ! valida_tamanho_cnpj() ) { return STATE_FAIL; }
	if ( tem_repeticao_cnpj() ) { return STATE_FAIL; }
	if ( ! valida_digitos_cnpj() ) { return STATE_FAIL; }
	return STATE_SUCCESS;
}
/*
int main(void) {
    printf("Retorno %i\n", valida_cnpj("01645738002384"));
}
*/
