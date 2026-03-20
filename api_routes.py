from datetime import datetime, timedelta
import os
from flask import Blueprint, current_app, jsonify, request, g
from werkzeug.utils import secure_filename
from functools import wraps
import jwt
import bcrypt
from sentence_transformers import SentenceTransformer, util


from db import Users, Auctions

api_bp = Blueprint('api', __name__, url_prefix='/api')

model = SentenceTransformer('all-MiniLM-L6-v2', local_files_only=False)

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
        
        g.user_id = user_id
        return f(*args, **kwargs)
    return decorated_function

def check_email_format(email):
    import re
    email_regex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(email_regex, email) is not None

parameter_types = {
  "last_name": str,
  "first_name": str,
    "city": str,
    "email": "email",
  "name": str,
  "description": str,
  "category": int,
  "price": (int, float),
  "auction_time": int,
  "location": str,
  "condition": str,
  "published": bool,
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
    categories = auctions.get_popular_categories()
    if not categories:
        return jsonify([]), 200
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
    category = request.args.get('category', "")
    query = request.args.get('query', "")
    count = request.args.get('count', 6, type=int)
    offset = request.args.get('offset', 0, type=int)
    sort = request.args.get('sort', "published_at", type=str)
    owner_id = request.args.get('owner_id', None, type=int)
    count_temp = None

    if query:
        count_temp = count
        offset_temp = offset
        count = 1000 # All auctions
        offset = 0

    if category:
      auctions_items = auctions.get_auctions_by_category(category, count, offset, sort, owner_id=owner_id)
    else:
      auctions_items = auctions.get_all_auctions(count, offset, sort, owner_id=owner_id)

    if query:
      # This is shit but it looks alright
      auctions_items = query_search(query, auctions_items)
      auctions_items = auctions_items[offset_temp:offset_temp+count_temp]
        

    return jsonify(auctions_items)

@api_bp.route('/auctions/<int:auction_id>', methods=['GET'])
def api_auction_detail(auction_id):
    auction = auctions.get_auction_by_id(auction_id)
    if not auction:
        return jsonify({"error": "Auction not found"}), 404
    return jsonify(auction)

@api_bp.route('/auctions/<int:auction_id>/bid', methods=['POST'])
@token_required
def api_place_bid(auction_id):
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
    user_id = g.user_id
    # Update the auction with the new highest bid and increment number of bids.

    bid_placed = auctions.place_bid(auction_id, user_id, amount)
    if not bid_placed:
      # Re-check current state to distinguish conflict/not-found from server failures.
      latest_auction = auctions.get_auction_by_id(auction_id)
      if not latest_auction:
        return jsonify({"error": "Auction not found"}), 404
      if amount <= latest_auction['price']:
        return jsonify({"error": "Bid is no longer higher than the current highest bid"}), 409
      return jsonify({"error": "Failed to place bid"}), 500

    return jsonify({"message": "Bid placed successfully"}), 200

@api_bp.route('/auctions/remove_published', methods=['PUT'])
@token_required
def remove_published_auctions():
    """
    Mark an expired auction as no longer published
    ---
    security:
      - Bearer: []
      - Cookie: []
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
        schema:
          type: object
          properties:
            message:
              type: string
      400:
        description: Invalid request format, auction not found, auction is unpublished, or auction is still active
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
    
def check_auction_form_types(data):
    for field, expected_type in parameter_types.items():
        if field in data:
            value = data[field]
            if expected_type == "email":
                if not check_email_format(value):
                    print(f"Invalid email format for field '{field}': {value}")
                    return False
            elif expected_type == int:
                try:
                    int(value)
                except (TypeError, ValueError):
                    print(f"Invalid integer format for field '{field}': {value}")
                    return False
            elif expected_type == (int, float):
                try:
                    float(value)
                except (TypeError, ValueError):
                    print(f"Invalid number format for field '{field}': {value}")
                    return False
            elif expected_type == bool:
                if str(value).lower() not in ('true', 'false', '1', '0'):
                    print(f"Invalid boolean format for field '{field}': {value}")
                    return False
            elif not isinstance(value, expected_type):
                print(f"Invalid type for field '{field}': expected {expected_type}, got {type(value)}")
                return False
    return True

@api_bp.route('/auctions', methods=['POST'])
@token_required
def api_create_auction():
    """
    Create a new auction
    ---
    security:
      - Bearer: []
      - Cookie: []
    consumes:
      - multipart/form-data
    parameters:
      - name: name
        in: formData
        type: string
        required: true
        description: Auction title
      - name: description
        in: formData
        type: string
        required: true
        description: Detailed auction description
      - name: category
        in: formData
        type: integer
        required: true
        description: Category ID
      - name: price
        in: formData
        type: number
        required: true
        description: Starting price for the auction
      - name: auction_time
        in: formData
        type: integer
        required: true
        description: Auction duration in seconds
      - name: location
        in: formData
        type: string
        required: true
        description: Item location
      - name: condition
        in: formData
        type: string
        required: true
        description: Item condition (e.g., 'new', 'used', 'like new')
      - name: published
        in: formData
        type: boolean
        required: true
        description: Whether to publish the auction immediately
      - name: image_large
        in: formData
        type: file
        required: true
        description: Large auction image (JPG, JPEG, PNG, or WEBP)
    responses:
      200:
        description: Auction created successfully
        schema:
          type: object
          properties:
            id:
              type: integer
            name:
              type: string
      400:
        description: Invalid request format, missing required fields, invalid image format, or no image provided
      401:
        description: Authentication token missing or invalid
    """
    # Accept multipart/form-data (used by the create_auction.html form).
    is_multipart = request.content_type and 'multipart/form-data' in request.content_type

    seller_id = g.user_id

    if is_multipart:
      form = request.form
      image_file = request.files.get('image_large')
      static = current_app.static_folder
      upload_folder = os.path.join(static, 'uploaded_images')
      os.makedirs(upload_folder, exist_ok=True)

      required_fields = ['name', 'description', 'category', 'price', 'auction_time', 'location', 'condition', 'published']
      missing_fields = [field for field in required_fields if not form.get(field)]
      if missing_fields:
        return jsonify({"error": f"Missing required fields: {', '.join(missing_fields)}"}), 400

      if not check_auction_form_types(form):
        return jsonify({"error": "Invalid field types in request body"}), 400

      if image_file is None or not image_file.filename:
        return jsonify({"error": "image_large file is required"}), 400

      image_file.filename = secure_filename(image_file.filename)
      if not image_file.filename.lower().endswith(('.jpg', '.jpeg', '.png', '.webp')):
        return jsonify({"error": "Invalid image format. Only JPG, JPEG, PNG, and WEBP are allowed."}), 400

      image_path = os.path.join(upload_folder, image_file.filename)
      image_file.save(image_path)

      # Persist filename only for now to match existing DB column usage.
      image_large = '/' + os.path.join('static', 'uploaded_images', image_file.filename).replace('\\', '/')
      print("Received multipart form data with image file:", image_large)
      payload = {
        'name': form.get('name'),
        'description': form.get('description'),
        'category': int(form.get('category')),
        'price': float(form.get('price')),
        'auction_time': int(form.get('auction_time')),
        'location': form.get('location'),
        'condition': form.get('condition'),
        'published': str(form.get('published')).lower() == 'true',
        'image_regular': image_large,
        'image_small': image_large,
      }
    else:
        return jsonify({"error": "Only multipart/form-data is supported for auction creation"}), 400

    print("Creating auction with data:", payload)

    resp = auctions.create_auction(
      payload['name'],
      payload['description'],
      payload['price'],
      payload['category'],
      payload['image_small'],
      payload['image_regular'],
      payload['auction_time'],
      payload['location'],
      payload['condition'],
      payload['published'],
      seller_id,
      datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    )
    if resp is None:
        return jsonify({"error": "Error creating auction"}), 400
    print("Auction created:", resp)
    return jsonify(resp), 200

@api_bp.route('/auctions/<int:auction_id>', methods=['DELETE'])
@token_required
def api_delete_auction(auction_id):
    """
    Delete an auction
    ---
    security:
      - Bearer: []
      - Cookie: []
    parameters:
      - name: auction_id
        in: path
        type: integer
        required: true
        description: The auction ID to delete
    responses:
      200:
        description: Auction deleted successfully
        schema:
          type: object
          properties:
            message: 
              type: string
      400:
        description: Invalid auction ID or other errors
      401:
        description: Authentication token missing or invalid
      403:
        description: Unauthorized to delete this auction
      404:
        description: Auction not found
    """
    # Implement the logic to delete an auction
    auction = auctions.get_auction_by_id(auction_id, increment_views=False, update_request=True)
    if not auction:
        return jsonify({"error": "Auction not found"}), 404
    
    user_id = g.user_id
    if auction['owner_id'] != user_id:
        return jsonify({"error": "Unauthorized to delete this auction"}), 403

    success = auctions.delete_auction(auction_id)
    if success:
        return jsonify({"message": "Auction deleted successfully"}), 200
    else:
        return jsonify({"error": "Error deleting auction"}), 400

@api_bp.route('/auctions/<int:auction_id>', methods=['PUT'])
@token_required
def api_update_auction(auction_id):
    """
    Update an existing auction
    ---
    security:
      - Bearer: []
      - Cookie: []
    consumes:
      - multipart/form-data
    parameters:
      - name: auction_id
        in: path
        type: integer
        required: true
        description: The auction ID to update
      - name: name
        in: formData
        type: string
        description: (Optional) Auction title
      - name: description
        in: formData
        type: string
        description: (Optional) Detailed auction description
      - name: category
        in: formData
        type: integer
        description: (Optional) Category ID
      - name: price
        in: formData
        type: number
        description: (Optional) Price
      - name: auction_time
        in: formData
        type: integer
        description: (Optional) Auction duration in seconds
      - name: location
        in: formData
        type: string
        description: (Optional) Item location
      - name: condition
        in: formData
        type: string
        description: (Optional) Item condition
      - name: published
        in: formData
        type: boolean
        description: (Optional) Whether auction is published
      - name: image_large
        in: formData
        type: file
        description: (Optional) Updated auction image (JPG, JPEG, PNG, or WEBP)
    responses:
      200:
        description: Auction updated successfully
        schema:
          type: object
          properties:
            id:
              type: integer
            name:
              type: string
      400:
        description: Invalid field types, invalid image format, or no fields provided to update
      401:
        description: Authentication token missing or invalid
      403:
        description: Unauthorized to update this auction
      404:
        description: Auction not found
    """
    # Implement the logic to update an auction
    auction = auctions.get_auction_by_id(auction_id, increment_views=False, update_request=True)
    if not auction:
        return jsonify({"error": "Auction not found"}), 404
    
    user_id = g.user_id
    if auction['owner_id'] != user_id:
        return jsonify({"error": "Unauthorized to update this auction"}), 403

    is_multipart = request.content_type and 'multipart/form-data' in request.content_type

    if is_multipart:
      form = request.form
      image_file = request.files.get('image_large')
      static = current_app.static_folder
      upload_folder = os.path.join(static, 'uploaded_images')
      os.makedirs(upload_folder, exist_ok=True)

      optional_fields = ['name', 'description', 'category', 'price', 'auction_time', 'location', 'condition', 'published']
      for field in form:
        if field not in optional_fields:
            return jsonify({"error": f"Unexpected field: {field}"}), 400

      if not check_auction_form_types(form):
        return jsonify({"error": "Invalid field types in request body"}), 400

      if image_file and image_file.filename:
        image_file.filename = secure_filename(image_file.filename)
        if not image_file.filename.lower().endswith(('.jpg', '.jpeg', '.png', '.webp')):
          return jsonify({"error": "Invalid image format. Only JPG, JPEG, PNG, and WEBP are allowed."}), 400

        image_path = os.path.join(upload_folder, image_file.filename)
        image_file.save(image_path)

        # Persist filename only for now to match existing DB column usage.
        image_large = '/' + os.path.join('static', 'uploaded_images', image_file.filename).replace('\\', '/')

      payload = {}
      if form.get('name') is not None:
        payload['name'] = form.get('name')
      if form.get('description') is not None:
        payload['description'] = form.get('description')
      if form.get('category') is not None:
        payload['category'] = int(form.get('category'))
      if form.get('price') is not None:
        payload['price'] = float(form.get('price'))
      if form.get('auction_time') is not None:
        payload['auction_time'] = int(form.get('auction_time'))
      if form.get('location') is not None:
        payload['location'] = form.get('location')
      if form.get('condition') is not None:
        payload['condition'] = form.get('condition')
      if form.get('published') is not None:
        payload['published'] = str(form.get('published')).lower() == 'true'
      if image_file and image_file.filename:
        payload['image_small'] = image_large
        payload['image_regular'] = image_large
    else:
        return jsonify({"error": "Only multipart/form-data is supported for auction updates"}), 400

    if not payload:
        return jsonify({"error": "No fields provided to update"}), 400

    print("Updating auction with data:", payload)

    resp = auctions.update_auction(auction_id, payload)
    if resp is None:
        return jsonify({"error": "Error updating auction"}), 400
    auction = auctions.get_auction_by_id(auction_id, increment_views=False, update_request=True)
    return jsonify(auction), 200


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
            first_name:
              type: string
            last_name:
              type: string
            email:
              type: string
              format: email
            password:
              type: string
            city:
              type: string
          required:
            - first_name
            - last_name
            - email
            - password
    responses:
      201:
        description: User created successfully
        schema:
          type: object
          properties:
            id:
              type: integer
            first_name:
              type: string
            last_name:
              type: string
            city:
              type: string
            account_created:
              type: string
      400:
        description: Invalid format, missing required fields, or invalid email format
    """
    # Implement the logic to create a new user
    data = request.get_json(silent=True)
    first_name = data.get('first_name') if data else None
    last_name = data.get('last_name') if data else None

    if not data or not all([first_name, last_name, data.get('email'), data.get('password')]):
        return jsonify({"error": "Not valid format"}), 400

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
      "first_name": resp.first_name,
      "last_name": resp.last_name,
        "city": resp.city,
      "account_created": resp.account_created,
    }
    return (jsonify(resp), 201)

