
import csv
import sys
import os.path

from monitoracao.nagios.recursos.Servidor import Servidor
from monitoracao.nagios.utils import Logs

class ServidorCsv:

    __DELIMITADOR = None
    __QUOTECHAR = None
    __MODO_LEITURA = None
    __servidor = None
    __plataforma = None

    def __init__(self, nagios, api):
        self.__DELIMITADOR = ';'
        self.__MODO_LEITURA = 'r'
        self.__servidor =  Servidor(nagios, api)

    def adicionar(self, arquivo):
        contador = 0
        if not os.path.isfile(arquivo):
            Logs.logError("Arquivo " + arquivo + " não encontrado.")
            return contador
        with open(arquivo, self.__MODO_LEITURA) as csvfile:
            servidores = csv.reader(csvfile, delimiter=self.__DELIMITADOR)
            for servidor in servidores:
                nome = servidor[0].lower()
                endereco = servidor[1]
                descricao = servidor[2]
                if len(servidor) == 4:
                    self.__plataforma = servidor[3].lower()
                if self.__plataforma == 'x86':
                    if self.__servidor.adicionarLinuxX86(nome, endereco, descricao):
                        contador += 1
                elif self.__plataforma == 's390':
                    if self.__servidor.adicionarLinuxS390(nome, endereco, descricao):
                        contador += 1
                elif self.__plataforma == 'windows':
                    if self.__servidor.adicionarWindows(nome, endereco, descricao):
                        contador += 1
                else:
                    Logs.logError("ERRO: Não informado o ambiente/plataforma para o servidor " + nome + "(" + endereco + ").")
        return contador

    def excluir(self, arquivo):
        contador = 0
        if not os.path.isfile(arquivo):
            Logs.logError("ERRO: Arquivo " + arquivo + " não encontrado.")
            return contador
        with open(arquivo, self.__MODO_LEITURA) as csvfile:
            servidores = csv.reader(csvfile, delimiter=self.__DELIMITADOR)
            for servidor in servidores:
                nome = servidor[0].lower()
                if self.__servidor.excluir(nome):
                    contador += 1
        return contador

    def adicionarLinuxX86(self, arquivo):
        self.__plataforma = 'x86'
        return self.adicionar(arquivo)

    def adicionarLinuxS390(self, arquivo):
        self.__plataforma = 's390'
        return self.adicionar(arquivo)

    def adicionarWindows(self, arquivo):
        self.__plataforma = 'windows'
        return self.adicionar(arquivo)
