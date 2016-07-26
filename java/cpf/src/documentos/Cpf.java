/**
 * 
 */
package documentos;

import utils.Utils;

import calculos.Calculos;

/**
 * @author mouraja
 *
 */
public class Cpf {

	private final int SIZE_CPF = 11;
	private String cpf;
	
	private final String[][] estados = {
		{"RS"}, 
		{"DF", "GO", "MS", "MT", "TO"},
		{"AC", "AM", "AP", "PA", "RO", "RR"},
		{"CE", "MA", "PI"},
		{"AL", "PB", "PE", "RN"},
		{"BA", "SE"},
		{"MG"},
		{"ES", "RJ"},
		{"SP"},
		{"PR", "SC"}};
	
	/**
	 * @param String __cpf
	 */
	public Cpf(String __cpf) {
		super();
		this.cpf = __cpf;
	}
	
	/**
	 * 
	 */
    public Cpf() {
   	
    }

	/**
	 * @return String - the __cpf
	 */
	private String getCpf() {
		return this.cpf;
	}

	/**
	 * @param String __cpf - the cpf to set
	 */
	private void setCpf(String __cpf) {
		this.cpf = __cpf;
	}
	
	private int getEstado() {
		return Integer.parseInt(this.getCpf().substring(8,9));
	}

	/**
	 * 
	 * @return boolean
	 */
	private boolean validaDigitos() {
		int __dc;
		int __dv;
		for (int __i = 9; __i <= 10; __i++) {
			//System.out.println(this.getCpf().substring(0, __i));
		    __dc = Calculos.modulo11(this.getCpf().substring(0, __i) , 2, 11);
		    __dv = Integer.parseInt(this.getCpf().substring(__i, __i + 1));
		    //System.out.println("" + __dc + " = " + __dv );
		    if (__dc != __dv) {
		    	return Utils.STATE_FAIL;
		    }
		}
		return Utils.STATE_SUCCESS;
	}
	
	private boolean estaVazio() {
		return Utils.estaVazia(this.getCpf());
	}
	
	private boolean validaPadrao() {
		return ! Utils.validaPadrao(this.getCpf(), ".*[^0-9.-].*");
	}
	
	private void removeCarateres() {
		this.setCpf(Utils.removeCaracteres(this.getCpf(), "[\\D]"));
	}
	
	private boolean validaTamanho() {
		return (this.getCpf().length() == this.SIZE_CPF);
	}
	
	private boolean temRepeticao() {
		String __regex = "[" + this.getCpf().substring(0, 1) + "]{" + this.SIZE_CPF + "}";
		return (Utils.validaPadrao(this.getCpf(), __regex));
	}
	
	private String imprime() {
		String __regex = "(\\d{3})(\\d{3})(\\d{3})(\\d{2})";
		String __formato = "$1.$2.$3-$4";
		this.removeCarateres();
		return(this.getCpf().replaceFirst(__regex, __formato));	
	}
	
	public static boolean valida(String __cpf) {
		Cpf cpf = new Cpf(__cpf);
		if (cpf.estaVazio()) { return Utils.STATE_FAIL; }
		if (! cpf.validaPadrao()) { return Utils.STATE_FAIL; }
		cpf.removeCarateres();
		if (! cpf.validaTamanho()) { return Utils.STATE_FAIL; }
		if (cpf.temRepeticao()) { return Utils.STATE_FAIL; }
		if (! cpf.validaDigitos()) { return Utils.STATE_FAIL; }
		return Utils.STATE_SUCCESS;
	}
	
	public static String formata(String __cpf) {
		Cpf cpf = new Cpf(__cpf);
		return cpf.imprime();
	}

	public String[] getEstadosArray(String __cpf) {
		Cpf cpf = new Cpf(__cpf);
		return this.estados[this.getEstado()];
	}
	
}
