#!/usr/bin/env lua

-- necessita "source ./utils.lua"

if type(utils) == "nil" then
    local utils = require "utils";
end

____CALCULOS____ = "loaded";

calculos = {};

function calculos.modulo11(__base, __fator_inicial, __fator_final, __modo) 

    if utils.esta_vazia(__base) then
        return utils.STATE_FAIL;
    end
    if utils.esta_vazia(__fator_inicial) then
        return utils.STATE_FAIL;
    end
    if utils.esta_vazia(__fator_final) then
        return utils.STATE_FAIL;
    end
    
    if type(__modo) == 'nil' then
        __modo = __modo or true;
    end

    local __modulo = 11;
    local __incrementa = 1;
    local __decrementa = -1;

    local __fatores = {};
    local __digito = 0;
    local __resto;
    local __passo;
    local __indice = 0;
    local __somatoria = 0;

    if ( __fator_inicial < __fator_final ) then
        __passo = __incrementa;
    else
        __passo = __decrementa;
    end

    for __fator = __fator_inicial, __fator_final, __passo do
         __fatores[__indice] = __fator;
         __indice = __indice + 1;
    end

    __indice = 0;
    for  __i = #__base , 1, -1 do
        __digito = __base:sub( __i, __i );
        __somatoria = __somatoria + ( __fatores[__indice] * __digito );
        --print("Fatores = "..__fatores[__indice].." x "..__digito.." = "..( __fatores[__indice] * __digito ) );
        __indice = __indice + 1;
        if ( __indice >= #__fatores + 1 ) then
            __indice = 0;
        end
    end
    --print("Somatoria = "..__somatoria);
    if __modo then
        __digito = __modulo - (__somatoria % __modulo );
    else
        __digito = (__somatoria % __modulo );
    end
    --print(__digito);
    if ( __digito > 9 ) then
        __digito = 0;
    end
    return __digito;
end

function calculos.modulo10( __base ) 

    if utils.esta_vazia(__base) then
        return utils.STATE_FAIL;
    end

    local __modulo = 10;
    local __fator_inicial = 2;
    local __fator_final = 1;

    local __fator = __fator_inicial;
    local __somatoria = 0;
    local __fator;
    local __digito

    for __i = #__base, 1, -1
    do
        __digito = __base:sub(__i, __i);
        __multiplicacao = ( __fator * __digito );
        if __multiplicacao > 9 then
            __multiplicacao = __multiplicacao - 9;
        end
        __somatoria = __somatoria + __multiplicacao;
        fator = fator - 1;
        if __fator > __fator_final then
            __fator = __fator_inicial;
        end
    end
    __digito = ( __modulo - (__somatoria % __modulo) );
    return __digito; 
end

return calculos;
