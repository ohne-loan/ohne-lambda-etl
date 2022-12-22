import app.log.log
import sys


class EtlProcess(object):
    _connOrigin = None
    _connTarget = None
    _getQuery = None
    _initialValueQuery = None
    _defaultInitialValue = None
    _primaryKey = None
    _deleteQuery = None
    _insertQuery = None
    _log = app.log.log.Log().log

    def __init__(self,
                 connOrigin,
                 connTarget,
                 getQuery,
                 initialValueQuery,
                 defaultInitialValue,
                 primaryKey,
                 deleteQuery,
                 insertQuery):
        self._connOrigin = connOrigin
        self._connTarget = connTarget
        self._getQuery = getQuery
        self._initialValueQuery = initialValueQuery
        self._defaultInitialValue = defaultInitialValue
        self._primaryKey = primaryKey
        self._deleteQuery = deleteQuery
        self._insertQuery = insertQuery

    def process(self):
        try:
            self._log.info('Atributos da classe...')
            self._log.info('connOrigin: {0}'.format(self._connOrigin._db))
            self._log.info('connTarget: {0}'.format(self._connTarget._db))
            self._log.info('getQuery: {0}'.format(self._getQuery))
            self._log.info('initialValueQuery: {0}'.format(self._initialValueQuery))
            self._log.info('defaultInitialValue: {0}'.format(self._defaultInitialValue))
            self._log.info('primaryKey: {0}'.format(self._primaryKey))
            self._log.info('deleteQuery: {0}'.format(self._deleteQuery))
            self._log.info('insertQuery: {0}'.format(self._insertQuery))

            self._log.info('Iniciando processo de etl...')

            self._log.info('Executando método __deleteValues...')
            initialValue = self.__deleteValues()
            self._log.info('Método __deleteValues executado...')

            self._log.info('Executando método __getInitialDate...')
            initialValue = self.__getInitialValue()
            self._log.info('Método __getInitialDate executado...')

            self._log.info('Executando método __getValues...')
            values = self.__getValues(initialValue)
            self._log.info('Método __getValues executado...')

            self._log.info('{0} registros para inserção/atualização...'.format(len(values)))

            if((values == None) | (len(values) == 0)):
                self._log.info('Processo de etl concluído...')

                return

            self._log.info('Executando método __insert...')
            self.__insert(values)
            self._log.info('Método __insert executado...')

            self._log.info('Processo de etl concluído com sucesso...')
        except:
            self._log.info('Ocorreu um erro...')
            error = sys.exc_info()
            self._log.error(str(error))
            self._log.error(str(error[2].tb_frame))

    def __getInitialValue(self) -> str:
        response = self._connTarget.select(self._initialValueQuery)

        response = list(response[0].values())[0]

        return response

    def __getValues(self, initialValue) -> list:
        initialValue = self._defaultInitialValue if initialValue == 'null' else initialValue
        query = self._getQuery.format(initialValue)

        response = self._connOrigin.select(query)

        return response

    def __deleteValues(self):
        query = self._deleteQuery

        self._connTarget.execute(query)

    def __deleteUpdatedValues(self, values):
        pks = [value[self._primaryKey]
               for value in values]

        query = self._deleteQuery.format(pks).replace("[", "").replace("]", "")

        self._connTarget.execute(query)

    def __insert(self, values):
        strValues = [str(list(value.values()))
                     for value in values]

        valuesToInsert = ""

        for value in strValues:
            valuesToInsert += value.replace(
                "[", "(").replace("]", ")").replace("'null'", "null") + ","

        valuesToInsert = valuesToInsert[:len(valuesToInsert)-1]

        query = self._insertQuery + valuesToInsert

        self._connTarget.execute(query)
