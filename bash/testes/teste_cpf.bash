#!/bin/bash
. ./f_valida_cpf.bash;
. ./f_formata_cpf.bash;

f_valida_cpf $1;
[[ $? -eq 0 ]] && echo "valido" || echo "nao valido";
f_formata_cpf $1;
