import re
import utils
import calculos

__cnpj_size=14

def usage():
    print('''

    Sintaxe: cnpj.valida(<cnpj>)

    Onde:
        cpf : Deve ser informado um valor no padrão CNPJ
              com 14 caracteres númericos, podendo conter
              sinais separadores comuns aos CNPJ's.

    Exemplos: 
        cnpj.valida("12.758.232/0001-93")
        cnpj.valida("12758232000193")

''')

def valida_caracteres(__cnpj):
    __regex=re.compile('[^\d\-/.]')
    return(__regex.match(__cnpj) == utils.__nulo)

def valida_tamanho(__cnpj):
    return(len(__cnpj) == __cnpj_size)

def checa_repeticao(__cnpj):
    __regex=re.compile('[' + str(__cnpj[0]) + ']{' + str(__cnpj_size)  + '}')
    return(__regex.match(__cnpj) == utils.__nulo)

def valida_digito(__cnpj):
    __posicoes=[12,13]
    for __j in __posicoes:
        __posicao = __j
        __digitos = __cnpj[0:__posicao]
        __verificador = int(__cnpj[__posicao])
        __soma = 0;
        __indice = __posicao - 7;
        for __i in range(__posicao, 0, -1):
           __soma += (int(__digitos[__posicao - __i]) * __indice)
           __indice = 9 if (__indice <= 2) else (__indice - 1)
        __resto = (__soma % 11)
        __digito = 0 if __resto < 2 else (11 - __resto)
        if (__digito != __verificador):
            return(utils.__falha)
    return(utils.__sucesso)

def valida_digitos(__cnpj):
    __digitos=[12,13]
    for __i in __digitos:
        __digito = calculos.modulo11(__cnpj[:__i],9,2)
        if (__digito != int(__cnpj[__i])):
            return(utils.__falha)
    return(utils.__sucesso)

def valida(__cnpj):
    if utils.esta_vazio(__cnpj):
        return(utils.__falha)
    if not valida_caracteres(__cnpj):
        return(utils.__falha)
    __cnpj = utils.pega_digitos(__cnpj)
    if not valida_tamanho(__cnpj):
        return(utils.__falha)
    if not checa_repeticao(__cnpj):
        return(utils.__falha)
    if not valida_digitos(__cnpj):
        return(utils.__falha)
    return(utils.__sucesso)

def formata(__cnpj):
    __cnpj = utils.pega_digitos(__cnpj)
    __regex = r"(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})"
    __formato = r"\1.\2.\3/\4-\5"
    return( re.compile(__regex).match(__cnpj).expand(__formato) )
