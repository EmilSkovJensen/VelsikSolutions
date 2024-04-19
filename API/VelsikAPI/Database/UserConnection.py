import psycopg2

from Database.Models.Department import Department
from Database.Models.User import User
from Database.BCrypt import BCryptTool
from configparser import ConfigParser


class UserConnection:
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

    def get_user_by_user_id(self, user_id):
        connection = psycopg2.connect(self.connection_string)
        if not connection:
            print("Database connection not established.")
            return None

        try:
            with connection.cursor() as cursor:
                cursor.execute("SELECT * FROM Users WHERE user_id = %s", (user_id,))

                data = cursor.fetchone()

                print(data[3])

                user = User(
                    user_id=data[0],
                    company_id=data[1],
                    department_id=data[2],
                    email=data[3],
                    password=data[4],
                    firstname=data[5],
                    lastname=data[6],
                    phone_number=data[7],
                    user_role=data[8]
                )

        except psycopg2.Error as e:
            print("Error executing SQL query:", e)

        return user

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

    def get_departments(self):
        connection = psycopg2.connect(self.connection_string)
        if not connection:
            print("Database connection not established.")
            return None

        departments = []

        try:
            with connection.cursor() as cursor:
                cursor.execute("SELECT * FROM Department")

                departments = []
                data = cursor.fetchall()

                for department in data:
                    departments.append(Department(department[0], department[1], None))

        except psycopg2.Error as e:
            print("Error executing SQL query:", e)

        return departments

    def get_users_by_department(self, company_id, department_name):
        connection = psycopg2.connect(self.connection_string)
        if not connection:
            print("Database connection not established.")
            return None

        try:
            with connection.cursor() as cursor:
                cursor.execute(
                    "SELECT * FROM Users WHERE company_id = %s AND department_id = (SELECT department_id FROM department WHERE department_name = %s)",
                    (company_id, department_name))

                users = []
                data = cursor.fetchall()

                for user in data:
                    users.append(User(user_id=user[0],
                                      company_id=user[1],
                                      department_id=user[2],
                                      email=user[3],
                                      password=user[4],
                                      firstname=user[5],
                                      lastname=user[6],
                                      phone_number=user[7],
                                      user_role=user[8]))

        except psycopg2.Error as e:
            print("Error executing SQL query:", e)

        return users

    def get_departments_and_users(self, company_id):
        departments = self.get_departments()

        for department in departments:
            department.users = self.get_users_by_department(company_id, department.name)
