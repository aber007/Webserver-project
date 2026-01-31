from datetime import datetime, timedelta
from flask import Flask, jsonify, request, render_template, redirect, session, url_for 
from flask_cors import CORS
from functools import wraps

import jwt
from db import *

app = Flask(__name__)
users = Users()
auctions = Auctions()
app.secret_key = 'supersecretkey'

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        user_id = session.get('current_user')
        if not user_id:
            return redirect(url_for('login'), 403)
        user = users.get_user_by_id(user_id)
        if not user:
            session.pop('current_user', None)
            return redirect(url_for('login'), 403)
        session['user_obj'] = user
        return f(*args, **kwargs)
    return decorated_function

@app.route('/')
def home():
    return render_template('index.html', user=session.get('current_user'))


@app.route('/auctions')
def search():
    # Display auctions
    category = request.args.get('category', "")
    return render_template('auctions.html', user=session.get('current_user'), category=category)

@app.route('/auctions/<int:auction_id>')
def auction_detail(auction_id):
    # Implement the logic to display auction details
    return render_template('auction_detail.html', auction_id=auction_id, user=session.get('current_user'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if session.get('user_id') and session.get('user_id') in users.get_all_user_ids():
        return redirect(url_for('home'))
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')

        user_obj = users.get_user_by_email(email)
        if not user_obj or not bcrypt.checkpw(password.encode(), user_obj.password.encode()):
            return "Invalid credentials", 401

        session['user_id'] = user_obj.id
        session['current_user'] = user_obj

        return redirect(url_for('home'))
    return render_template('login.html')

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        print("Signup form submitted")
        first_name = request.form.get('firstname')
        last_name = request.form.get('lastname')
        city = request.form.get('location')
        email = request.form.get('email')
        password = request.form.get('password')
        
        resp = users.create_user(last_name, first_name, city, email, password)

        session['user_id'] = resp.id
        session['current_user'] = resp

        if resp:
            return redirect(url_for('login'))
        else:
            return "Error creating user", 400

    return render_template('signup.html')




def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = request.cookies.get('jwt_token')

        if not token:
            return jsonify({'message': 'Token is missing!'}), 401

        try:
            data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=["HS256"])
            current_user = User.query.filter_by(public_id=data['public_id']).first()
        except:
            return jsonify({'message': 'Token is invalid!'}), 401

        return f(current_user, *args, **kwargs)

    return decorated

@app.route('/api/auctions/search', methods=['GET'])
def api_search():
    category = request.args.get('category', "")
    if category:
        auctions_items = auctions.get_auctions_by_category(category)
    else:
        auctions_items = auctions.get_all_auctions()

    # Check if auctions_items contain expired auctions and set published to False and exclude them
    return jsonify(auctions_items)

@app.route('/api/auctions/search/<int:auction_id>', methods=['GET'])
def api_auction_detail(auction_id):
    auction = auctions.get_auction_by_id(auction_id)
    if not auction:
        return jsonify({"error": "Auction not found"}), 404
    return jsonify(auction)

@app.route('/api/auctions/remove_published', methods=['PUT'])
def remove_published_auctions():
    # Implement the logic to remove published auctions
    return ("", 501)

@app.route('/api/auctions/create', methods=['POST'])
def api_create_auction():
    # Implement the logic to create a new auction
    return ("", 501)

@app.route('/api/auctions/update/<int:auction_id>', methods=['PUT'])
def api_update_auction(auction_id):
    # Implement the logic to update an auction
    return ("", 501)

@app.route('/api/users', methods=['POST'])
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
    
    resp = users.create_user(last_name, first_name, city, email, password)
    if resp is None:
        return jsonify({"error": "Error creating user"}), 400
    resp = {
        "id": resp.id,
        "firstName": resp.firstName,
        "lastName": resp.lastName,
        "city": resp.city,
        "email": resp.email
    }
    return (jsonify(resp), 201)

@app.route('/api/users', methods=['GET'])
def api_get_all_users():
    # Implement the logic to get all users
    resp = users.get_all_users()
    return (jsonify(resp), 200)

@app.route('/api/users/<int:user_id>', methods=['GET'])
def api_get_user(user_id):
    # Implement the logic to get user details
    resp = users.get_user_by_id(user_id)
    if resp:
        resp = {
            "id": resp.id,
            "firstName": resp.firstName,
            "lastName": resp.lastName,
            "city": resp.city,
            "email": resp.email
        }
        return (jsonify(resp), 200)
    return ("", 404)

@app.route('/api/login', methods=['POST'])
def api_login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return ("", 400)

    user_obj = users.get_user_by_email(email)
    if not user_obj or not bcrypt.checkpw(password.encode(), user_obj.password.encode()):
        return ("", 401)
    
    token = jwt.encode({'user_id': user_obj.id, 'exp': datetime.now() + timedelta(hours=1)}, app.secret_key, algorithm="HS256")

    return (jsonify({"token": token}), 200)

if __name__ == '__main__':
    app.run(debug=True)