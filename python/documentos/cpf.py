import re
import utils
import calculos

__cpf_size=11

def usage():
    print('''

    Sintaxe: cpf.valida(<cpf>)

    Onde:
        cpf : Deve ser informado um valor no padrão CPF com
              11 caracteres númericos, podendo conter
              sinais separadores comuns aos CPF's.

    Exemplos: 
        cpf.valida(758.232.954-93)
        cpf.valida(75823295493)

''')

def valida_caracteres(__cpf):
    __regex = re.compile('[^\d\-.]') 
    return( __regex.match(__cpf) == utils.__nulo )

def valida_tamanho(__cpf):
    return( len(__cpf) == __cpf_size )

def checa_repeticao(__cpf):
    __regex = re.compile('[' + str(__cpf[0]) + ']{' + str(__cpf_size)  + '}')
    return( __regex.match(__cpf) == utils.__nulo )

def valida_digitos(__cpf):
    __digitos = [9,10]
    for __i in __digitos:
        __digito = calculos.modulo11(__cpf[:__i],9,0)
        if (int(__cpf[__i]) != __digito):
            return(utils.__falha)
    return(utils.__sucesso)

def valida(__cpf):
    if utils.esta_vazio(__cpf):
        return(utils.__falha)
    if not valida_caracteres(__cpf):
        return(utils.__falha)
    __cpf = utils.pega_digitos(__cpf)
    if not valida_tamanho(__cpf):
        return(utils.__falha)
    if not checa_repeticao(__cpf):
        return(utils.__falha)
    if not valida_digitos(__cpf):
        return(utils.__falha)
    return(utils.__sucesso)

def formata(__cpf):
    __cpf = utils.pega_digitos(__cpf)
    __regex = r"(\d{3})(\d{3})(\d{3})(\d{2})"
    __formato = r"\1.\2.\3-\4"
    return( re.compile(__regex).match(__cpf).expand(__formato) )
