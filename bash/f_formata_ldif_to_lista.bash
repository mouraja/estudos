#!/usr/bin/env bash

[[ -z "${____UTILS____}" ]] && source ./utils/f_utils.bash;

declare ____F_FORMATA_LDIF_TO_LISTA____="loaded";

function f_formata_ldif_to_lista() {

    local __delimiter;
    local -a __campos;
    local -a __colunas;
    local -i __indice;
    local -i __tem_linha;

    function print_usage() {
        ${CAT} <<EOF
        Sintaxe: ${__program} -h | -f <ldif> -c <campos> [-d <delimitador>]
EOF
    }

    function limpa() {
        for ((__i=0; __i<${#__colunas[@]}; __i++));
        do
            __colunas[${__i}]="";
        done
    }

    function pega_indice() {
        esta_vazia "${1}";
        __indice=-1;
        for ((__i=0; __i < ${#__campos[@]}; __i++));
        do
            [[ "${__campos[${__i}]}" == "${1}" ]] && __indice=${__i} && break;
        done
        ${ECHO} ${__indice};
        return ${__indice};
    }

    function pega_nome() {
        esta_vazia "${1}";
        __nome="$( ${ECHO} """${1}""" | ${CUT} -d ':' -f 1 )";
        ${ECHO} "${__nome}";
    }

    function pega_valor() {
        esta_vazia "${1}";
        __valor="$( ${ECHO} """${1}""" | ${CUT} -d ' ' -f 2- )";
        ${ECHO} "${__valor}";
    }

    function escreve_cabecalho() {
        local __d;
        local __cabecalho="";
        for __c in ${__campos[@]};
        do
            __cabecalho+="${__d}${__c}";
            __d=';';
        done
        ${ECHO} ${__cabecalho};
    }

    function escreve_linha() {
        local __d;
        local __linha="";
        for ((__i=0; __i<${#__colunas[@]}; __i++));
        do
            __linha+="${__d}${__colunas[${__i}]}";
            __d=';';
        done
        ${ECHO} ${__linha};
    }

    function main() {

        existe_arquivo "${__ldif}";
        [[ $? -ne ${STATE_SUCCESS} ]] && exit ${STATE_FAIL};

        esta_vazia "${__fields}";
        [[ $? -ne ${STATE_SUCCESS} ]] && exit ${STATE_FAIL};

        __delimiter="${__delimiter:-','}";
        __campos=(${__fields[@]//${__delimiter}/\ });
        #__campos=($( ${ECHO} "${__fields[@]}" | ${TR} "${__delimiter}" ' ' ));
        __colunas=(${__campos[@]});
        __tem_linha=${OFF};

        escreve_cabecalho;

        while read __linha;
        do
            #linha inicia com #, ler a proxima
            [[ "$( ${ECHO} """${__linha}""" | ${EGREP} '^#' )" ]] && continue;
            [[ ${__tem_linha} -eq ${OFF} ]] && limpa;
            if [[ "$( ${ECHO} """${__linha}""" | ${EGREP} '^\S' )" ]];
            then
                __campo="$(pega_nome """${__linha}""")";
                __indice=$(pega_indice "${__campo}");
                [[ ${__indice} -eq -1 ]] && continue;
                __valor="$(pega_valor """${__linha}""")";
                __colunas[${__indice}]="${__valor}";
                __tem_linha=${ON};
                #echo "titulo"
                continue;
            fi
            if [[ "$( ${ECHO} """${__linha}""" | ${EGREP} '^\W' )" ]];
            then
                __valor="$( pega_valor """${__linha}""" )";
                __colunas=[${__indice}]+="${__valor}";
                #echo "continuacao"
                continue;
            fi
            #echo ${__linha}
            ## linha '^$'
            if [[ -z "${__linha}" ]];
            then
                #echo "retornei"
                [[ ${__tem_linha} -eq ${OFF} ]] && continue;
                escreve_linha;
                __tem_linha=${OFF};
                #echo "linha"
            fi
            #echo "passei"
        done < "${__ldif}";
        [[ ${__tem_linha} -eq 1 ]] && escreve_linha;

        unset __ldif __colunas __fields __delimiter __tem_linha;

    }

    ###
    ##  Ler parâmetros
    while getopts 'hd:f:c:' __parametro;
    do
        case ${__parametro} in
            h)
                print_usage;
                exit ${STATE_FAIL};
                ;;
            d)
                __delimiter="${OPTARG}";
                ;;
            f)
                __ldif="${OPTARG}";
                ;;
            c)
                __fields="${OPTARG}";
                ;;
            \?)
                ${ECHO} "FALHA: Parâmetros inválidos.";
                exit ${STATE_FAIL};
                ;;
        esac
    done

    main;

}
