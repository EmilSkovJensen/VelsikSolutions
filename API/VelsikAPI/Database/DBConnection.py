import psycopg2
import Database.Models.User as User
from Database.BCrypt import BCryptTool
from configparser import ConfigParser


class DBConnection:
    def __init__(self):
        self.config = ConfigParser()
        self.config.read("appsettings.ini")
        self.connection_string = self.config.get('Database', 'ConnectionString')
        self.connection = psycopg2.connect(self.connection_string)

    def get_all_companies(self):
        if not self.connection:
            print("Database connection not established.")
            return None

        companies = []

        try:
            with self.connection.cursor() as cursor:
                cursor.execute("SELECT * FROM Company")

                companies = cursor.fetchall()
        except psycopg2.Error as e:
            print("Error executing SQL query:", e)

        return companies

    def insert_user(self, user: User):
        try:
            with self.connection.cursor() as cursor:
                cursor.execute("""
                    INSERT INTO users (company_id, department_id, email, password,
                                       firstname, lastname, phone_number, user_role)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """, (user.company_id, user.department_id, user.email, BCryptTool.hash_password(user.password),
                      user.firstname, user.lastname, user.phone_number, user.user_role))

            # Commit the transaction
            self.connection.commit()
            print("User inserted successfully.")
        except psycopg2.Error as e:
            # Rollback the transaction in case of error
            self.connection.rollback()
            print("Error inserting user:", e)
