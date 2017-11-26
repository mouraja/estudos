
import sys
import requests

from monitoracao.nagios.recursos.ServidorUtils import ServidorUtils
from monitoracao.nagios.utils import Utils, Logs

class Servidor:
    __servidor = None
    __util = None
    __objeto = 'host'
    __ambiente = None
    __plataforma = None
    __arquitetura = None
    
    __APIKEY = None

    __TEMPLATE_X86='th-linux-x86'
    __TEMPLATE_S390='th-linux-s390'
    __TEMPLATE_WINDOWS='th-windows'
    __TEMPLATE_DEVICE='td-device'

    def __init__(self, servidor, api):
        self.__servidor = ServidorUtils(servidor)
        self.__APIKEY = api

    def adicionarLinuxX86(self, nomeDns, enderecoIp, descricao=None):
        self.__ambiente='linux'
        self.__plataforma='x86'
        ret = self.adicionar(nomeDns, enderecoIp, descricao, self.__TEMPLATE_X86)
        return ret

    def adicionarLinuxS390(self, nomeDns, enderecoIp, descricao=None):
        self.__ambiente='linux'
        self.__plataforma='s390'
        ret = self.adicionar(nomeDns, enderecoIp, descricao, self.__TEMPLATE_S390)
        return ret

    def adicionarWindows(self, nomeDns, enderecoIp, descricao=None):
        self.__ambiente='windows'
        self.__plataforma=None
        ret = self.adicionar(nomeDns, enderecoIp, descricao, self.__TEMPLATE_WINDOWS)
        return ret

    def adicionar(self, nomeDns, enderecoIp=None, descricao=None, modelo=None):
        comando = None
        resposta = None
        ret = False
        if not Utils.isValidHostName(nomeDns):
            msg = "AVISO: Nome DNS não resolvido."
            Logs.logWarn(msg)
        enderecoReveso = Utils.getAddress(nomeDns)
        if Utils.isNull(enderecoIp):
            enderecoIp = enderecoReveso
            if not enderecoIp:
                msg = "ERRO: Não foi possível recuperar endereço IP do servidor " + nomeDns + "."
                Logs.logError(msg)
                return ret
        else:
            if enderecoIp != enderecoReveso:
                msg = "ERRO: Endereco IP informado (" + enderecoIp + ") diferente do endereço IP recuperado (" + enderecoReveso + ")."
                Logs.logError(msg)
                return ret
        if (not Utils.isValidAddress(enderecoIp)):
            Logs.logWarn("AVISO: Endereço IP " + enderecoIp + " não responde protocolo ICMP");
        if Utils.isNull(descricao):
            descricao = nomeDns
        if Utils.isNull(modelo):
            modelo = Utils.formatTemplate(Utils.PREFIX_HOST, self.__ambiente, self.__plataforma, nomeDns, modelo)
        comando = self.__servidor.getUrlConfigHostCommand()
        dados = {'host_name':nomeDns.lower(),
            'address':enderecoIp,
            'display_name':descricao,
            'alias':nomeDns.lower(),
            'use':modelo,
            'is_active':'1',
            'apikey':self.__APIKEY,
            'force':str(Utils.FORCE),
            'applyconfig':str(Utils.APPLY)}
        try:
            resposta = Utils.executePost(comando, dados)
            ret = (resposta.status_code == requests.codes.ok)
        except Exception as e:
            ret = False
            Logs.logError(str(e))
        return ret

    def excluir(self, nomeDns):
        ret = False
        if Utils.isNull(nomeDns):
            msg = "ERRO: Nome do servidor não informado."
            Logs.logError(msg)
            return ret
        comando = self.__servidor.getUrlConfigHostCommand()
        comando += "?host_name=" + nomeDns.lower()
        comando += "&apikey=" + self.__APIKEY
        comando += "&force=" + str(Utils.FORCE)
        comando += "&applyconfig=" + str(Utils.APPLY)
        try:
            resposta = Utils.executeDelete(comando)
            ret = (resposta.status_code == requests.codes.ok) 
        except Exception as e:
            ret = False
            Logs.logError(str(e))
        return ret

    def desabilitar(self, nomeDns):
        ret = None
        if Utils.isNull(nomeDns):
            msg = "ERRO: Nome do servidor não informado."
            Logs.logError(msg)
            return ret
        comando = self.__servidor.getUrlConfigHostCommand()
        dados = {'host_name' : nomeDns.lower(),
            'is_active' : '0',
            'active' : '0',
            'register' : '0',
            'apikey' : self.__APIKEY,
            'force' : str(Utils.FORCE),
            'applyconfig' : str(Utils.APPLY)}
        try:
            resposta = Utils.executePost(comando, dados)
            ret = (resposta.status_code == requests.codes.ok) 
        except Exception as e:
            ret = False
            Logs.logError(str(e))
        return ret

    def habilitar(self, nomeDns):
        ret = None
        if Utils.isNull(nomeDns):
            msg = "ERRO: Nome do servidor não informado."
            print(msg)
            Logs.logError(msg)
            return ret
        comando = self.__servidor.getUrlConfigHostCommand()
        dados = {'host_name' : nomeDns.lower(),
            'is_active' : '1',
            'apikey' : self.__APIKEY,
            'force' : str(Utils.FORCE),
            'applyconfig' : str(Utils.APPLY)}
        try:
            resposta = Utils.executePost(comando, dados)
            ret = (resposta.status_code == requests.codes.ok) 
        except Exception as e:
            ret = False
            Logs.logError(str(e))
        return ret