#!/usr/bin/env lua

____UTILS____ = "loaded";

local ____autor = "João Augusto de Moura";
local ____versao = "1.0.0";
local ____email = "mouraja@gmail.com";

utils = {};

utils.STATE_OK = 0;
utils.STATE_WARNING = 1;
utils.STATE_CRITICAL = 2;
utils.STATE_UNKNOWN = 3;
utils.STATE_DEPENDENT = 4;

utils.STATE_FAIL = false;
utils.STATE_SUCCESS = true;

utils.VAZIO = '';
utils.ESPACO = ' ';
utils.VIRGULA = ',';
utils.DOIS_PONTOS = ':';
utils.PONTO = '.';
utils.PONTO_VIRGULA = ';';

utils.ZERO = 0;

utils.ON = 1;
utils.OFF = 0;

function utils.print_support()
    print( ____autor.." <"..__email..">" );
end

function utils.esta_vazia(__parametro, __msg)
    __msg =  __msg or true;
    if type(__parametro) == "nil" then
        if __msg then
            print("FALHA: Variável não definida.");
        end
        return utils.STATE_SUCCESS;
    end
    if type(__parametro) == "string" and __parametro == VAZIO then
        if __msg then
            print("FALHA: Variável sem conteúdo.");
        end
        return utils.STATE_SUCCESS;
    end
    return utils.STATE_FAIL;
end

function utils.existe_arquivo(__parametro, __msg)
    __msg =  __msg or true;
    if utils.esta_vazia(__parametro,__msg) then
        return utils.STATE_FAIL;
    end
    local __arquivo = io.open(__parametro, 'r');
    if __arquivo == nil then
        if __msg then
            print( "FALHA: Arquivo "..__arquivo.." não encontrado." );
        end
        return utils.STATE_FAIL;
    end
    return utils.STATE_SUCCESS;
end

function utils.remove_caracter(__parametro)
    if utils.esta_vazia(__parametro, false) then
        return utils.STATE_FAIL;
    end
    -- pega somente os digitos
    return __parametro:gsub("[^%d]", utils.VAZIO);
end

return utils;
