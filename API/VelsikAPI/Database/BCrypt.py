import bcrypt


class BCryptTool:
    @staticmethod
    def get_random_salt():
        # Generates a random salt using bcrypt with a cost factor of 12
        return bcrypt.gensalt(12).decode()

    @staticmethod
    def hash_password(password):
        # Hashes a password using bcrypt and a random salt
        salt = BCryptTool.get_random_salt()
        hashed_password = bcrypt.hashpw(password.encode(), salt.encode()).decode()
        return hashed_password

    @staticmethod
    def validate_password(password, correct_hash):
        # Verifies a password against a previously hashed value
        return bcrypt.checkpw(password.encode(), correct_hash.encode())
