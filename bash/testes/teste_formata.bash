#!/bin/bash

. ./f_formata_ldif_to_lista.bash;

f_formata_ldif_to_lista -f "$1" -c "$2" -d "$3";
