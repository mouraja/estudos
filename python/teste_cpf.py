#!/usr/bin/env python
# -*- coding: utf-8 -*-
import documentos.cpf
import sys

__cpf =  sys.argv[1]

if documentos.cpf.valida(__cpf):
    print "valido"
    print documentos.cpf.formata(__cpf);
else:
    print "nao valido";
