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

declare ____F_FORMATA_CNPJ____="loaded";

## Impressao f_formata_cnpj
## Sintaxe: f_formata_cnpj <cnpj>
## Retorno: String "Imprime CNPJ no padrão '##.###.###/####-##'";
function f_formata_cnpj() { 
    esta_vazia ${1} || return ${STATE_FAIL};
    remove_caracter ${1} | ${SED} -e 's!\.!!g;s!\(.\)!\1.!2;s!\(.\)!\1.!6;s!\(.\)!\1/!10;s!\(.\)!\1\-!15';
}

#f_formata_cnpj $@
