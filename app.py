from flask import Flask, jsonify, request, render_template, redirect, session, url_for 
from flask_cors import CORS
from functools import wraps
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


@app.route('/search')
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

        user_obj = users.get_user_by_email(email)
        session['user_id'] = user_obj.id
        session['current_user'] = user_obj

        if resp:
            return redirect(url_for('login'))
        else:
            return "Error creating user", 400

    return render_template('signup.html')


@app.route('/api/search', methods=['GET'])
def api_search():
    category = request.args.get('category', "")
    if category:
        auctions_items = auctions.get_auctions_by_category(category)
    else:
        auctions_items = auctions.get_all_auctions()

    # Check if auctions_items contain expired auctions and set published to False and exclude them
    return jsonify(auctions_items)

if __name__ == '__main__':
    app.run(debug=True)