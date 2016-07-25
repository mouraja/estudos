#!/usr/bin/env lua

--local utils, calculos;

if type(calculos) == "nil" then
    --calculos = require "calculos";
    local calculos = require "calculos";
    if type(calculos) == "nil" then
        print("Falha na carga do módulo calculos");
        return utils.STATE_FAIL;
    end
end

if type(utils) == "nil" then
    --utils = require "utils";
    local utils = require "utils";
    if type(utils) == "nil" then
        print("Falha na carga do módulo utils");
        return utils.STATE_FAIL;
    end
end

--print(type(calculos)..type(utils));

____VALIDA_CNPJ____ = "loaded";

local CNPJ_TAMANHO = 14;
local ERRO_CARACTER = 1;
local ERRO_TAMANHO=  2;
local ERRO_REPETICAO = 3;
local ERRO_DIGITO = 4;
local ERRO_MSG_SAIDA = "";

valida_cnpj = {};

valida_cnpj.CODIGO_SAIDA = 0;

function valida_cnpj.print_usage()
    local __usage = [[

    Sintaxe: 
        valida_cnpj(<cnpj>);

    Onde:
        cnpj : Deve ser informado um valor no padrão CNPJ com
            14 caracteres númericos, podendo conter
            sinais separadores comuns aos CNPJ\'s.

    Exemplos: 
        valida_cnpj('58.232.954/0001-93');
        valida_cnpj('75823295000193');

    ]];
    print(__usage);
end

local function valida_caracteres(__cnpj)
    if __cnpj:match("%a+") ~= nil then
        valida_cnpj.CODIGO_SAIDA = ERRO_CARACTER;
        return utils.STATE_FAIL;
    end
    return utils.STATE_SUCCESS;
end

local function verifica_tamanho(__cnpj)
    if #__cnpj ~= CNPJ_TAMANHO then
        valida_cnpj.CODIGO_SAIDA = ERRO_TAMANHO;
        return utils.STATE_FAIL;
    end
    return utils.STATE_SUCCESS;
end

local function tem_repeticao(__cnpj)
    if __cnpj == __cnpj:sub(1,1):rep(CNPJ_TAMANHO) then
        valida_cnpj.CODIGO_SAIDA = ERRO_REPETICAO;
        return utils.STATE_SUCCESS;
    end
    return utils.STATE_FAIL;
end

local function valida_digito(__cnpj)
    local __base;
    local __digito_calculado;
    local __digito_verificador;
    for __i=12, 13 do
        __base = __cnpj:sub(0,__i);
        __digito_verificador = tonumber(__cnpj:sub(__i+1,__i+1));
        __digito_calculado = calculos.modulo11(__base, 9, 2, false);
        if __digito_verificador ~= __digito_calculado then
            valida_cnpj.CODIGO_SAIDA = ERRO_DIGITO;
            return utils.STATE_FAIL;
        end
    end
    return utils.STATE_SUCCESS;
end

function valida_cnpj.valida_cnpj(__cnpj)
    if utils.esta_vazia(__cnpj, false) then
        return utils.STATE_FAIL;
    end
    if not valida_caracteres(__cnpj) then
        return utils.STATE_FAIL;
    end    
    __cnpj = utils.remove_caracter(__cnpj);
    if not verifica_tamanho(__cnpj) then
        return utils.STATE_FAIL;
    end
    if tem_repeticao(__cnpj) then
        return utils.STATE_FAIL;
    end
    if not valida_digito(__cnpj) then
        return utils.STATE_FAIL;
    end
    return utils.STATE_SUCCESS;
end

function valida_cnpj.formata(__cnpj)
    a,b,c,d,e = string.match(utils.remove_caracter(__cnpj), "(%d%d)(%d%d%d)(%d%d%d)(%d%d%d%d)(%d%d)");
    print(a.."."..b.."."..c.."/"..d.."-"..e);
end

return valida_cnpj;
