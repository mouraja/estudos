#!/usr/bin/env python3
# -*- utf-8 -*-

import sys
from monitoracao.nagios.recursos.Servidor import Servidor
from monitoracao.nagios.security import nagiosxi
from monitoracao.nagios.utils import Logs

def ajuda():
    print('''
    
    Ajuda ansible-joao-nagios-desabilitar.py

    Sintaxe: ./ansible-joao-nagios-desabilitar.py <Servidor>

    Onde:

        Servidor : É o nome do servidor a ser desabilitado na monitoração.

    Exemplo:

        ./ansible-joao-nagios-desabilitar.py jbsp999

    ''')

if len(sys.argv) != 2:
    msg = "ERRO: Quantidade de parâmetros incorretos."
    print(msg + " Use -h para ajuda")
    Logs.logError(msg)
    sys.exit(1)

if str(sys.argv[1]) in ['-h', '--help']:
    ajuda() 
    sys.exit(1)

host_name = sys.argv[1]

host=Servidor(nagiosxi.nagios, nagiosxi.api)
if host.desabilitar(host_name):
    msg = "Servidor " + host_name + " desabilitado."
    print(msg)
    Logs.logInfo(msg)
else:
    msg = "ERRO: Falha ao desabilitar o servidor." + host_name + ")."
    print(msg + " Verifique o syslog")
    Logs.logError(msg)
    sys.exit(1)