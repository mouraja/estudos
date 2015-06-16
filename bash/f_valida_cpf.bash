function f_valida_cpf() {

	MAX=11;
	ERRO_MSG_SAIDA="/dev/null";
	ERRO_CARACTER=1;
	ERRO_TAMANHO=2;
	ERRO_FRAUDE=3;
	ERRO_DIGITO=4;
	OK=0;
	CPF="$1";

	function usage() {
		cat << AJUDA

	Sintaxe: $0 <cpf>;

	Onde:
		cpf : Deve ser informado um valor no padrão CPF com
			14 caracteres númericos, podendo conter
			sinais separadores comuns aos CPF's.

	Exemplos: 
		$0 758.232.954-93;
		$0 75823295493;

AJUDA
		exit -1;
	}

	function f_valida_cpf_caracter() {
		[[ "$(egrep -i [a-z] <<< $CPF 2>$ERRO_MSG_SAIDA)" ]] && return $ERRO_CARACTER;
		return $OK;
	}

	function f_valida_cpf_tamanho() {
		[[ "${#CPF}" -ne "$MAX" ]] && return $ERRO_TAMANHO;
		return $OK;
	}

	function f_valida_cpf_fraude() {
		[[ "$(egrep [${CPF:0:1}]\{$MAX\} <<< $CPF 2>$ERRO_MSG_SAIDA)" ]] && return $ERRO_FRAUDE;
		return $OK;
	}

	function f_valida_cpf_digito() {
		for numero in {8..9}
		do
			PESO=$(($numero+2));
			digito=0;
			multiplo=($(seq $PESO -1 2));
			let soma=0;
			for indice in $(seq 0 $numero)
			do
				let soma+=$((${CPF:$indice:1} * ${multiplo[$indice]}));
			done
			let resto=$(($soma % $MAX));
			[[ $resto -ge 2 ]] && let digito=$(($MAX - $resto));
			[[ "${CPF:$(($numero+1)):1}" -ne "$digito" ]] && return $ERRO_DIGITO;
		done
		return $OK;
	}

	function f_valida_cpf_apenas_digitos() {
		#CPF=$(tr -d -c 0123456789 <<< $CPF;
		CPF="$(tr -d -c [[:digit:]] <<< $CPF 2>$ERRO_MSG_SAIDA)";
		return $OK;
	}

	function main() {
		f_valida_cpf_caracter;
		[[ $? -eq $OK ]] && f_valida_cpf_apenas_digitos;
		[[ $? -eq $OK ]] && f_valida_cpf_tamanho;
		[[ $? -eq $OK ]] && f_valida_cpf_fraude;
		[[ $? -eq $OK ]] && f_valida_cpf_digito;
		return $?;
	}

	[[ $# -ne 1 ]] && usage || main;

}