@api_bp.route('/users', methods=['PUT'])
@token_required
def api_update_user():
    """
    Update user details (requires authentication)
    ---
    security:
      - Bearer: []
      - Cookie: []
    parameters:
      - name: body
        in: body
        required: true
        schema:
          type: object
          properties:
            first_name:
              type: string
              description: (Optional) First name
            last_name:
              type: string
              description: (Optional) Last name
            email:
              type: string
              format: email
              description: (Optional) Email address
            city:
              type: string
              description: (Optional) City
    responses:
      200:
        description: User updated successfully
        schema:
          type: object
          properties:
            id:
              type: integer
            first_name:
              type: string
            last_name:
              type: string
            email:
              type: string
            city:
              type: string
            account_created:
              type: string
      400:
        description: Invalid format, invalid email format, or no valid fields to update
      401:
        description: Authentication token missing or invalid
    """
    # Implement the logic to update user details
    data = request.get_json(silent=True)
    if not data:
        return jsonify({"error": "Not valid format"}), 400
    user_id = g.user_id
    first_name = data.get('first_name')
    last_name = data.get('last_name')
    city = data.get('city')
    email = data.get('email')
    if email and not check_email_format(email):
        return jsonify({"error": "Invalid email format"}), 400
    update_data = {}
    if email:
        update_data['email'] = email
    if first_name:
        update_data['first_name'] = first_name
    if last_name:
        update_data['last_name'] = last_name
    if city:
        update_data['city'] = city
    if not update_data:
        return jsonify({"error": "No valid fields to update"}), 400

    resp = users.update_user(user_id, update_data)
    if resp is None:
        return jsonify({"error": "Error updating user"}), 400
    resp = {
      "id": resp.id,
      "first_name": resp.first_name,
      "last_name": resp.last_name,
      "email": resp.email,
      "city": resp.city,
      "account_created": resp.account_created,
    }
    return (jsonify(resp), 200)


