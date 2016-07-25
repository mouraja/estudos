import re

__nulo=None
__vazio=''
__espaco=' '
__zero=0

__falha=False
__sucesso=True

def pega_digitos(__string):
    __aux=''
    for __i in re.findall('\d+', __string):
        __aux+=__i
    return(__aux)

def esta_nulo(__string):
    return(__string == __nulo)

def esta_vazio(__string):
    if esta_nulo(__string):
        return(True)
    return(__string == __vazio or len(__string.strip()) == __zero)
