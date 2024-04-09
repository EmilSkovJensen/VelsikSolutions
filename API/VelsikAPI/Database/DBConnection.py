import psycopg2
import Database.Models.User as User
from Database.BCrypt import BCryptTool
from configparser import ConfigParser


class DBConnection:
    def __init__(self):
        self.config = ConfigParser()
        self.config.read("appsettings.ini")
        self.connection_string = self.config.get('Database', 'ConnectionString')

    def get_all_companies(self):
        connection = psycopg2.connect(self.connection_string)
        if not connection:
            print("Database connection not established.")
            return None

        companies = []

        try:
            with connection.cursor() as cursor:
                cursor.execute("SELECT * FROM Company")

                companies = cursor.fetchall()
        except psycopg2.Error as e:
            print("Error executing SQL query:", e)

        return companies

    def insert_user(self, user: User):
        connection = psycopg2.connect(self.connection_string)
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    INSERT INTO users (company_id, department_id, email, password,
                                       firstname, lastname, phone_number, user_role)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """, (user.company_id, user.department_id, user.email, BCryptTool.hash_password(user.password),
                      user.firstname, user.lastname, user.phone_number, user.user_role))

            # Commit the transaction
            connection.commit()
            print("User inserted successfully.")
        except psycopg2.Error as e:
            # Rollback the transaction in case of error
            connection.rollback()
            print("Error inserting user:", e)

    def compare_passwords(self, email, password):
        connection = psycopg2.connect(self.connection_string)
        try:
            with connection.cursor() as cursor:
                cursor.execute("SELECT * FROM users WHERE email = %s", (email,))

                user = cursor.fetchone()

            if user is None:
                return False

            print(password)
            print(user[4])

            if BCryptTool.validate_password(password, user[4]):
                return user
            else:
                print("Password is incorrect")
                return False

        except psycopg2.Error as e:
            print("Error executing SQL query:", e)
