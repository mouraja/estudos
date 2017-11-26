/*
 * testes.c
 *
 *  Created on: Aug 14, 2016
 *      Author: mouraja
 */

#include <stdlib.h>
#include <stdio.h>
#include "../documentos/cnpj/src/cnpj.h"
#include "../documentos/cpf/src/cpf.h"

int main(void) {
	char documento[14] = "5276991000153"; /* correto */
	//char documento[14] = "5276991000159"; /* errado */
	int valido = valida_cnpj(documento);
        printf("Retorno %i\n", valido);
	printf("O cpf %s %seh valido.\n", documento, (valido)?" ":"nao ");
    return 0;
}
