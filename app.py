from datetime import datetime, timedelta
from flask import Flask, jsonify, request, render_template, redirect, session, url_for, make_response
from flask_cors import CORS
from functools import wraps
import requests
import jwt
import bcrypt

import db
from db import Users, Auctions
from api_routes import api_bp

app = Flask(__name__)
app.secret_key = 'supersecretkey'

# Register API blueprint
app.register_blueprint(api_bp)

users = Users()
auctions = Auctions()

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        token = request.cookies.get('jwt_token')
        
        if not token:
            session.clear()
            return redirect(url_for('login'))
        
        try:
            # Decode and validate token (automatically checks expiration)
            data = jwt.decode(token, app.secret_key, algorithms=["HS256"])
            user_id = data['user_id']
            
            # Verify user still exists
            user = users.get_user_by_id(user_id)
            if not user:
                session.clear()
                response = make_response(redirect(url_for('login')))
                response.set_cookie('jwt_token', '', expires=0)
                return response
            
            session['current_user'] = {
                'id': user.id,
                'firstName': user.firstName,
                'lastName': user.lastName,
                'email': user.email
            }
            
        except jwt.ExpiredSignatureError:
            # Token expired - auto logout
            session.clear()
            response = make_response(redirect(url_for('login')))
            response.set_cookie('jwt_token', '', expires=0)
            return response
        except jwt.InvalidTokenError:
            # Invalid token
            session.clear()
            return redirect(url_for('login'))
        
        return f(*args, **kwargs)
    return decorated_function

@app.route('/')
def home():
    return render_template('index.html', user=session.get('current_user'))


@app.route('/auctions')
@login_required
def search():
    # Display auctions
    category = request.args.get('category', "")
    return render_template('auctions.html', user=session.get('current_user'), category=category)

@app.route('/auctions/<int:auction_id>')
@login_required
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

        # Directly authenticate instead of calling your own API
        user_obj = users.get_user_by_email(email)
        if not user_obj or not bcrypt.checkpw(password.encode(), user_obj.password.encode()):
            return render_template('login.html', error="Invalid credentials")
        
        # Create JWT token with expiration (e.g., 1 hour)
        token = jwt.encode({
            'user_id': user_obj.id, 
            'exp': datetime.now() + timedelta(hours=1)  # Auto logout after 1 hour
        }, app.secret_key, algorithm="HS256")

        # Store token in secure HTTP-only cookie
        response = make_response(redirect(url_for('home')))
        response.set_cookie('jwt_token', token, httponly=True, max_age=3600)  # 1 hour
        
        # Also store in session as backup
        session['user_id'] = user_obj.id
        session['current_user'] = {
            'id': user_obj.id,
            'firstName': user_obj.firstName,
            'lastName': user_obj.lastName,
            'email': user_obj.email
        }
        
        return response
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
        session['current_user'] = {
            'id': resp.id,
            'firstName': resp.firstName,
            'lastName': resp.lastName,
            'email': resp.email
        }

        if resp:
            return redirect(url_for('login'))
        else:
            return "Error creating user", 400

    return render_template('signup.html')



if __name__ == '__main__':
    app.run(debug=True)