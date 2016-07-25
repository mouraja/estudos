function f_converte_to_iso8859-1() {
    iconv --to-code=ISO-8859-1 --from-code=UTF-8 $1;
}
