<?php

require_once '../Documentos/valida_cpf.php';

require_once '../Documentos/valida_cnpj.php';

$cpf = new ValidaCpf();

if ($cpf->valida("03604709839")) {
	echo "CPF OK";
} else {
	echo "CPF Inválido";
}

$cnpj = new ValidaCnpj();

if ($cnpj->valida("34893.983/0001-34")) {
	echo "CNPJ OK";
} else {
	echo "CNPJ Inválido";
}