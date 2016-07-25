#!/usr/bin/env php

<?php

$____UTILS____ = "loaded";

$STATE_OK=0;
$STATE_WARNING=1;
$STATE_CRITICAL=2;
$STATE_UNKNOWN=3;
$STATE_DEPENDENT=4;

$STATE_FAIL=FALSE;
$STATE_SUCCESS=TRUE;

$VAZIO='';
$ESPACO=' ';
$VIRGULA=',';
$DOIS_PONTOS=':';
$PONTO='.';
$PONTO_VIRGULA=';';

$ZERO=0;

$ON=1;
$OFF=0;

function print_support() {
    echo "João Augusto de Moura <joao.augusto@sicoob.com.br>";
}

function esta_vazia($__arg, $__msg = TRUE) {
    if (is__null($__arg)) {
    	if ( $__msg ) {
            echo "FALHA: Variavel sem conteúdo.";
    	}
        return $STATE_FAIL;
    }
    return $STATE_SUCCESS;
}

function remove_caracter($__arg) {
    return preg_replace("[\D]", $VAZIO, $__arg);
}

?>
