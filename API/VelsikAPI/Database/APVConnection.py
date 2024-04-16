import psycopg2
from Database.Models.APV import APV
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

    def get_apv_types(self, category_name):
        connection = psycopg2.connect(self.connection_string)
        if not connection:
            print("Database connection not established.")
            return None

        types = []

        try:
            with connection.cursor() as cursor:
                cursor.execute(
                    "SELECT apv_type_name FROM apv_type WHERE apv_category_id = (SELECT apv_category_id FROM apv_category WHERE apv_category_name = %s)",
                    (category_name,))

                types = cursor.fetchall()
        except psycopg2.Error as e:
            print("Error executing SQL query:", e)

        return types

    @staticmethod
    def insert_apv_questions(connection, apv_id, questions):
        try:
            with connection.cursor() as cursor:
                for question in questions:
                    cursor.execute(
                        "INSERT INTO apv_question(apv_id, placement_no, question_title, question_text) VALUES (%s, %s, %s, %s)",
                        (apv_id, question["placement_no"], question["question_title"], question["question_text"]))

        except psycopg2.Error as e:
            raise ValueError("Error executing SQL query:", e)

    @staticmethod
    def insert_user_apv_relations(connection, apv_id, users):
        try:
            with connection.cursor() as cursor:
                for user in users:
                    cursor.execute(
                        "INSERT INTO user_apv_relation(apv_id, user_id) VALUES (%s, %s)",
                        (apv_id, user[0]))

        except psycopg2.Error as e:
            raise ValueError("Error executing SQL query:", e)

    def insert_apv(self, apv: APV):
        connection = psycopg2.connect(self.connection_string)
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                            INSERT INTO apv (apv_id, company_id, start_date, end_date)
                            VALUES (%s, %s, %s, %s) RETURNING apv_id
                        """, (apv.apv_id, apv.company_id, apv.start_date, apv.end_date))

                apv_id = cursor.fetchone()[0]

                self.insert_apv_questions(apv_id, apv.questions)
                self.insert_user_apv_relations(apv_id, apv.users)

            # Commit the transaction
            connection.commit()
            print("Successfully inserted new apv")
        except psycopg2.Error as e:
            # Rollback the transaction in case of error
            connection.rollback()
            print("Error inserting user:", e)
