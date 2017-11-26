/*
 * cnpj.h
 *
 *  Created on: Aug 13, 2016
 *      Author: mouraja
 */

#ifndef CNPJ_H_
#define CNPJ_H_

#define TAMANHO_CNPJ 14
#define CARACTERES_CNPJ_VALIDOS "-./0123456789"

char * cnpj;

int valida_padrao_cnpj();
int valida_tamanho_cnpj();
int tem_repeticao_cnpj();
int valida_digitos_cnpj();
void limpa_cnpj();
int valida_cnpj(char* base);

#endif /* CNPJ_H_ */
