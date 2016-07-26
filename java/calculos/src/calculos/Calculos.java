/**
 * 
 */
package calculos;

import java.util.stream.IntStream;

import utils.Utils;
/**
 * @author mouraja
 *
 */
public class Calculos {
	
	public static int modulo11(String __base, int __fator_inicial, int __fator_final) {
	    return Calculos.modulo11(__base, __fator_inicial, __fator_final, true);
	}
	
	public static int modulo11(String __base, int __fator_inicial, int __fator_final, boolean __modo) {
        int __digito;
        int __somatoria = 0;
        final int __modulo = 11;
        char[] __digitos = __base.toCharArray();
        int[] __fatores;
        if (__fator_inicial > __fator_final) {
        	__fatores = IntStream.rangeClosed(__fator_final, __fator_inicial).map(i -> __fator_inicial - (i - __fator_final)).toArray();
	    } else {
        	__fatores = IntStream.rangeClosed(__fator_inicial, __fator_final).toArray();
	    }
        for ( int __i = (__digitos.length - 1), __j = 0; __i >= 0; __i--, __j++ ) {
            if (__j >= __fatores.length ) { __j = 0; }
            //System.out.print(Utils.converteChar2Int(__digitos[__i]));
            //System.out.print(" x ");
            //System.out.print(__fatores[__j]);
            //System.out.print(" = ");
            //System.out.println(Utils.converteChar2Int(__digitos[__i]) * __fatores[__j]);
        	__somatoria += ( Utils.converteChar2Int(__digitos[__i]) * __fatores[__j] );
        }
        //System.out.println(__somatoria);
        if (__modo) {
            __digito = __modulo - (__somatoria % __modulo);
        } else {
        	__digito = (__somatoria % __modulo);
        }
        if (__digito > 9) {__digito = 0;}
        return __digito;
	}

	public static int modulo10(String __base) {
        int __digito;
        int __produto;
        int __somatoria = 0;
        final int __modulo = 10;
        char[] __digitos = __base.toCharArray();
        int[] __fatores = {2,1};
        for ( int __i = (__digitos.length - 1), __j = 0; __i >= 0; __i--, __j++ ) {
            if (__j >= __fatores.length ) { __j = 0; }
            __produto = ( Utils.converteChar2Int(__digitos[__i]) * __fatores[__j]);
            if ( __produto > 9 ) { __produto -= 9; }
        	__somatoria += __produto;
        }
        __digito = __modulo - (__somatoria % __modulo);
        if (__digito > 9) {__digito = 0;}
        return __digito;
	}
}
