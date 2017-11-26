#!/usr/bin/env python3
# -*- utf-8 -*-

import sys
from monitoracao.nagios.recursos.Servidor import Servidor
from monitoracao.nagios.utils import Logs
from monitoracao.nagios.security import nagp105

def ajuda():
    print(
    '''
    
    Ajuda ansible-nagios-delete.py

    Sintaxe: ./ansible-nagios-delete.py <Servidor>

    Onde:

        Servidor : É o nome do servidor a ser removida da monitoração.

    Exemplo:

        ./ansible-nagios-delete.py jbsp999

    ''')

if len(sys.argv) != 2:
    msg = "ERRO: Quantidade de parâmetros incorretos."
    print(msg + " use -h para ajuda")
    sys.exit(1)

if str(sys.argv[1]) in ['-h', '--help']:
    ajuda() 
    sys.exit(1)

host_name = sys.argv[1]

host=Servidor(nagp105.nagios, nagp105.api)

if host.excluir(host_name):
    msg = "Servidor " + host_name + "excluído."
    print(msg)
    Logs.logInfo(msg)
else:
    msg = "ERRO: Falha na exclusão do servidor " + host_name + "."
    print(msg + " Verifique o syslog.")
    Logs.logError(msg)
    sys.exit(1)
