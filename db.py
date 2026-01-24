import mysql.connector
import hashlib
import bcrypt
from dataclasses import dataclass
from typing import Optional
def get_db_connection():
    """
    Creates and returns a new database connection.
    """
    try:
        return mysql.connector.connect(
            host='localhost',
            user='root', 
            password='',  
            database='tradee_db'
        )
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None

def init_db():
    # Starts the database service through xampp
    import subprocess
    subprocess.Popen(["C:\\xampp\\mysql_start.bat"])

def close_db_connection(conn):
    """
    Closes the given database connection.
    """
    if conn.is_connected():
        conn.close()

def user_row_to_user(row) -> 'User':
    """
    Converts a database row to a User dataclass instance.
    """
    return User(
        id=row.get("ID"),
        lastName=row.get("lastName"),
        firstName=row.get("firstName"),
        city=row.get("city"),
        password=row.get("password"),
        email=row.get("email"),
    )

@dataclass
class User:
    id: int
    lastName: str
    firstName: str
    city: str
    password: str
    email: str

    def check_password(self, password: str) -> bool:
        """
        Checks if the provided password matches the stored hashed password.
        """
        return bcrypt.checkpw(password.encode(), self.password.encode())


class Users:
    @staticmethod
    def create_user(lastName, firstName, city, email, password : str):
        """
        Inserts a new user into the database.
        """
        conn = get_db_connection()
        cursor = conn.cursor()


        hashed_pass = bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()
        try:
            cursor.execute(
                "INSERT INTO users (lastName, firstName, city, password, email) VALUES (%s, %s, %s, %s, %s)", 
                (lastName, firstName, city, hashed_pass, email)
            )
        except mysql.connector.IntegrityError as e:
            print(f"Error inserting user: {e}")
            return False
        conn.commit()
        cursor.close()
        close_db_connection(conn)
        return True


    @staticmethod
    def get_user_by_id(user_id) -> Optional[User]:
        """
        Retrieves a user from the database by user ID and returns a User instance.
        Returns None if no user is found.
        """
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM users WHERE ID = %s", (user_id,))
        row = cursor.fetchone()
        cursor.close()
        close_db_connection(conn)

        if not row:
            return None

        # Map DB row to User dataclass. Keep field names consistent with DB columns.
        return user_row_to_user(row)
    @staticmethod
    def get_user_by_email(email) -> Optional[User]:
        """
        Retrieves a user from the database by email and returns a User instance.
        Returns None if no user is found.
        """
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
        row = cursor.fetchone()
        cursor.close()
        close_db_connection(conn)

        if not row:
            return None

        # Map DB row to User dataclass. Keep field names consistent with DB columns.
        return user_row_to_user(row)
    @staticmethod
    def get_all_user_ids():
        """
        Retrieves all user IDs from the database.
        """
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT ID FROM users")
        rows = cursor.fetchall()
        cursor.close()
        close_db_connection(conn)

        return [row[0] for row in rows]

    @staticmethod
    def delete_user(user_id):
        """
        Deletes a user from the database by user ID.
        """
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM users WHERE ID = %s", (user_id,))
        conn.commit()
        cursor.close()
        close_db_connection(conn)

    @staticmethod
    def update_user_email(user_id, new_email):
        """
        Updates the email of a user in the database.
        """
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("UPDATE users SET email = %s WHERE ID = %s", (new_email, user_id))
        conn.commit()
        cursor.close()
        close_db_connection(conn)