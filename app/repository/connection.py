import postgresql
import datetime
from collections import namedtuple


class Connection(object):
    _db = None

    def __init__(self, connectionString):
        self._db = postgresql.open(connectionString)

    def execute(self, sql):
        self._db.execute(sql)

    def select(self, sql):
        rs = None

        rs = self._db.prepare(sql)

        if(rs == None):
            return rs

        response = self.__serialize(rs)

        return response

    def close(self):
        self._db.close()

    def __serialize(self, values) -> list:
        l = [dict((values.column_names[i], self.__formatValue(value))
                  for i, value in enumerate(row)) for row in values]

        return l

    def __formatValue(self, value):
        formatedValue = value

        formatedValue = formatedValue.strftime(
            "%Y-%m-%d %H:%M:%S") if (type(formatedValue) is datetime.datetime) else formatedValue

        formatedValue = formatedValue.strftime(
            "%Y-%m-%d") if (type(formatedValue) is datetime.date) else formatedValue

        formatedValue = formatedValue.replace("'", "") if (type(formatedValue) is str) else formatedValue

        formatedValue = 'null' if formatedValue == None else formatedValue
        return formatedValue
