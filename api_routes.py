from datetime import datetime, timedelta
from flask import Blueprint, current_app, jsonify, request
from functools import wraps
import jwt
import bcrypt
from sentence_transformers import SentenceTransformer, util


from db import Users, Auctions

api_bp = Blueprint('api', __name__, url_prefix='/api')

model = SentenceTransformer('all-MiniLM-L6-v2', local_files_only=True)

users = Users()
auctions = Auctions()

def token_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        # Try to get token from Authorization header first
        auth_header = request.headers.get('Authorization')
        if auth_header and auth_header.startswith('Bearer '):
            token = auth_header.split(' ')[1]
        elif request.cookies.get('jwt_token'):
            token = request.cookies.get('jwt_token')
        else:
            # Fallback to JSON body for backwards compatibility
            data = request.get_json(silent=True) or {}
            token = data.get('authentication')
        
        if not token:
            return jsonify({"error": "Authentication token is missing"}), 401
        
        try:
            from flask import current_app
            data = jwt.decode(token, current_app.secret_key, algorithms=["HS256"])
            user_id = data['user_id']
            
            user = users.get_user_by_id(user_id)
            if not user:
                return jsonify({"error": "User not found for token"}), 401
            
        except jwt.ExpiredSignatureError:
            return jsonify({"error": "Token has expired"}), 401
        except jwt.InvalidTokenError:
            return jsonify({"error": "Invalid token"}), 401
        
        return f(*args, **kwargs)
    return decorated_function

def check_email_format(email):
    import re
    email_regex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(email_regex, email) is not None

parameter_types = {
    "lastName": str,
    "firstName": str,
    "city": str,
    "email": "email",
}

def check_valid_json(data, required_fields):
    if not data:
        return False
    for field in required_fields:
        if field not in data:
            return False
    return True

@api_bp.route('/categories', methods=['GET'])
def api_categories():
    """
    Get all available categories
    ---
    responses:
      200:
        description: List of categories
        schema:
          type: array
          items:
            type: string
    """
    categories = auctions.get_popular_categories()
    if not categories:
        return jsonify([]), 500
    return jsonify(categories), 200

def query_search(query, auctions_items):
    texts = [f"{item['name']}" for item in auctions_items]
    query_embedding = model.encode(query, convert_to_tensor=True)
    doc_embeddings = model.encode(texts, convert_to_tensor=True)
    scores = util.cos_sim(query_embedding, doc_embeddings)
    auctions_items = [item for _, item in sorted(zip(scores[0], auctions_items), key=lambda x: x[0], reverse=True)]
    return auctions_items

@api_bp.route('/auctions', methods=['GET'])
def api_search():
    """
    Get auctions with optional category filter, sorting, and pagination
    ---
    parameters:
      - name: category
        in: query
        type: string
        description: Filter by category name (e.g., 'clothing', 'furniture')
        required: false
      - name: count
        in: query
        type: integer
        default: 6
        description: Number of auctions to return
      - name: offset
        in: query
        type: integer
        default: 0
        description: Number of auctions to skip (for pagination)
      - name: sort
        in: query
        type: string
        enum: [published_at, views, price]
        default: published_at
        description: Sort by column
    responses:
      200:
        description: List of auctions
        schema:
          type: array
          items:
            type: object
            properties:
              id:
                type: integer
              name:
                type: string
              price:
                type: number
              image_small:
                type: string
              published_at:
                type: string
              auction_time:
                type: integer
              views:
                type: integer
    """
    category = request.args.get('category', "")
    query = request.args.get('query', "")
    count = request.args.get('count', 6, type=int)
    offset = request.args.get('offset', 0, type=int)
    sort = request.args.get('sort', "published_at", type=str)
    count_temp = None

    if query:
        count_temp = count
        offset_temp = offset
        count = 1000 # All auctions
        offset = 0

    if category:
        auctions_items = auctions.get_auctions_by_category(category, count, offset, sort)
    else:
        auctions_items = auctions.get_all_auctions(count, offset, sort)

    if query:
      # This is shit but it looks alright
      auctions_items = query_search(query, auctions_items)
      auctions_items = auctions_items[offset_temp:offset_temp+count_temp]
        

    return jsonify(auctions_items)

