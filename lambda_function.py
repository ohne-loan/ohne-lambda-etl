import app.index
import app.repository.connection
import os


def lambda_handler(event, context):
    connOrigin = app.repository.connection.Connection(os.environ['ENV_CONN_ORIGIN'])
    connTarget = app.repository.connection.Connection(os.environ['ENV_CONN_TARGET'])
    getQuery = os.environ['ENV_GET_QUERY']
    initialValueQuery = os.environ['ENV_INITIAL_VALUE_QUERY']
    defaultInitialValue = os.environ['ENV_DEFAULT_INITIAL_VALUE']
    primaryKey = os.environ['ENV_PRIMARY_KEY']
    deleteQuery = os.environ['ENV_DELETE_QUERY']
    insertQuery = os.environ['ENV_INSERT_QUERY']

    app.index.process(connOrigin,
                      connTarget,
                      getQuery,
                      initialValueQuery,
                      defaultInitialValue,
                      primaryKey,
                      deleteQuery,
                      insertQuery)
