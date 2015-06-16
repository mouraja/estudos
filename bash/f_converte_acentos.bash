function f_converte_acentos() {
	echo $1 | sed 'y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚüÜñÑçÇ/aAaAaAaAeEeEiIoOoOoOuUuUncC/';
}
