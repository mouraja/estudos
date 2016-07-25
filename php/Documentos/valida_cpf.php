#!/usr/bin/env php

<?php

$__size_cpf = 11;

function print_usage() {
    echo <<< EOF

    Sintaxe: cpf.valida(<cpf>)

    Onde:
        cpf : Deve ser informado um valor no padrão CPF com
              11 caracteres númericos, podendo conter
              sinais separadores comuns aos CPF''s.

    Exemplos:
        valida_cpf("758.232.954-93")
        valida_cpf("75823295493")

EOF;
}
    
function valida_caracter($__cpf) {
	return (preg_match("/[^\d.-]/", $__cpf) == 0);
}

function valida_tamanho($__cpf) {
	return ( strlen($__cpf) == $__CPF_TAMANHO );
}

function tem_repeticao($__cpf) {
	$__padrao = "/[".substr($__cpf,0,1)."]{".$__CPF_TAMANHO."}/";
	return ( preg_match($__padrao, $__cpf) == 1);
}

function valida_digitos($__cpf) {
	foreach (array(9,10) as $__i) {
		$__base = substr($__cpf, 0, $__i);
		$__dc = modulo11($__base, 2, 11);
		$__dv = substr($__base, $__i, 1);
		if ($__dv != $__dc) {
			return $STATE_FAIL;
		}
	}
	return $STATE_SUCCESS;
}

function valida_cpf($__cpf) {
	if (esta_vazia($__cpf, false)) {
		return $STATE_FAIL;
	}
	if (! valida_caracter($__cpf)) {
		return $STATE_FAIL;
	}
	$__cpf = remove_caracter($__cpf);
	if (! valida_tamanho($__cpf)) {
		return $STATE_FAIL;
	}
	if (tem_repeticao($__cpf)) {
		return $STATE_FAIL;
	}
	return $STATE_SUCCESS;
}

?>
