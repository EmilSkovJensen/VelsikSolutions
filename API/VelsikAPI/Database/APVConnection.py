import psycopg2
from Database.Models.APV import APV
from Database.BCrypt import BCryptTool
from configparser import ConfigParser

from Database.Models.UserResponseStatus import UserResponseStatus


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

    def get_questions(self, apv_id):
        connection = psycopg2.connect(self.connection_string)
        if not connection:
            print("Database connection not established.")
            return None

        questions = []

        try:
            with connection.cursor() as cursor:
                cursor.execute(
                    "SELECT * FROM apv_question WHERE apv_id = %s",
                    (apv_id,))

                questions = cursor.fetchall()
        except psycopg2.Error as e:
            print("Error executing SQL query:", e)

        return questions

    def get_question_stats(self, apv_id):
        connection = psycopg2.connect(self.connection_string)
        if not connection:
            print("Database connection not established.")
            return None

        questions = []

        try:
            with connection.cursor() as cursor:
                cursor.execute(
                    """SELECT aq.apv_question_id, aq.question_title, aq.question_text, 
                                (SELECT COUNT(*) FROM user_apv_relation WHERE apv_id = aq.apv_id) AS total_attendees,
                                (SELECT COUNT(*) FROM response WHERE response.apv_question_id = aq.apv_question_id AND response.answer = true) AS yes_count,
                                (SELECT COUNT(*) FROM response WHERE response.apv_question_id = aq.apv_question_id AND response.answer = false) AS no_count 
                            FROM apv_question aq 
                            INNER JOIN response ON response.apv_question_id = aq.apv_question_id WHERE aq.apv_id = %s ORDER BY yes_count DESC""",
                    (apv_id,))

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
                        "INSERT INTO apv_question(apv_id, question_title, question_text) VALUES (%s, %s, %s)",
                        (apv_id, question["questionTitle"], question["questionText"]))

        except psycopg2.Error as e:
            raise ValueError("Error executing SQL query:", e)

    @staticmethod
    def insert_user_apv_relations(connection, apv_id, users):
        try:
            with connection.cursor() as cursor:
                for user in users:
                    cursor.execute(
                        "INSERT INTO user_apv_relation(user_id, apv_id, is_completed) VALUES (%s, %s, %s)", (user['userId'], apv_id, False))

        except psycopg2.Error as e:
            raise ValueError("Error executing SQL query:", e)

    def insert_apv(self, apv: APV):
        connection = psycopg2.connect(self.connection_string)
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                            INSERT INTO apv (company_id, start_date, end_date)
                            VALUES (%s, %s, %s) RETURNING apv_id
                        """, (apv.company_id, apv.start_date, apv.end_date))

                apv_id = cursor.fetchone()[0]

                self.insert_apv_questions(connection=connection, apv_id=apv_id, questions=apv.questions)

                self.insert_user_apv_relations(connection=connection, apv_id=apv_id, users=apv.users)

            # Commit the transaction
            connection.commit()
            print("Successfully inserted new apv")
        except psycopg2.Error as e:
            # Rollback the transaction in case of error
            connection.rollback()
            raise e

    def get_apvs_by_user_id(self, user_id):
        connection = psycopg2.connect(self.connection_string)
        if not connection:
            print("Database connection not established.")
            return None

        apvs = []

        try:
            with connection.cursor() as cursor:
                cursor.execute(
                    """SELECT apv.* FROM apv
                             INNER JOIN user_apv_relation aur ON aur.apv_id = apv.apv_id
                             WHERE aur.user_id = %s 
                               AND apv.start_date <= CURRENT_DATE 
                               AND apv.end_date >= CURRENT_DATE
                               AND aur.is_completed = false""",
                    (user_id,))

                allapvs = cursor.fetchall()

                for obj in allapvs:
                    apv = APV(obj[0], obj[1], obj[2], obj[3], None, None)
                    apvs.append(apv)

        except psycopg2.Error as e:
            print("Error executing SQL query:", e)

        return apvs

    def insert_response(self, response):
        connection = psycopg2.connect(self.connection_string)
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                                    INSERT INTO response (apv_question_id, user_id, answer, comment)
                                    VALUES (%s, %s, %s, %s)""", (response.apv_question_id, response.user_id, response.answer, response.comment))

            # Commit the transaction
            connection.commit()
            print("Successfully inserted new response")
        except psycopg2.Error as e:
            # Rollback the transaction in case of error
            connection.rollback()
            raise e

    def complete_apv(self, apv_question_id, user_id):
        connection = psycopg2.connect(self.connection_string)
        try:
            with connection.cursor() as cursor:
                cursor.execute("""UPDATE user_apv_relation SET is_completed = true WHERE user_id = %s AND apv_id = (SELECT apv_id FROM apv_question WHERE apv_question_id = %s)""",
                               (user_id, apv_question_id))

            # Commit the transaction
            connection.commit()
        except psycopg2.Error as e:
            # Rollback the transaction in case of error
            connection.rollback()
            raise e

    def get_apv_user_statuses(self, company_id):
        connection = psycopg2.connect(self.connection_string)
        if not connection:
            print("Database connection not established.")
            return None

        statuses = []

        try:
            with connection.cursor() as cursor:
                cursor.execute(
                    """SELECT users.firstname, users.lastname, users.email, users.phone_number, uar.is_completed 
                             FROM users 
                             INNER JOIN user_apv_relation uar ON uar.user_id = users.user_id 
                             WHERE apv_id = (SELECT apv_id FROM apv WHERE company_id = %s ORDER BY apv_id DESC LIMIT 1)""",
                    (company_id,))

                all_users = cursor.fetchall()

                for obj in all_users:
                    user_response_status = UserResponseStatus(obj[0], obj[1], obj[2], obj[3], obj[4])
                    statuses.append(user_response_status)

        except psycopg2.Error as e:
            print("Error executing SQL query:", e)

        return statuses

    def get_previous_apvs(self, company_id):
        connection = psycopg2.connect(self.connection_string)
        if not connection:
            print("Database connection not established.")
            return None

        previous_apvs = []

        try:
            with connection.cursor() as cursor:
                cursor.execute(
                    """SELECT * FROM apv WHERE company_id = %s AND apv.end_date <= CURRENT_DATE ORDER BY apv_id DESC""",
                    (company_id,))

                all_apvs = cursor.fetchall()

                for obj in all_apvs:
                    apv = APV(obj[0], obj[1], obj[2], obj[3], None, None)
                    previous_apvs.append(apv)

        except psycopg2.Error as e:
            print("Error executing SQL query:", e)

        return previous_apvs

    def get_comments_by_question_id(self, question_id):
        connection = psycopg2.connect(self.connection_string)
        if not connection:
            print("Database connection not established.")
            return None

        comments = []

        try:
            with connection.cursor() as cursor:
                cursor.execute(
                    """SELECT comment FROM response WHERE apv_question_id = %s""",
                    (question_id,))

                all_comments = cursor.fetchall()

                for comment in all_comments:
                    comments.append(comment[0])

        except psycopg2.Error as e:
            print("Error executing SQL query:", e)

        return comments
