
def modulo11(__base, __fator_inicial, __fator_final):
    __modulo = 11
    __incrementa = 1
    __decrementa = -1
    __termo = __incrementa if (__fator_inicial < __fator_final) else __decrementa
    __fatores = range(__fator_inicial, __fator_final + __termo, __termo)
    __indice = 0
    __somatoria = 0
    for __digito in reversed(str(__base)):
        __somatoria += (__fatores[__indice] * int(__digito))
        __indice = (__indice + 1) if (__indice < len(__fatores) - 1) else 0
    __resto = (__somatoria % __modulo)
    __digito = 0 if (__resto == 10) else __resto
    return(__digito)

def modulo10(__base):
    __modulo = 10
    __fator_inicial = 2
    __fator_final = 1
    __fator = __fator_inicial
    __somatoria = 0
    for __digito in reversed(str(__base)):
        __multiplicacao = (__fator * int(__digito))
        __multiplicacao = __multiplicacao if (__multiplicacao <= 9) else (__multiplicacao - 9)
        __somatoria += (__multiplicacao)
        __fator = __fator_inicial if (__fator <= __fator_final) else (__fator - 1)
    __digito = (__modulo - (__somatoria % __modulo))
    return(__digito)
