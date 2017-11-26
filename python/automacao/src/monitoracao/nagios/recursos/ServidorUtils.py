from monitoracao.nagios.utils import Utils

class ServidorUtils:
    
    __URL_NAGIOS = None

    def __init__(self, nagios):
        self.__URL_NAGIOS = nagios

    def getUrlConfigHostCommand(self):
        return Utils.getUrlHostCommand(self.__URL_NAGIOS, Utils.URL_CONFIG)

    def getUrlObjectHostCommand(self):
        return Utils.getUrlHostCommand(self.__URL_NAGIOS, Utils.URL_OBJECT)
