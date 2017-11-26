#!/usr/bin/env python3
# -*- utf-8 -*-

import sys
from monitoracao.nagios.recursos.Servidor import Servidor
from monitoracao.nagios.security import nagiosxi
from monitoracao.nagios.utils import Logs

def ajuda():
    print('''
    Ajuda ansible-joao-nagios-x86.py

    Sintaxe: ./ansible-joao-nagios-x86.py <Servidor> <IP> [Descricao]

    Onde:

        Servidor : É o nome do servidor a ser monitorado.

        IP : É o enderço IP do servidor a ser monitorado.

        Descricao (opcional) : Uma descrição resumida do objetivo do servidor.

    Exemplo:

        ./ansible-joao-nagios-x86.py jbsp999 "127.0.0.9" "Servidor JBoss de teste"

    ''')

if len(sys.argv) not in [3, 4]:
    msg = "ERRO: Quantidade de parâmetros incorretos."
    print(msg + " Use -h para ajuda.")
    Logs.logError(msg)
    sys.exit(1)

if sys.argv[1] in ['-h', '--help']:
    ajuda() 
    sys.exit(1)

host_name = sys.argv[1]
address = sys.argv[2]
if len(sys.argv) == 4:
    display_name = sys.argv[3]
else:
    display_name = host_name

host=Servidor(nagiosxi.nagios, nagiosxi.api)
if host.adicionarLinuxX86(host_name, address, display_name):
    msg = "Servidor " + host_name + " (" + address + ")."
    print(msg)
    Logs.logInfo(msg)
else:
    msg = "ERRO: Falha na inclusão do servidor " + host_name + " (" + address + ")."
    print(msg + " Verifique o syslog.")
    Logs.logError(msg)
    sys.exit(1)