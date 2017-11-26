#!/usr/bin/env php

<?php

require_once "../Utils/calculos.php";

require_once "../Utils/utils.php";

class ValidaCnpj {

	private $__utis = new Utils();
	
	private $__calc = new Calculos();
	
	private $__CNPJ_TAMANHO = 14;

	private function print_usage() {
    	echo <<< EOF

    Sintaxe: cnpj.valida(<cnpj>)

    Onde:
        cnpj : Deve ser informado um valor no padrão cnpj com
              14 caracteres númericos, podendo conter
              sinais separadores comuns aos cnpj''s.

    Exemplos:
        valida_cnpj("12.758.232/0004-54")
        valida_cnpj("32598255000298")

EOF;
	}
    
	private function valida_caracter($__cnpj) {
		return (preg_match("/[^\d.\/-]/", $__cnpj) == 0);
	}

	private function valida_tamanho($__cnpj) {
		return ( strlen($__cnpj) == $__CNPJ_TAMANHO );
	}

	private function tem_repeticao($__cnpj) {
		$__padrao = "/[".substr($__cnpj,0,1)."]{".$__CNPJ_TAMANHO."}/";
		return ( preg_match($__padrao, $__cnpj) == 1);
	}

	private function valida_digitos($__cnpj) {
		foreach (array(12,13) as $__i) {
			$__base = substr($__cnpj, 0, $__i);
			$__dc = $__calc->modulo11($__base, 9, 2, FALSE);
			$__dv = substr($__base, $__i, 1);
			if ($__dv != $__dc) {
				return $STATE_FAIL;
			}
		}
		return $STATE_SUCCESS;
	}

	public function valida($__cnpj) {
		if ($__utils->esta_vazia($__cnpj, FALSE)) {
			return $STATE_FAIL;
		}
		if (! valida_caracter($__cnpj)) {
			return $STATE_FAIL;
		}
		$__cnpj = $__utils->remove_caracter($__cnpj);
		if (! valida_tamanho($__cnpj)) {
			return $STATE_FAIL;
		}
		if (tem_repeticao($__cnpj)) {
			return $STATE_FAIL;
		}
		if (valida_digitos($__cpf)) {
			return $STATE_FAIL;
		}
		return $STATE_SUCCESS;
	}

}

?>
