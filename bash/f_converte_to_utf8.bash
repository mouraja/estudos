function f_converte_to_utf8() { 
	iconv --from-code=ISO-8859-1 --to-code=UTF-8 $1;
}
