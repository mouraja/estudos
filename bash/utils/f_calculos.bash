#!/usr/bin/env bash

DIRNAME=$(dirname ${0});

# necessita "source ./utils.bash"
if [[ -z ${____F_UTILS____} ]];
then
    source ${DIRNAME}/../utils/f_utils.bash 2>/dev/null;
    if [[ $? -ne 0 ]];
    then
        echo "ERRO: Biblioteca 'f_utils.bash' não localizado.";
        exit 1001;
    fi
fi

declare ____F_CALCULOS____="loaded";

## Calculo modulo11
## Sintaxe modulo11 <valor> <fator inicial> <fator final>
## Retorno: integer "Digito calculado"
function modulo11() {

    [[ ${#} -ne 3 ]] && return ${STATE_FAIL};
    #echo $@
    local -r __base=${1};
    local -ri __fator_inicial=${2};
    local -ri __fator_final=${3};
    local -ri __modo=${4:-$ON};

    local -ri __modulo=11;

    local -a __fatores;
    local -i __digito;
    local -i __resto;
    local -i __passo=1;
    local -i __indice=0;
    local -i __somatoria=0;

    [[ ${__fator_inicial} -gt ${__fator_final} ]] && __passo=-1;

    __fatores=($( ${SEQ} ${__fator_inicial} ${__passo} ${__fator_final} ));

    for (( __i=${#__base} - 1; __i >= 0; __i-- ));
    do
        __digito=${__base:__i:1};
        __somatoria+=$(( __fatores[__indice] * __digito ));
        [[ $(( __indice++ )) -ge $(( ${#__fatores[@]} )) ]] && __indice=0;
    done
    if [[ ${__modo} -eq ${ON} ]];
    then
        __resto=$(( __modulo - (__somatoria % __modulo) ));
    else
        __resto=$(( __somatoria % __modulo ));
    fi
    [[ ${__resto} -gt 9 ]] && __digito=0 || __digito=${__resto};
    ${ECHO} ${__digito};
    return ${STATE_SUCCESS};
}

## Calculo modulo10
## Sintaxe: modulo10 <valor>
## Retorno: integer "Digito calculado"
function modulo10() {
    local -ri __base=${1};

    local -ri __modulo=10;
    local -ri __fator_inicial=2;
    local -ri __fator_final=1;

    local -i __fator=${__fator_inicial};
    local -i __somatoria=0;
    local -i __digito;
    local -i __produto;

    for (( __i=${#__base} - 1; __i >= 0; __i-- ));
    do
        __digito=${__base:${__i}:1};
        __produto=$(( __fator * __digito ));
        [[ ${__produto} -gt 9 ]] && __produto-=9;
        __somatoria+=${__produto};
        if [[ ${__fator} -eq ${__fator_inicial} ]];
        then
            __fator=${__fator_final};
        else
            __fator=${__fator_inicial};
        fi
    done
    __digito=$(( __modulo - (__somatoria % __modulo) ));
    ${ECHO} ${__digito};
    return ${STATE_SUCCESS};
}
