import requests
import socket

from monitoracao.nagios.utils import Logs

__URL_REST = "/nagiosxi/api/v1"

FORCE = 1
PRETY = 1
APPLY= 1

HTTP = 'http'
HTTPS = 'https'

PREFIX_HOST = "th-"
PREFIX_SERVICE = "ts-"
PREFIX_DEVICE = "td-"
PREFIX_CONTACT = "tc-"
PREFIX_GROUP_HOST = "gh-"
PREFIX_GROUP_SERVICE = "gs-"
PREFIX_GROUP_DEVICE = "gd-"
PREFIX_GROUP_CONTACT = "gc-"

URL_OBJECT = "/object/host"
URL_CONFIG = "/config/host"

AMBIENTES = {
    'linux':'linux',
    'windows':'windows',
    'dispositivo':'dispositivo'}

PLATAFORMAS = {
    '2008':'2008',
    '2012':'2012',
    '2003':'2003',
    'x86':'x86',
    's390':'s390'}

ARQUITETURAS = {
    '32' : '32b',
    '64' : '64b'}

PROTOCOLOS = {
    'http':'http://',
    'https':'https://'}

def getUrlRest(app):
    ret = __URL_REST + app
    return ret

def executeDelete(comando):
    ret = requests.delete(comando)
    Logs.logInfo(ret.text)
    return ret

def executeGet(comando):
    ret = requests.get(comando)
    Logs.logInfo(ret.text)
    return ret

def executePost(comando, dados):
    ret = requests.post(comando, data=dados)
    Logs.logInfo(ret.text)
    return ret

def executePut(comando, dados):
    ret = requests.put(comando, data=dados)
    return ret

def getUrlHostCommand(url, app, protocolo=HTTP,  porta=80):
    ret = getUrlPattern(protocolo, url, porta, app)
    return ret

def getUrlPattern(protocolo, url, porta, app):
    ret = PROTOCOLOS[protocolo]
    ret += url
    ret += ":" + str(porta)
    ret += getUrlRest(app)
    return ret

def formatTemplate(prefixo, ambiente, plataforma, nomeDns, modelo):
    ret = prefixo
    ret += AMBIENTES[ambiente]
    ret += "-" + PLATAFORMAS[plataforma]
    ret += "-" + nomeDns[0:3]
    if isNotNull(modelo):
        ret += "-" + modelo

def isNull(valor):
    return ((not valor) or len(str(valor)) == 0)

def isNotNull(valor):
    return (valor and len(str(valor)) != 0)

def isValidHostName(nomeDns):
    ret = None
    try:
        data = socket.gethostbyname(nomeDns)
        #ip = repr(data)
        ret = True
    except Exception:
        Logs.logWarn("Aviso: Nome DNS nao resolvido.")
        ret = False;
    return ret

def isValidAddress(enderecoIp):
    ret = None
    try:
        data = socket.gethostbyaddr(enderecoIp)
        host = repr(data[0])
        ret = True
    except Exception:
        Logs.logWarn("Aviso: Endereco IP nao responde.")
        ret = False
    return ret

def getAddress(nomeDns):
    ret = None
    try:
        data = socket.gethostbyname(nomeDns)
        ret = data
    except Exception:
        Logs.logError("Aviso: Nao foi possivel obter endereco IP.")
        ret = None;
    return ret