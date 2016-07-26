package utils;

import java.util.regex.Pattern;

public class Utils {

	public static final boolean STATE_FAIL = false;
	public static final boolean STATE_SUCCESS = true;
	public static final String VAZIO = "";
	public static final int ON = 1;
	public static final int OFF = 0;
	
	public static String removeCaracteres(String __arg, String __excluido) {
		return __arg.replaceAll(__excluido, Utils.VAZIO);
	}
	
	public static boolean estaVazia(String __arg) {
		if (__arg == null) { return Utils.STATE_SUCCESS; }
		if (__arg.isEmpty()) { return Utils.STATE_SUCCESS; }
		return Utils.STATE_FAIL;
	}
	
	public static boolean validaPadrao(String __arg, String __padrao) {
		if (! Pattern.compile(__padrao).matcher(__arg).matches()) {
			return Utils.STATE_FAIL;
		}
		return Utils.STATE_SUCCESS;
	}
	
	public static int converteChar2Int(char __char) {
		return Integer.parseInt(String.valueOf(__char));
	}
	
}
