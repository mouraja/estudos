#!/usr/bin/env bash

declare ____F_UTILS____="loaded";

declare -ri STATE_OK=0;
declare -ri STATE_WARNING=1;
declare -ri STATE_CRITICAL=2;
declare -ri STATE_UNKNOWN=3;
declare -ri STATE_DEPENDENT=4;

declare -ri STATE_FAIL=-1;
declare -ri STATE_SUCCESS=0;

declare -r VAZIO='';
declare -r ESPACO=' ';
declare -r VIRGULA=',';
declare -r DOIS_PONTOS=':';
declare -r PONTO='.';
declare -r PONTO_VIRGULA=';';

declare -ri ZERO=0;

declare -ri ON=1;
declare -ri OFF=0;

declare -r NULO=/dev/null;

[[ -z ${WHICH} ]] && declare -r WHICH="$(which which 2>/dev/null)";
if [[ -z ${WHICH} ]];
then
    echo "ERRO: Programa 'which' não localizado.";
    exit ${STATE_STATE_FAIL};
fi

function localiza() {
    local __prog="$(${WHICH} ${1} 2>/dev/null)";
    local __saida=${?};
    if [[ -z ${__prog} ]];
    then
        echo "ERRO: Programa '${__prog}' não localizado.";
        exit ${STATE_FAIL};
    fi
    echo "${__prog}";
    return ${__saida};
}

declare -r ECHO=$(localiza 'echo');
declare -r PRINTF=$(localiza 'printf');
declare -r GREP=$(localiza 'grep');
declare -r EGREP=$(localiza 'egrep');
declare -r MV=$(localiza 'mv');
declare -r CP=$(localiza 'cp');
declare -r CAT=$(localiza 'cat');
declare -r AWK=$(localiza 'awk');
declare -r SUDO=$(localiza 'sudo');
declare -r TR=$(localiza 'tr');
declare -r LS=$(localiza 'ls');
declare -r SEQ=$(localiza 'seq');
declare -r SED=$(localiza 'sed');
declare -r FIND=$(localiza 'find');
declare -r CUT=$(localiza 'cut');
declare -r SORT=$(localiza 'sort');
declare -r BASENAME=$(localiza 'basename');
declare -r DIRNAME=$(localiza 'dirname');
declare -r TEE=$(localiza 'tee');
declare -r PS=$(localiza 'ps');
declare -r WC=$(localiza 'wc');
declare -r SERVICE=$(localiza 'service');
declare -r SYSTEMCTL=$(localiza 'systemctl');
declare -r IP=$(localiza 'ip');
declare -r IFCONFIG=$(localiza 'ifconfig');
declare -r ROUTE=$(localiza 'route');
declare -r IOSTAT=$(localiza 'iostat');
declare -r NETSTAT=$(localiza 'netstat');

function print_revision_nrpe() {
    ${CAT} <<EOF

    ${1} (nagios-plugins 1.4.6) ${2}

    The nagios plugins come with ABSOLUTELY NO WARRANTY. You may redistribute
    copies of the plugins under the terms of the GNU General Public License.
    For more information about these matters, see the file named COPYING.

EOF
}

function print_support_nagios() {
    ${ECHO} "João Augusto de Moura <mouraja@gmail.com>";
}

function existe_arquivo() {
    local __aux="${1}";
    esta_vazia "${__aux}";
    [[ $? -ne ${STATE_SUCCESS} ]] && return ${STATE_FAIL};
    [[ ! -f "${__aux}" ]] && ${ECHO} "FALHA: Arquivo ${__aux} não encontrado." && return ${STATE_FAIL};
    return ${STATE_SUCCESS};
}

function existe_programa() {
    local __aux="${1}";
    existe_arquivo "${__aux}";
    [[ $? -ne ${STATE_SUCCESS} ]] && return ${STATE_SUCCESS};
    [[ ! -x "${__aux}" ]] && ${ECHO} "FALHA: Arquivo ${__aux} sem permissão de execução." && return ${STATE_FAIL};
    return ${STATE_SUCCESS};
}

function esta_vazia() {
    [[ -z ${1} ]] && ${ECHO} "FALHA: Variavel sem conteúdo." && return ${STATE_FAIL};
    return ${STATE_SUCCESS};
}

function remove_caracter() {
    local __aux="${1}";
    esta_vazia "${__aux}" > ${NULO};
    [[ $? -ne ${STATE_SUCCESS} ]] && return ${STATE_FAIL};
    # pega somente os digitos
    ${ECHO} "${__aux}" | ${TR} -d -c [[:digit:]];
    return $?;
}


#${ECHO} "Send email to nagios-users@lists.sourceforge.net if you have questions
#regarding use of this software. To submit patches or suggest improvements,
#send email to nagiosplug-devel@lists.sourceforge.net.
#Please include version information with all correspondence (when possible,
#use output from the --version option of the plugin itself).
