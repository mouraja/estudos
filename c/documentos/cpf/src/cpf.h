/*
 * cpf.h
 *
 *  Created on: Aug 12, 2016
 *      Author: mouraja
 */

#ifndef CPF_H_
#define CPF_H_

#define TAMANHO_CPF 11
#define CARACTERES_CPF_VALIDOS ".-0123456789"

//char * cpf;

int valida_padrao_cpf(char * base);
int valida_tamanho_cpf(char * base);
int tem_repeticao_cpf(char * base);
int valida_digitos_cpf(char * base);
void limpa_cpf(char * base);
int valida_cpf(char* base);

#endif /* CPF_H_ */