@api_bp.route('/users', methods=['GET'])
@token_required
def api_get_all_users():
    """
    Get all users (requires authentication)
    ---
    security:
      - Bearer: []
      - Cookie: []
    responses:
      200:
        description: List of all users
        schema:
          type: array
          items:
            type: object
            properties:
              id:
                type: integer
              first_name:
                type: string
              last_name:
                type: string
              email:
                type: string
              city:
                type: string
              account_created:
                type: string
      401:
        description: Authentication token missing or invalid
    """
    # Implement the logic to get all users
    resp = users.get_all_users()
    return (jsonify(resp), 200)

@api_bp.route('/users/<int:user_id>', methods=['GET'])
@token_required
def api_get_user(user_id):
    """
    Get user details by ID
    ---
    security:
      - Bearer: []
      - Cookie: []
    parameters:
      - name: user_id
        in: path
        type: integer
        required: true
        description: The user ID
    responses:
      200:
        description: User details
        schema:
          type: object
          properties:
            id:
              type: integer
            first_name:
              type: string
            last_name:
              type: string
            city:
              type: string
            account_created:
              type: string
      401:
        description: Authentication token missing or invalid
      404:
        description: User not found
    """
    # Implement the logic to get user details
    resp = users.get_user_by_id(user_id)
    if resp:
        resp = {
        "id": resp.id,
        "first_name": resp.first_name,
        "last_name": resp.last_name,
        "city": resp.city,
        "account_created": resp.account_created,
        }
        return (jsonify(resp), 200)
    return ("", 404)

@api_bp.route('/login', methods=['POST'])
def api_login():
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


