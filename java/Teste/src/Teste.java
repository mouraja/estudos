//import java.util.regex.Matcher;
//import java.util.regex.Pattern;

import calculos.Calculos;
import utils.Utils;
import documentos.Cnpj;
import documentos.Cpf;

public class Teste {

	public static void main(String[] args) {
		
		// TODO Auto-generated method stub
		Teste t = new Teste();

		//261533-4
		t.modulo10("261533");
		
		//261533-9
		t.modulo11("261533");
		
		//372.828908-12
		t.cpf("372.828908-12");

		//01.647322/0001-23
		t.cnpj("01.647322/0001-23");
		
	}
	
	private void modulo10(String valor) {
		String msg = "Calculo modulo10 para %s é igual a %d.\n";
		System.out.printf(msg, valor, Calculos.modulo10(valor));
	}
	
	private void modulo11(String valor) {
		String msg = "Calculo modulo11 para %s é igual a %d.\n";
		System.out.printf(msg, valor, Calculos.modulo11(valor, 2, 9));
	}
	
	private void cpf(String valor) {
		String msg;
		if ( Cpf.valida(valor) ) {
			msg = "CPF %s é válido.\n";
			System.out.printf(msg, Cpf.formata(valor));
		} else {
			System.err.printf("CPF %s é inválido.\n", valor);
		}
	}
	
	private void cnpj(String valor) {
		String msg;
		if ( Cnpj.valida(valor) ) {
			msg = "CNPJ %s é válido.\n";
			System.out.printf(msg, Cnpj.formata(valor));
		} else {
			System.err.printf("CNPJ %s é inválido.\n", valor);
		}
	}

}
