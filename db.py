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
            password='password',  
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
        accountCreated=row.get("accountCreated"),
        password=row.get("password"),
        email=row.get("email"),
    )

@dataclass
class User:
    id: int
    lastName: str
    firstName: str
    city: str
    accountCreated: str
    password: str
    email: str

    def check_password(self, password: str) -> bool:
        """
        Checks if the provided password matches the stored hashed password.
        """
        return bcrypt.checkpw(password.encode(), self.password.encode())


def run_sql(sql, params=None, *, fetch_one=False, fetch_all=True, commit=False, dictionary=True):
    """
    Executes a given SQL query with optional parameters and returns the result.
    """
    conn = get_db_connection()
    if conn is None:
        return None
    cursor = conn.cursor(dictionary=dictionary)
    try:
        cursor.execute(sql, params)
        if commit:
            conn.commit()
        if fetch_one:
            return cursor.fetchone()
        if fetch_all:
            return cursor.fetchall()
        return cursor.rowcount
    finally:
        cursor.close()
        close_db_connection(conn)

class Users:
    @staticmethod
    def create_user(lastName, firstName, city, email, accountCreated, password : str):
        """
        Inserts a new user into the database.
        """


        hashed_pass = bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()
        sql = "INSERT INTO users (lastName, firstName, city, accountCreated, password, email) VALUES (%s, %s, %s, %s, %s, %s)"
        try:
            run_sql(
                sql,
                (lastName, firstName, city, accountCreated, hashed_pass, email),
                commit=True,
                fetch_all=False,
            )
        except mysql.connector.IntegrityError as e:
            print(f"Error inserting user: {e}")
            return None
        user_obj = Users.get_user_by_email(email)
        return user_obj


    @staticmethod
    def get_user_by_id(user_id) -> Optional[User]:
        """
        Retrieves a user from the database by user ID and returns a User instance.
        Returns None if no user is found.
        """

        sql = "SELECT * FROM users WHERE ID = %s"
        row = run_sql(sql, (user_id,), fetch_one=True, fetch_all=False)

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
        sql = "SELECT * FROM users WHERE email = %s"
        row = run_sql(sql, (email,), fetch_one=True, fetch_all=False)

        if not row:
            return None

        return user_row_to_user(row)
    @staticmethod
    def get_all_user_ids():
        """
        Retrieves all user IDs from the database.
        """
        rows = run_sql("SELECT ID FROM users")
        if not rows:
            return []
        return [row["ID"] for row in rows]

    @staticmethod
    def delete_user(user_id):
        """
        Deletes a user from the database by user ID.
        """
        run_sql("DELETE FROM users WHERE ID = %s", (user_id,), commit=True, fetch_all=False)

    @staticmethod
    def update_user_email(user_id, new_email):
        """
        Updates the email of a user in the database.
        """
        run_sql(
            "UPDATE users SET email = %s WHERE ID = %s",
            (new_email, user_id),
            commit=True,
            fetch_all=False,
        )
    

    @staticmethod
    def get_all_users():
        """
        Fetches all users from the database
        """
        rows = run_sql("SELECT ID, lastName, firstName, city, email FROM users")
        return rows or []

def get_category_id(category):
        """
        Returns category_id of category name
        """
        row = run_sql(
            "SELECT id FROM `categories` WHERE name = %s",
            (category,),
            fetch_one=True,
            fetch_all=False,
        )
        if row:
            return row["id"]
        return None

class Auctions:
    @staticmethod
    def get_auctions_by_category(category, count, offset, sort):
        """
        Fetches the auctions from a specific category
        """
        category_id = get_category_id(category)
        allowed_sorts = {"published_at", "views", "price"}
        sort_column = sort if sort in allowed_sorts else "published_at"
        query = (
            "SELECT a.id, a.name, a.price, a.image_small, a.published_at, a.auction_time, a.views, "
            "c.name AS category_name, COUNT(b.id) AS bid_count "
            "FROM auctions a "
            "INNER JOIN categories c ON a.category_id = c.id "
            "LEFT JOIN bids b ON b.auction_id = a.id "
            "WHERE a.category_id = %s AND a.published = TRUE "
            "GROUP BY a.id, a.name, c.name "
            f"ORDER BY {sort_column} DESC LIMIT %s OFFSET %s"
        )
        rows = run_sql(query, (category_id, count, offset))
        return rows or []
    @staticmethod
    def get_all_auctions(count, offset, sort):
        """
        Fetches all auctions from the database
        """
        allowed_sorts = {"published_at", "views", "price"}
        sort_column = sort if sort in allowed_sorts else "published_at"
        query = (
            "SELECT a.id, a.name, a.price, a.image_small, a.published_at, a.auction_time, a.views, "
            "c.name AS category_name, COUNT(b.id) AS bid_count "
            "FROM auctions a "
            "INNER JOIN categories c ON a.category_id = c.id "
            "LEFT JOIN bids b ON b.auction_id = a.id "
            "WHERE a.published = TRUE "
            "GROUP BY a.id, a.name, c.name "
            f"ORDER BY {sort_column} DESC LIMIT %s OFFSET %s"
        )
        rows = run_sql(query, (count, offset))
        return rows or []
    @staticmethod
    def get_auction_by_id(auction_id):
        """
        Fetches a specific auction by its ID
        """
        return run_sql(
            "SELECT a.*, c.name AS category_name, COUNT(b.id) AS bid_count FROM auctions a INNER JOIN categories c ON a.category_id = c.id LEFT JOIN bids b ON b.auction_id = a.id WHERE a.id = %s AND a.published = TRUE GROUP BY a.id, a.name, c.name;",
            (auction_id,),
            fetch_one=True,
            fetch_all=False,
        )
    @staticmethod
    def update_published(auction_id, published_status):
        """
        Updates the published status of an auction
        """
        run_sql(
            "UPDATE auctions SET published = %s WHERE id = %s",
            (published_status, auction_id),
            commit=True,
            fetch_all=False,
        )
    @staticmethod
    def place_bid(auction_id, user_id, bid_amount):
        """
        Places a bid on an auction and updates the current price if the bid is valid.
        """
        # Get current price of the auction
        auction = Auctions.get_auction_by_id(auction_id)
        if not auction:
            return False  # Auction not found
        current_price = auction['price']
        
        if bid_amount <= current_price:
            return False  # Bid must be higher than current price
        
        # Insert new bid into bids table
        conn = get_db_connection()
        if conn is None:
            return False
        cursor = conn.cursor()
        try:
            cursor.execute(
            "INSERT INTO bids (auction_id, user_id, price) VALUES (%s, %s, %s)",
            (auction_id, user_id, bid_amount)
            )
            cursor.execute(
            "UPDATE auctions SET price = %s, leader_id = %s WHERE id = %s",
            (bid_amount, user_id, auction_id)
            )
            conn.commit()
        except mysql.connector.Error as e:
            conn.rollback()
            print(f"Error placing bid: {e}")
            return False
        finally:
            cursor.close()
            close_db_connection(conn)
        
        return True
    @staticmethod
    def get_popular_categories():
        """
        Fetches the most popular categories based on the number of auctions.
        """
        query = (
            "SELECT categories.name AS category, SUM(auctions.views) AS views "
            "FROM auctions "
            "JOIN categories ON auctions.category_id = categories.id "
            "GROUP BY categories.id, categories.name "
            "ORDER BY views DESC "
        )
        rows = run_sql(query)
        return rows or []