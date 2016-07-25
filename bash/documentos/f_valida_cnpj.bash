#!/usr/bin/env bash

DIRNAME=$(dirname ${0});

if [[ -z ${____F_CALCULOS____} ]];
then
    source ${DIRNAME}/../utils/f_calculos.bash 2>/dev/null;
    if [[ $? -ne 0 ]];
    then
        echo "Erro: Biblioteca 'f_calculos.bash' não foi localizada";
        exit 1;
    fi
fi

declare ____F_VALIDA_CNPJ____="loaded";

function f_valida_cnpj() {

    local __cnpj="${1}";

    local -ri CNPJ_TAMANHO=14;

    local -ri FATOR_INICIAL=9;
    local -ri FATOR_FINAL=2;

    local -ri ERRO_CARACTER=2;
    local -ri ERRO_TAMANHO=3;
    local -ri ERRO_REPETICAO=4;
    local -ri ERRO_DIGITOS=5;

    local -r ERRO_MSG_SAIDA=${NULO};

    function print_usage() {
        ${CAT} <<EOF

    Sintaxe: cnpj.valida <cnpj>

    Onde:
        cnpj: Deve ser informado um valor no padrão CNPJ
              com 14 caracteres númericos, podendo conter
              sinais separadores comuns aos CNPJ's.

    Exemplos: 
        cnpj.valida "12.758.232/0001-93"
        cnpj.valida "12758232000193"

EOF
    }

    function f_valida_padrao() {
        esta_vazia "${__cnpj}" || return ${ERRO_PADRAO};
        local __padrao="[^0-9./-])";
        local __resultado=$( ${ECHO} ${__cnpj} | ${EGREP} ${__padrao} );
        [[ -z ${__resultado} ]] && return ${STATE_FAIL};
        return ${STATE_SUCCESS};
    }

    function f_valida_tamanho() {
        [[ ${#__cnpj} -ne ${CNPJ_TAMANHO} ]] && return ${STATE_FAIL};
        return ${STATE_SUCCESS};
    }

    function f_tem_repeticao() {
        local __padrao="[${__cnpj:0:1}]\{$CNPJ_TAMANHO\}";
        local __resultado=$( ${ECHO} ${__cnpj} | ${EGREP} ${__padrao} );
        [[ -n ${__resultado} ]] && return ${STATE_SUCCESS};
        return ${STATE_FAIL};
    }

    function f_valida_digitos() {
        local -i __digito;
        for __i in {12,13};
        do
            __digito=$( modulo11 ${__cnpj:0:__i} ${FATOR_INICIAL} ${FATOR_FINAL} ${OFF} );
            [[ ${__digito} -ne ${__cnpj:__i:1} ]] && return ${STATE_FAIL};
        done
        return ${STATE_SUCCESS};
    }

    function main() {
        f_valida_padrao;
        [[ ${?} -ne ${STATE_SUCCESS} ]] && return ${ERRO_PADRAO};
        __cnpj="$(remove_caracter ${__cnpj})";
        f_valida_tamanho;
        [[ ${?} -ne ${STATE_SUCCESS} ]] && return ${ERRO_TAMANHO};
        f_tem_repeticao;
        [[ ${?} -ne ${STATE_FAIL} ]] && return ${ERRO_REPETICAO};
        f_valida_digitos;
        [[ ${?} -ne ${STATE_SUCCESS} ]] && return ${ERRO_DIGITOS};
        return ${STATE_SUCCESS};
    }

    [[ "${__cnpj}" == "-h" ]] && print_usage && return ${STATE_FAIL};

    main;

}

f_valida_cnpj $@
