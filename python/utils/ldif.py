# -*- coding: utf-8 -*-

import sys
import re
import getopt

try:
    ____UTILS____
except:
    import utils

____LDIF____ = "loaded"

__separador_ldap=utils.__dois_pontos

def limpa(__colunas):
    __maximo = len(__colunas)
    for __i in range(0, __maximo):
        __colunas[__i] = utils.__vazio

def pega_indice(__chaves, __chave):
    __indice = -1
    if utils.esta_vazio(__chave):
        return __indice
    __maximo = len(__chaves)
    for __i in range(0, __maximo):
        if __chaves[__i] == __chave:
            __indice = __i
            break
    return __indice

def localiza_separador(__string):
    if utils.esta_vazio(__string):
        return -1
    return __string.find(__separador_ldap)
    
def pega_chave(__chave):
    __i = localiza_separador(__chave)
    return __chave[:__i]

def pega_valor(__valor):
    __i = localiza_separador(__valor) + 2
    return __valor[__i:]

def converte_nulo(__valor):
    __resultado = __valor
    if utils.esta_nulo(__valor):
        __resultado = utils.__espaco
    return __resultado

def cria_filtro(__valores):
    __separador = utils.__vazio
    __padrao = '^('
    for __i in range(utils.__zero, len(__valores)):
        __padrao += __separador + __valores[__i]
        __separador = utils.__pipe
    __padrao += ')'
    return __padrao

def lista(__ldif, __fields, __delimiter_input, __delimiter_output):

    def print_lista_usage():
        print "Sintaxe: ldif.lista(<ldif>, <chaves>, [delimitador-entrada, [delimitador-saida]]"

    def escreve_linha(__colunas, __delimitador):
        __separador = utils.__vazio
        __linha = utils.__vazio
        __maximo = len(__colunas)
        for __i in range(utils.__zero, __maximo):
            __linha += __separador + converte_nulo(__colunas[__i])
            __separador = __delimitador
        print __linha

    def escreve_cabecalho(__chaves, __delimitador):
        escreve_linha(__chaves, __delimitador)

    def escreve_coluna(__colunas, __delimitador):
        escreve_linha(__colunas, __delimitador)

    def main(__ldif, __fields, __delimiter_input, __delimiter_output):
        if not utils.existe_arquivo(__ldif):
            sys.exit(utils.__falha)
        if utils.esta_vazio(__fields):
            sys.exit(utils.__falha)
        __chaves = __fields.split(__delimiter_input)
        __colunas = [None] * len(__chaves)
        __tem_linha = utils.__off
        __padrao = cria_filtro(__chaves)
        escreve_cabecalho(__chaves, __delimiter_output)
        with open(__ldif) as __F:
            for __linha in __F:
                __linha = utils.remove_enter(__linha)
                # Pular linhas comentadas
                if utils.combina('^#', __linha):
                    __linha_nova = utils.__off
                    continue
                if __tem_linha == utils.__off:
                    limpa(__colunas)
                #if utils.combina('^\S.*:.*', __linha):
                if utils.combina(__padrao, __linha):
                    __linha_nova = utils.__off
                    __chave = pega_chave(__linha)
                    __indice = pega_indice(__chaves, __chave)
                    if __indice == -1:
                        continue
                    __valor = pega_valor(__linha)
                    __colunas[__indice] = __valor
                    __tem_linha = utils.__on
                    __linha_nova = utils.__on
                    continue
                if utils.combina('^\W', __linha):
                    if __linha_nova == utils.__off:
                        continue
                    #__valor = pega_valor(__linha)
                    __colunas[__indice] += __linha
                    continue
                ## linha '^$'
                if utils.combina('^$',__linha):
                    if __tem_linha == utils.__off:
                        continue
                    escreve_coluna(__colunas, __delimiter_output)
                    __tem_linha = utils.__off
                __linha_nova = utils.__off
            __F.close()
        if __tem_linha == 1:
            escreve_coluna(__colunas, __delimiter_output)
        del __ldif
        del __colunas
        del __fields
        del __delimiter_input
        del __delimiter_output
        del __tem_linha

    ###
    ## Valida parametros da funcao 
    try:
        __ldif
        __fields
    except getopt.getopt.GetoptError:
        print_lista_usage()
        sys.exit(2)
    else:
        if utils.esta_nulo(__delimiter_input):
            __delimiter_input = utils.__virgula
        if utils.esta_nulo(__delimiter_output):
            __delimiter_output = utils.__ponto_e_virgula
        main(__ldif, __fields, __delimiter_input, __delimiter_output)

def xml(__ldif, __fields, __delimiter_input):

    def print_xml_usage():
        print "Sintaxe: ldif.xml(<ldif>,<chaves>,[delimitador-entrada,[delimitador-saida]])"

    def escreve_linha(__colunas, __chaves):
        __separador = utils.__vazio
        __linha = utils.__vazio
        __maximo = len(__colunas)
        __linha='<reg>'
        for __i in range(utils.__zero, __maximo):
            __linha += '<' + __chaves[__i] + '>' + converte_nulo(__colunas[__i]) + '</' + __chaves[__i] + '>'
        __linha+='</reg>'
        print __linha

    def escreve_cabecalho():
        print "<?xml version='1.0' encoding='UTF-8'?>"
        print "<regs>"
        #escreve_linha(__chaves, __delimitador)

    def escreve_rodape():
        print "</regs>"


    def escreve_coluna(__colunas, __chaves):
        escreve_linha(__colunas, __chaves)

    def main(__ldif, __fields, __delimiter_input):
        if not utils.existe_arquivo(__ldif):
            sys.exit(utils.__falha)
        if utils.esta_vazio(__fields):
            sys.exit(utils.__falha)
        __chaves = __fields.split(__delimiter_input)
        __colunas = [None] * len(__chaves)
        __tem_linha = utils.__off
        __padrao = cria_filtro(__chaves)
        escreve_cabecalho()
        with open(__ldif) as __F:
            for __linha in __F:
                __linha = utils.remove_enter(__linha)
                # Pular linhas comentadas
                if utils.combina('^#', __linha):
                    __linha_nova = utils.__off
                    continue
                if __tem_linha == utils.__off:
                    limpa(__colunas)
                #if utils.combina('^\S.*:.*', __linha):
                if utils.combina(__padrao, __linha):
                    __linha_nova = utils.__off
                    __chave = pega_chave(__linha)
                    __indice = pega_indice(__chaves, __chave)
                    if __indice == -1:
                        continue
                    __valor = pega_valor(__linha)
                    __colunas[__indice] = __valor
                    __tem_linha = utils.__on
                    __linha_nova = utils.__on
                    continue
                if utils.combina('^\W', __linha):
                    if __linha_nova == utils.__off:
                        continue
                    #__valor = pega_valor(__linha)
                    __colunas[__indice] += __linha
                    continue
                ## linha '^$'
                if utils.combina('^$',__linha):
                    if __tem_linha == utils.__off:
                        continue
                    escreve_coluna(__colunas, __chaves)
                    __tem_linha = utils.__off
                __linha_nova = utils.__off
            __F.close()
        if __tem_linha == 1:
            escreve_coluna(__colunas, __chaves)
        escreve_rodape()
        del __ldif
        del __colunas
        del __fields
        del __tem_linha

    ###
    ## Valida parametros da funcao 
    try:
        __ldif
        __fields
    except:
        print_xml_usage()
        sys.exit(2)
    else:
        if utils.esta_nulo(__delimiter_input):
            __delimiter_input = utils.__virgula
        main(__ldif, __fields, __delimiter_input)
