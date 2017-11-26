#!/usr/bin/env python
# -*- coding: utf-8 -*-

import documentos.cnpj
import sys

__cnpj = sys.argv[1]

if documentos.cnpj.valida(__cnpj):
    print "É válido"
    print documentos.cnpj.formata(__cnpj)
else:
    print "É inválido"
