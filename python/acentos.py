def remove(__palavras):
    __in="áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚüÜñÑçÇ"
    __out="aAaAaAaAeEeEiIoOoOoOuUuUnNcC"
    for __i in range(len(__in)):
        print(__in[__i])
        __palavras = __palavras.replace(__in[__i],__out[__i])
    return(__palavras)
