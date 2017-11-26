#!/usr/bin/env python3
# -*- utf-8 -*-
import sys
import argparse
from monitoracao.nagios.security import nagiosxi
from automacao.src.monitoracao.nagios.recursos import Servidor
from monitoracao.nagios.utils import Logs

'''
Created on 25 de fev de 2017

@author: mouraja
'''

params = argparse.ArgumentParser("Inserção de servidores x86 na Monitoração Nagios")

params.add_argument("servidor", required=True, help="Nome do servidor a ser monitorado.")
params.add_argument("endereco", required=True, help="Endereço IP do servidor a ser monitorado.")
params.add_argument("descricao", required=False, default="%(servidor)", help="Descrição resumida do servidor a ser monitorado.")

host_name = params.parse_args("servidor")
address = params.parse_args("endereco")
display_name = params.parse_args("descricao")

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