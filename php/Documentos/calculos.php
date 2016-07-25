#!/usr/bin/env php

<?php

# necessita "source ./utils.bash"

if ( $____UTILS____ ) {
    include "utils.php";
}

$____CALCULOS____="loaded";

function modulo11($__base, $__fator_inicial, $__fator_final, $__modo = true) {

    if (strlen($__base) == 0) return $STATE_FAIL;
    if (strlen($__base) == 0) return $STATE_FAIL;
    if (strlen($__base) == 0) return $STATE_FAIL;

    $__modulo = 11;
    $__incrementa = 1;
    $__decrementa = -1;

    $__fatores;
    $__digito;
    $__resto;
    $__termo;
    $__indice = 0;
    $__somatoria = 0;

    if ($__fator_inicial < $__fator_final) {
        $__passo = $__incrementa;
    } else {
        $__passo = $__decrementa;
    }
    $__fatores = range( $__fator_inicial, $__fator_final, $__passo );

    for ( $__i = (strlen($__base) - 1); $__i >= 0; $__i-- ) {
        $__digito = $substr($__base, $__i, 1);
        $__somatoria += ($__fatores[$__indice] * $__digito);
        if ( ++$__indice >= count($__fatores) ) {
            $__indice = 0;
        }
    }
    if ( $__modo ) {
        $__digito = $__modulo - ( $__somatoria % $__modulo );
    } else {
        $__digito = ( $__somatoria % $__modulo );
    }
    if ( $__resto > 9 ) {
        $__digito = 0;
    }
    return $__digito;
}

function modulo10($__base) {

    if (strlen($__base) = 0) return $STATE_FAIL;
    $__modulo = 10;
    $__fator_inicial = 2;
    $__fator_final = 1;

    $__fator = $__fator_inicial;
    $__somatoria = 0;
    $__fator;

    for ( $__i = (strlen($__base) - 1); $__i >= 0; $__i-- ) {
        $__digito = substr($__base, $__i, 1);
        $__multiplicacao = ($__fator * $__digito);
        if ( $__multiplicacao > 9 ) {
            $__multiplicacao -= 9;
        }
        $__somatoria += $__multiplicacao;
        if ( --$__fator > $__fator_final ) {
            $__fator = $__fator_inicial;
        }
    }
    $__digito = ( $__modulo - ($__somatoria % $__modulo) );
    return $__digito; 
}

modulo11($argv[0]);

?>
