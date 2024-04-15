import psycopg2
from Database.Models.User import User
from Database.BCrypt import BCryptTool
from configparser import ConfigParser


class QuestionConnection:
    def __init__(self):
        self.config = ConfigParser()
        self.config.read("appsettings.ini")
        self.connection_string = self.config.get('Database', 'ConnectionString')

