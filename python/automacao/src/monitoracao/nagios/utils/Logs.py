import syslog

def __log(prioridade, mensagem):
    syslog.syslog(prioridade, mensagem)

def logInfo(mensagem):
    __log(syslog.LOG_INFO, mensagem)

def logWarn(mensagem):
    __log(syslog.LOG_WARNING, mensagem)

def logError(mensagem):
    __log(syslog.LOG_ERR, mensagem)