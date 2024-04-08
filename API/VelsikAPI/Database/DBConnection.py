import psycopg2


class DBConnection:
    def __init__(self):
        self.connection_string = ""
        self.connection = psycopg2.connect(self.connection_string)
        