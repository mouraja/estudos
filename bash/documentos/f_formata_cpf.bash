#!/usr/bin/env bash

if [[ -z ${____F_UTILS____} ]];
then
    source ../utils/f_utils.bash 2>/dev/null;
    if [[ ${?} -ne 0 ]]; 
    then
        echo "ERRO: Biblioteca 'f_utils.bash' não localizado";
        exit 1001;
    fi
fi

declare ____F_FORMATA_CPF____="loaded";

## Impressao f_formata_cpf
## Sintaxe: f_formata_cpf <cpf>
## Retorno: String "Imprime CPF no padrao '###.###.###-##'
function f_formata_cpf() { 
    esta_vazia ${1} || return ${STATE_FAIL};
    remove_caracter ${1} | ${SED} -e 's!\.!!g;s!\(...\)!\1.!1;s!\(.\)!\1.!7;s!\(.\)!\1\-!11;s!\(.\)!\1-!15';
}

#f_formata_cpf $@;
