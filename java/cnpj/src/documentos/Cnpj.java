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
public class Cnpj {

	private final int SIZE_CNPJ = 14;
	private String cnpj;
	
	/**
	 * @param __cnpj
	 */
	public Cnpj(String __cnpj) {
		super();
		this.cnpj = __cnpj;
	}
	
	/**
	 * 
	 */
    public Cnpj() {
    }
	
	/**
	 * @return String - the cnpj
	 */
	private String getCnpj() {
		return this.cnpj;
	}

	/**
	 * @param String __cnpj - the cnpj to set
	 */
	private void setCnpj(String __cnpj) {
		this.cnpj = __cnpj;
	}

	/**
	 * 
	 * @return boolean
	 */
	private boolean validaDigitos() {
		int __dc;
		int __dv;
		int[] indices = {12, 13};
		for (int __i : indices) {
		    __dc = Calculos.modulo11(this.getCnpj().substring(0, __i) , 9, 2, false);
		    __dv = Integer.parseInt(this.getCnpj().substring(__i, __i + 1));
		    if (__dc != __dv) {
		    	return Utils.STATE_FAIL;
		    }
		}
		return Utils.STATE_SUCCESS;
	}

	/**
	 * 
	 * @return boolean
	 */
	private boolean estaVazio() {
		return Utils.estaVazia(this.getCnpj());
	}

	/**
	 * 
	 * @return boolean
	 */
	private boolean validaPadrao() {
		return ! Utils.validaPadrao(this.getCnpj(), ".*[^0-9.-].*");
	}

	/**
	 * 
	 */
	private void removeCarateres() {
		this.setCnpj(Utils.removeCaracteres(this.getCnpj(), "[\\D]"));
	}

	/**
	 * 
	 * @return boolean
	 */
	private boolean validaTamanho() {
		return (this.getCnpj().length() == this.SIZE_CNPJ);
	}

	/**
	 * 
	 * @return boolean
	 */
	private boolean temRepeticao() {
		String __regex = "[" + this.getCnpj().substring(0, 1) + "]{" + this.SIZE_CNPJ + "}";
		return (Utils.validaPadrao(this.getCnpj(), __regex));
	}

	/**
	 * 
	 * @return String
	 */
	private String imprime() {
		String __regex = "(\\d{2})(\\d{3})(\\d{3})(\\d{4})(\\d{2})";
		String __formato = "$1.$2.$3/$4-$5";
		this.removeCarateres();
		return(this.getCnpj().replaceFirst(__regex, __formato));	
	}

	/**
	 * 
	 * @param String __cnpj
	 * @return boolean
	 */
	public static boolean valida(String __cnpj) {
		Cnpj cnpj = new Cnpj(__cnpj);
		if (cnpj.estaVazio()) { return Utils.STATE_FAIL; }
		if (! cnpj.validaPadrao()) { return Utils.STATE_FAIL; }
		cnpj.removeCarateres();
		if (! cnpj.validaTamanho()) { return Utils.STATE_FAIL; }
		if (cnpj.temRepeticao()) { return Utils.STATE_FAIL; }
		if (! cnpj.validaDigitos()) { return Utils.STATE_FAIL; }
		return Utils.STATE_SUCCESS;
	}

	/**
	 * 
	 * @param String __cnpj
	 * @return String
	 */
	public static String formata(String __cnpj) {
		Cnpj cnpj = new Cnpj(__cnpj);
		return cnpj.imprime();
	}

}