@api_bp.route('/auctions/<int:auction_id>', methods=['GET'])
def api_auction_detail(auction_id):
    """
    Get details for a specific auction
    ---
    parameters:
      - name: auction_id
        in: path
        type: integer
        required: true
        description: The auction ID
    responses:
      200:
        description: Auction details
      404:
        description: Auction not found
    """
    auction = auctions.get_auction_by_id(auction_id)
    if not auction:
        return jsonify({"error": "Auction not found"}), 404
    return jsonify(auction)

@api_bp.route('/auctions/<int:auction_id>/bid', methods=['POST'])
@token_required
def api_place_bid(auction_id):
    """
    Place a bid on an auction
    ---
    parameters:
      - name: auction_id
        in: path
        type: integer
        required: true
        description: The auction ID to bid on
      - name: body
        in: body
        required: true
        schema:
          type: object
          properties:
            amount:
              type: number
              description: The bid amount (must be higher than current highest bid)
          required:
            - amount
    responses:
      200:
        description: Bid placed successfully
      400:
        description: Invalid bid amount or auction not found or auction is not active or user is not authenticated or user is the owner of the auction or bid is too low or user has already placed a bid on this auction or user has insufficient funds (not implemented)
      401:
        description: Authentication token missing or invalid
      404:
        description: Auction not found
    """
    data = request.get_json(silent=True)
    if not check_valid_json(data, ['amount']):
        return jsonify({"error": "Not valid format"}), 400

    amount = data.get('amount')
    if not isinstance(amount, (int, float)) or amount <= 0:
        return jsonify({"error": "Invalid bid amount"}), 400

    auction = auctions.get_auction_by_id(auction_id)
    if not auction:
        return jsonify({"error": "Auction not found"}), 404

    if not auction['published']:
        return jsonify({"error": "Auction is no longer published"}), 400

    current_bid = auction['price']
    if amount <= current_bid:
        return jsonify({"error": "Bid must be higher than current highest bid"}), 400

    # Get user id from token or cookie
    auth_header = request.headers.get('Authorization')
    if auth_header and auth_header.startswith('Bearer '):
        token = auth_header.split(' ')[1]
    elif request.cookies.get('jwt_token'):
        token = request.cookies.get('jwt_token')
    else:
        return jsonify({"error": "Authentication token is missing"}), 401
    user_id = jwt.decode(token, current_app.secret_key, algorithms=["HS256"])['user_id']
    
    # Update the auction with the new highest bid and increment number of bids.

    auctions.place_bid(auction_id, user_id, amount)
    return jsonify({"message": "Bid placed successfully"}), 200

@api_bp.route('/auctions/remove_published', methods=['PUT'])
@token_required
def remove_published_auctions():
    """
    Mark an expired auction as no longer published
    ---
    parameters:
      - name: body
        in: body
        required: true
        schema:
          type: object
          properties:
            auction_id:
              type: integer
              description: The auction ID to update
          required:
            - auction_id
    responses:
      200:
        description: Auction status updated successfully
      400:
        description: Invalid request or auction still active
      401:
        description: Authentication token missing or invalid
      404:
        description: Auction not found
    """
    # Implement the logic to remove published auctions
    data = request.get_json(silent=True)
    if not check_valid_json(data, ['auction_id']):
        return jsonify({"error": "Not valid format"}), 400
    auction_id = data.get('auction_id')
    auction = auctions.get_auction_by_id(auction_id)
    if not auction:
        return jsonify({"error": "Auction not found"}), 404
    if not auction['published']:
        return jsonify({"error": "Cannot update unpublished auction"}), 400
    published_at = auction['published_at']
    auction_time = auction['auction_time']
    end_time = published_at + timedelta(seconds=auction_time)
    if datetime.now() >= end_time:
        auctions.update_published(auction_id, False)
        return jsonify({"message": "Auction published status updated to False"}), 200
    else:
        return jsonify({"error": "Auction is still active"}), 400

@api_bp.route('/auctions/create', methods=['POST'])
@token_required
def api_create_auction():
    """
    Create a new auction (Not yet implemented)
    ---
    responses:
      501:
        description: Not implemented
    """
    # Implement the logic to create a new auction
    return ("", 501)

