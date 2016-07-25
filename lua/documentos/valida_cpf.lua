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

____VALIDA_CPF____ = "loaded";

local CPF_TAMANHO = 11;
local ERRO_CARACTER = 1;
local ERRO_TAMANHO=  2;
local ERRO_REPETICAO = 3;
local ERRO_DIGITO = 4;
local ERRO_MSG_SAIDA = "";

valida_cpf = {};

valida_cpf.CODIGO_SAIDA = 0;

function valida_cpf.print_usage()
    local __usage = [[

    Sintaxe: 
        valida_cpf(<cpf>);

    Onde:
        cpf : Deve ser informado um valor no padrão CPF com
            11 caracteres númericos, podendo conter
            sinais separadores comuns aos CPF\'s.

    Exemplos: 
        valida_cpf('758.232.954-93');
        valida_cpf('75823295493');

    ]];
    print(__usage);
end

local function valida_caracteres(__cpf)
    if __cpf:match("%a+") ~= nil then
        valida_cpf.CODIGO_SAIDA = ERRO_CARACTER;
        return utils.STATE_FAIL;
    end
    return utils.STATE_SUCCESS;
end

local function verifica_tamanho(__cpf)
    if #__cpf ~= CPF_TAMANHO then
        valida_cpf.CODIGO_SAIDA = ERRO_TAMANHO;
        return utils.STATE_FAIL;
    end
    return utils.STATE_SUCCESS;
end

local function tem_repeticao(__cpf)
    if __cpf == __cpf:sub(1,1):rep(CPF_TAMANHO) then
        valida_cpf.CODIGO_SAIDA = ERRO_REPETICAO;
        return utils.STATE_SUCCESS;
    end
    return utils.STATE_FAIL;
end

local function valida_digito(__cpf)
    local __base;
    local __digito_calculado;
    local __digito_verificador;
    for __i=9, 10 do
        __base = __cpf:sub(0,__i);
        __digito_verificador = tonumber(__cpf:sub(__i+1,__i+1));
        __digito_calculado = calculos.modulo11(__base, 2, 11);
        if __digito_verificador ~= __digito_calculado then
            valida_cpf.CODIGO_SAIDA = ERRO_DIGITO;
            return utils.STATE_FAIL;
        end
    end
    return utils.STATE_SUCCESS;
end

function valida_cpf.valida_cpf(__cpf)
    if utils.esta_vazia(__cpf, false) then
        return utils.STATE_FAIL;
    end
    if not valida_caracteres(__cpf) then
        return utils.STATE_FAIL;
    end    
    __cpf = utils.remove_caracter(__cpf);
    if not verifica_tamanho(__cpf) then
        return utils.STATE_FAIL;
    end
    if tem_repeticao(__cpf) then
        return utils.STATE_FAIL;
    end
    if not valida_digito(__cpf) then
        return utils.STATE_FAIL;
    end
    return utils.STATE_SUCCESS;
end

function valida_cpf.formata(__cpf)
    a,b,c,d = string.match(utils.remove_caracter(__cpf), "(%d%d%d)(%d%d%d)(%d%d%d)(%d%d)");
    print(a.."."..b.."."..c.."-"..d);
end

return valida_cpf;
