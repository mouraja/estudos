#!/usr/bin/env php

<?php

class Utils {

	public $STATE_OK = 0;
	public $STATE_WARNING = 1;
	public $STATE_CRITICAL = 2;
	public $STATE_UNKNOWN = 3;
	public $STATE_DEPENDENT = 4;

	public $STATE_FAIL = FALSE;
	public $STATE_SUCCESS = TRUE;

	public $VAZIO = '';
	public $ESPACO = ' ';
	public $VIRGULA = ',';
	public $DOIS_PONTOS = ':';
	public $PONTO = '.';
	public $PONTO_VIRGULA = ';';

	public $ZERO = 0;

	public $ON = TRUE;
	public $OFF = FALSE;
	
    private function print_support() {
    	echo "João Augusto de Moura <joao.augusto@sicoob.com.br>";
    }
    
	public function esta_vazia($__arg, $__modo = TRUE) {
		if (is__null ( $__arg )) {
			if ($__modo) {
				echo "FALHA: Variavel sem conteúdo.";
			}
			return $STATE_FAIL;
		}
		return $STATE_SUCCESS;
	}

	public function remove_caracter($__arg) {
		$__padrao =  "[\D]";
		return preg_replace($__padrao, $VAZIO, $__arg );
	}

}

?>
