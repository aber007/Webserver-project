from datetime import datetime, timedelta
from flask import Blueprint, jsonify, request
from functools import wraps
import jwt
import bcrypt

from db import Users, Auctions

api_bp = Blueprint('api', __name__, url_prefix='/api')

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

@api_bp.route('/auctions', methods=['GET'])
def api_search():
    category = request.args.get('category', "")
    count = request.args.get('count', 6, type=int)
    offset = request.args.get('offset', 0, type=int)
    if category:
        auctions_items = auctions.get_auctions_by_category(category, count, offset)
    else:
        auctions_items = auctions.get_all_auctions(count, offset)

    # Check if auctions_items contain expired auctions and set published to False and exclude them
    return jsonify(auctions_items)

@api_bp.route('/auctions/<int:auction_id>', methods=['GET'])
def api_auction_detail(auction_id):
    auction = auctions.get_auction_by_id(auction_id)
    if not auction:
        return jsonify({"error": "Auction not found"}), 404
    return jsonify(auction)

@api_bp.route('/auctions/remove_published', methods=['PUT'])
@token_required
def remove_published_auctions():
    # Implement the logic to remove published auctions
    auction_id = request.json.get('auction_id')
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
    # Implement the logic to create a new auction
    return ("", 501)

@api_bp.route('/auctions/update/<int:auction_id>', methods=['PUT'])
@token_required
def api_update_auction(auction_id):
    # Implement the logic to update an auction
        
    return ("", 501)

@api_bp.route('/users', methods=['POST'])
def api_create_user():
    # Implement the logic to create a new user
    data = request.get_json()
    first_name = data.get('firstName')
    last_name = data.get('lastName')
    city = data.get('city')
    email = data.get('email')
    password = data.get('password')
    if not all([first_name, last_name, email, password]):
        return jsonify({"error": "Missing required fields"}), 400
    
    resp = users.create_user(last_name, first_name, city, email, datetime.now(), password)
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
    # Implement the logic to get all users
    resp = users.get_all_users()
    return (jsonify(resp), 200)

@api_bp.route('/users/<int:user_id>', methods=['GET'])
def api_get_user(user_id):
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
    from flask import current_app
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return ("", 400)

    user_obj = users.get_user_by_email(email)
    if not user_obj or not bcrypt.checkpw(password.encode(), user_obj.password.encode()):
        return ("", 401)
    
    token = jwt.encode({'user_id': user_obj.id, 'exp': datetime.now() + timedelta(hours=1)}, current_app.secret_key, algorithm="HS256")

    return jsonify({"token": token, "user": {"id": user_obj.id, "email": user_obj.email}}), 200
