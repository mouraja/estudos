/*
 * calculos.c
 *
 *  Created on: Aug 6, 2016
 *      Author: mouraja
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../../utils/src/utils.h"
#include "calculos.h"

/*
int modulo11(char* base, int fator_inicial, int fator_final) {
   return modulo11(base, fator_inicial, fator_final, ON);
}
*/

int modulo11(char * base, int fator_inicial, int fator_final, int modo) {
   const int MODULO = MODULO11;
   int passo = 1;
   int somatoria = 0;
   int fator;
   int dv, i;
   char * temp;
   char c;
   if (fator_inicial > fator_final) { passo = -1; }
   fator = fator_inicial;
   temp = base + strlen(base) - 1;
   //printf("len(*temp)=%i base=%s enderco=%i \n", (int)strlen(temp), temp, *temp);
   for (; base <= temp; temp--) {
	  c = temp[0];
	  //printf("%i) multiplica *temp(%i) x fator(%i) = %i\n", i, atoi(&c), fator, atoi(&c) * fator);
      somatoria += ( atoi(&c) * fator );
      //printf("Somatoria = %i\n", somatoria);
      //printf("\t\t# fator_final=%i fator=%i fator_inicial=%i \n", fator_final, fator, fator_inicial);
      if (fator == fator_final) {
    	 //printf("reiniciei fator %i \n", fator);
         fator = fator_inicial;
      } else {
    	 //printf("incrementei fator %i \n", fator);
         fator += passo;
      }
   }
   if ( modo == ON ) {
	  //printf("DV = %i - ( %i %% %i)\n", MODULO, somatoria, MODULO);
	  //printf("DV = %i\n", MODULO - ( somatoria % MODULO ));
      dv = MODULO - ( somatoria % MODULO );
   } else {
	  //printf("DV = ( %i %% %i)\n", somatoria, MODULO);
	  //printf("DV = %i\n", ( somatoria % MODULO ));
      dv = somatoria % MODULO;
   }
   if (dv > 9) {
	   //printf("dv > 9 entao dv = 0");
	   dv = 0;
   }
   return (int)dv;
}

int modulo10(char* base) {
   const int MODULO = MODULO10;
   int somatoria;
   int produto;
   int fator = 2;
   int dv;
   char c;
   char * temp;
   temp = base + strlen(base) - 1;
   for (; base <= temp; temp--) {
	  c = temp[0];
      produto = ( atoi(&c) * fator );
      if (produto > 9) { produto -= 9; }
      somatoria += produto;
      (fator == 1) ? fator++ : fator--;
   }
   dv = MODULO - ( somatoria % MODULO );
   if (dv > 9) { dv = 0; }
   return dv;
}

/**
 * funcao para fins de teste
*/
/*
int main(void) {
	char entrada[20];
	char * testeCalculos;
	int opcao;
	char *menu[2]={"modulo11","modulo10"};
	int res;
	printf("Digite:\n");
	printf("\t0 - Para testar modulo11;\n");
	printf("\t1 - Para testar modulo10;\n");
    scanf("%d", &opcao);
	printf("Digite um valor para teste %s: ", menu[opcao]);
	scanf("%s", entrada);
	testeCalculos = entrada;
	//printf("%s \n", testeCalculos);
	if (opcao == 0) {
	    res = modulo11(testeCalculos, 2, 11, ON);
	} else {
		res = modulo10(testeCalculos);
	}
	printf("%s de %s eh %i \n", menu[opcao], testeCalculos, res);
	return 0;
}
*/
