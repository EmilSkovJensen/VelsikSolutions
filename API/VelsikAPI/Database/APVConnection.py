import psycopg2
from Database.Models.User import User
from Database.BCrypt import BCryptTool
from configparser import ConfigParser


class APVConnection:
    def __init__(self):
        self.config = ConfigParser()
        self.config.read("appsettings.ini")
        self.connection_string = self.config.get('Database', 'ConnectionString')

    def get_template_questions(self, apv_type):
        connection = psycopg2.connect(self.connection_string)
        if not connection:
            print("Database connection not established.")
            return None

        questions = []

        try:
            with connection.cursor() as cursor:
                cursor.execute(
                    "SELECT * FROM question WHERE apv_type_id = (SELECT apv_type_id FROM apv_type WHERE apv_type_name = %s)",
                    (apv_type,))

                questions = cursor.fetchall()
        except psycopg2.Error as e:
            print("Error executing SQL query:", e)

        return questions

    def insert_apv_questions(self, apv_id, questions):
        connection = psycopg2.connect(self.connection_string)
        if not connection:
            print("Database connection not established.")
            return None

        try:
            with connection.cursor() as cursor:
                for question in questions:
                    cursor.execute(
                        "INSERT INTO apv_question(apv_id, placement_no, question_title, question_text) VALUES (%s, %s, %s, %s)",
                        (apv_id, question["placement_no"], question["question_title"], question["question_text"]))

        except psycopg2.Error as e:
            print("Error executing SQL query:", e)