@api_bp.route('/auctions/update/<int:auction_id>', methods=['PUT'])
@token_required
def api_update_auction(auction_id):
    """
    Update an existing auction (Not yet implemented)
    ---
    parameters:
      - name: auction_id
        in: path
        type: integer
        required: true
        description: The auction ID to update
    responses:
      501:
        description: Not implemented
    """
    # Implement the logic to update an auction
        
    return ("", 501)

@api_bp.route('/users', methods=['POST'])
def api_create_user():
    """
    Create a new user account
    ---
    parameters:
      - name: body
        in: body
        required: true
        schema:
          type: object
          properties:
            firstName:
              type: string
            lastName:
              type: string
            email:
              type: string
            password:
              type: string
            city:
              type: string
          required:
            - firstName
            - lastName
            - email
            - password
    responses:
      201:
        description: User created successfully
      400:
        description: Invalid format or email already exists
    """
    # Implement the logic to create a new user
    data = request.get_json(silent=True)
    if not check_valid_json(data, ['firstName', 'lastName', 'email', 'password']):
        return jsonify({"error": "Not valid format"}), 400
    first_name = data.get('firstName')
    last_name = data.get('lastName')
    city = data.get('city')
    email = data.get('email')
    if not check_email_format(email):
        return jsonify({"error": "Invalid email format"}), 400
    password = data.get('password')
    if not all([first_name, last_name, email, password]):
        return jsonify({"error": "Not valid format"}), 400
    account_created = datetime.now().strftime('%Y-%m-%d')
    resp = users.create_user(last_name, first_name, city, email, account_created, password)
    if resp is None:
        return jsonify({"error": "Error creating user"}), 400
    resp = {
        "id": resp.id,
        "firstName": resp.firstName,
        "lastName": resp.lastName,
        "city": resp.city,
        "accountCreated": resp.accountCreated,
    }
    return (jsonify(resp), 201)

@api_bp.route('/users', methods=['GET'])
@token_required
def api_get_all_users():
    """
    Get all users (requires authentication)
    ---
    responses:
      200:
        description: List of all users
      401:
        description: Authentication token missing or invalid
    """
    # Implement the logic to get all users
    resp = users.get_all_users()
    return (jsonify(resp), 200)

@api_bp.route('/users/<int:user_id>', methods=['GET'])
def api_get_user(user_id):
    """
    Get user details by ID
    ---
    parameters:
      - name: user_id
        in: path
        type: integer
        required: true
        description: The user ID
    responses:
      200:
        description: User details
      404:
        description: User not found
    """
    # Implement the logic to get user details
    resp = users.get_user_by_id(user_id)
    if resp:
        resp = {
            "id": resp.id,
            "firstName": resp.firstName,
            "lastName": resp.lastName,
            "city": resp.city,
            "accountCreated": resp.accountCreated,
        }
        return (jsonify(resp), 200)
    return ("", 404)

@api_bp.route('/login', methods=['POST'])
def api_login():
    """
    Authenticate user and return JWT token
    ---
    parameters:
      - name: body
        in: body
        required: true
        schema:
          type: object
          properties:
            email:
              type: string
            password:
              type: string
          required:
            - email
            - password
    responses:
      200:
        description: Login successful, returns JWT token
      400:
        description: Invalid format or missing credentials
      401:
        description: Invalid email or password
    """
    from flask import current_app
    data = request.get_json(silent=True)
    if not check_valid_json(data, ['email', 'password']):
        return jsonify({"error": "Not valid format"}), 400
    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return ("", 400)

    if not check_email_format(email):
        return jsonify({"error": "Invalid email format"}), 400

    user_obj = users.get_user_by_email(email)
    if not user_obj or not bcrypt.checkpw(password.encode(), user_obj.password.encode()):
        return ("", 401)
    
    token = jwt.encode({'user_id': user_obj.id, 'exp': datetime.now() + timedelta(hours=1)}, current_app.secret_key, algorithm="HS256")

    return jsonify({"token": token, "user": {"id": user_obj.id, "email": user_obj.email}}), 200


