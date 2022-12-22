import app.etlProcess

def process(connOrigin,
            connTarget,
            getQuery,
            initialValueQuery,
            defaultInitialValue,
            primaryKey,
            deleteQuery,
            insertQuery):
    etlProcess = app.etlProcess.EtlProcess(connOrigin,
                                           connTarget,
                                           getQuery,
                                           initialValueQuery,
                                           defaultInitialValue,
                                           primaryKey,
                                           deleteQuery,
                                           insertQuery)

    etlProcess.process()
    connOrigin.close()
    connTarget.close()
