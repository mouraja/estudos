#!/usr/bin/env python3
# -*- utf-8 -*-

import sys
from monitoracao.nagios.recursos.Servidor import Servidor
from monitoracao.nagios.security import nagiosxi
from monitoracao.nagios.utils import Logs

def ajuda():
    print('''
    Ajuda ansible-joao-nagios-habilitar.py

    Sintaxe: ./ansible-joao-nagios-habilitar.py <Servidor>

    Onde:

        Servidor : É o nome do servidor a ser monitorado.

    Exemplo:

        ./ansible-joao-nagios-habilitar.py jbsp999

    ''')

if len(sys.argv) != 2:
    msg = "ERRO: Quantidade de parâmetros incorretos."
    print(msg + " Use -h para ajuda.")
    Logs.logError(msg)
    sys.exit(1)

if str(sys.argv[1]) in ['-h', '--help']:
    ajuda() 
    sys.exit(1)

host_name = sys.argv[1]

host=Servidor(nagiosxi.nagios, nagiosxi.api)
if host.habilitar(host_name):
    msg = "Servidor " + host_name + " habilitado."
    print(msg)
    Logs.logInfo(msg)
else:
    msg = "ERRO: Falha ao habilitar o servidor " + host_name + "."
    print(msg + " Verifique o syslog.")
    Logs.logError(msg)
    sys.exit(1)