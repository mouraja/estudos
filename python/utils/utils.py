# -*- coding: utf-8 -*-

import re
import os
import string

__nulo=None
__vazio=''
__espaco=' '
__zero=0
__virgula=','
__dois_pontos=':'
__ponto='.'
__ponto_e_virgula=';'
__cerquilha='#'
__arroba='@'
__barra='/'
__pipe='|'

__regex_contem_numeros='\d+'
__regex_linha_vazia='^$'
__regex_linha_comentada='^#'
__regex_linha_inicia_sem_espaco='^\S'
__regex_linha_nao_inicia_com_letras='^\W'

__falha=False
__sucesso=True

__on=1
__off=0

def remove_carriage_return(__string):
    return string.replace(__string, '\n', __vazio)

def remove_new_line(__string):
    return string.replace(__result, '\r', __vazio)

def remove_enter(__string):
    __result = remove_carriage_return(__string)
    __result = remove_carriage_return(__result)
    return __result

def pega_digitos(__string):
    __aux=''
    for __i in re.findall(__regex_contem_numeros, __string):
        __aux+=__i
    return(__aux)

def esta_nulo(__string):
    return(__string == __nulo)

def esta_vazio(__string):
    if esta_nulo(__string):
        return(__sucesso)
    return(__string == __vazio or len(__string.strip()) == __zero)

def existe_arquivo(__arquivo):
    if esta_vazio(__arquivo):
        return(__falha)
    if not os.path.isfile(__arquivo):
        print "FALHA: Arquivo ", __arquivo, " não encontrado."
        return(__falha)
    return(__sucesso)

def existe_programa(__programa):
    if not existe_arquivo(__programa):
        return(__falha)
    if not os.access(__programa, os.X_OK):
         print "FALHA: Arquivo ", __programa, " sem permissão de execução."
         return(__falha)
    return(__sucesso)

def combina(__padrao, __string):
    __combinado=re.match(__padrao, __string)
    return (not esta_nulo(__combinado))
