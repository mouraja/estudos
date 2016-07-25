#!/usr/bin/env bash

DIRNAME=$(dirname ${0});

if [[ -z ${____F_CALCULOS____} ]];
then
    source ${DIRNAME}/../utils/f_calculos.bash 2>/dev/null;
    if [[ ${?} -ne 0 ]]; 
    then
        echo "ERRO: Biblioteca 'f_calculos.bash' não localizado";
        exit 1001;
    fi
fi

declare ____F_VALIDA_CPF____="loaded";

## Documentos f_valida_cpf
## Sintaxe: f_valida_cpf <valor>
## Retorno: Integer "0 - sucesso; diferente 0 - falha"
function f_valida_cpf() {

    local __cpf="${1}";
    # Quantidades de digitos do cpf
    local -ri CPF_TAMANHO=11;
    # Fatores de multiplicacao dos digitos
    local -ri FATOR_INICIAL=2;
    local -ri FATOR_FINAL=11;
    # Codigos de errros na validacao
    local -ri ERRO_PADRAO=2;
    local -ri ERRO_TAMANHO=3;
    local -ri ERRO_REPETICAO=4;
    local -ri ERRO_DIGITOS=5;
    # Evitar mensages de erro na tela.
    local -r ERRO_MSG_SAIDA=${NULO};

    function f_print_usage() {
        ${CAT}<<EOF

    Sintaxe: 
        valida_cpf(<cpf>);

    Onde:
        cpf : Deve ser informado um valor no padrão CPF com
            11 caracteres númericos, podendo conter
            sinais separadores comuns aos CPF's.

    Exemplos: 
        valida_cpf("758.232.954-93");
        valida_cpf("75823295493");

EOF
    }

    function f_valida_padrao() {
        esta_vazia ${__cpf} || return ${STATE_FAIL};
        local __padrao=$( ${ECHO} ${__cpf} | ${EGREP} [^0-9.-] );
        [[ -z ${__padrao} ]] && return ${STATE_FAIL};
        return ${STATE_SUCCESS};
    }

    function f_valida_tamanho() {
        [[ ${__cpf} != ${CPF_TAMANHO} ]] && return ${STATE_FAIL};
        return ${STATE_SUCCESS};
    }

    function f_tem_repeticao() {
         local __padrao="[${__cpf:0:1}]\{${CPF_TAMANHO})\}";
         local __resultado=$( ${ECHO} ${__cpf} | ${EGREP} ${__padrao} );
         [[ -n ${__resultado} ]] && return ${STATE_SUCCESS};
         return ${STATE_FAIL};
    }

    function f_valida_digitos() {
        for __i in {9,10};
        do
            #echo "cpf = ${__cpf}";
            #echo "__i = ${__i}";
            local __base=${__cpf:0:__i};
            local __digito_verificador=${__cpf:__i:1};
            local __digito_calculado=$( modulo11 ${__base} ${FATOR_INICIAL} ${FATOR_FINAL} );
            [[ ${__digito_verificador} -ne ${__digito_calculado} ]] && return ${STATE_FAIL};
        done
        return ${STATE_SUCCESS};
    }

    function main() {
        f_valida_padrao;
        [[ ${?} -ne ${STATE_SUCCESS} ]] && return ${ERRO_PADRAO};
        __cpf="$(remove_caracter ${__cpf})";
        f_valida_tamanho;
        [[ ${?} -ne ${STATE_SUCCESS} ]] && return ${ERRO_TAMANHO};
        f_tem_repeticao;
        [[ ${?} -ne ${STATE_FAIL} ]] && return ${ERRO_REPETICAO};
        f_valida_digitos;
        [[ ${?} -ne ${STATE_SUCCESS} ]] && return ${ERRO_DIGITOS};
        return ${STATE_SUCCESS};
    }

    [[ "${__cpf}" == "-h" ]] && f_print_usage && return ${STATE_FAIL};

    main;

}

f_valida_cpf $@;
