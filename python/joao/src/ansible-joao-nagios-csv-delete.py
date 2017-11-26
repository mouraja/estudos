#!/usr/bin/env python3
# -*- utf-8 -*-

import sys
from monitoracao.nagios.recursos.ServidorCsv import ServidorCsv
from monitoracao.nagios.security import nagiosxi
from monitoracao.nagios.utils import Logs

def ajuda():
    print('''
    Ajuda ansible-joao-nagios-csv-delete.py

    Sintaxe: ./ansible-joao-nagios-csv-delete.py <Arquivo-CSV>

    Onde:

        Arquiv-CSV : É o nome do arquivo tipo csv.
                     Separador deve ser o ponto-e-virgula.
                     Não deve haver delimitador de string.
                     Não deve ter cabeçalho.
                     Deve conter quatro colunas respectivamente:
                       - Contendo o nome simples do servidoar;
                       - Contendo o endereço IP do servidor;
                       - Contendo a descrição do servidor;
                       - Contendo uma das contantes abaixo:
                         x86     - para servidores Linux x86
                         s390    - para servidores Linux s390
                         windows - para servidores Windows

    Exemplo:

        ./ansible-joao-nagios-csv-delete.py meusservidores.csv

        Onde o conteudo do arquivo meusservidores.csv é:

        serv1;192.168.1.1;Servidor Samba;x86
        serv2;192.168.1.2;Servidor JBoss;s390
        serv3;192.168.1.3;Servidor de Arquivos;windows

    ''')

if len(sys.argv) != 2:
    msg = "ERRO: Quantidade de parâmetros incorretos."
    print(msg + " Use -h para ajuda.")
    Logs.logError(msg)
    sys.exit(1)

if sys.argv[1] in ['-h', '--help']:
    ajuda() 
    sys.exit(1)

arquivo = sys.argv[1]

host = ServidorCsv(nagiosxi.nagios, nagiosxi.api)

qtde = host.excluir(arquivo)
if qtde == 0:
    msg = "AVISO: Nenhum servidor foi excluído."
    print(msg + " Verifique o syslog.")
    Logs.logWarn(msg)
else:
    msg = "Foram excluídos " + str(qtde) + " servidores."
    print(msg)
    Logs.logInfo(msg)