#!/bin/bash

function usage() {
cat <<HELP

sitaxe: $0 [-a <opcao>] [-b <opcao>] [-c <opcao>] [-d] [-e] [-f] [-h];

HELP
exit 1
}
 
while getopts "a:b:c:defh" opt; 
do
  case $opt in
    a) 
	echo "-$opt was triggered, Parameter: $OPTARG" >&2;
	 ;;
    b) 
	echo "-$opt was triggered, Parameter: $OPTARG" >&2;
	 ;;
    c) 
	echo "-$opt was triggered, Parameter: $OPTARG" >&2;
	 ;;
    d) 
	echo "-$opt was triggered, Without Parameter: $OPTARG" >&2;
	 ;;
    e) 
	echo "-$opt was triggered, Without Parameter: $OPTARG" >&2;
	 ;;
    f) 
	echo "-$opt was triggered, Without Parameter: $OPTARG" >&2;
	 ;;
    h)
	usage;
	;;
    \?)
      echo "Invalid option: -$opt" >&2;
      exit 1;
      ;;
    :)
      echo "Option -$opt requires an argument." >&2;
      exit 1;
      ;;
  esac
done
