from flask import Flask, jsonify, request, render_template, redirect, session, url_for 
from flask_cors import CORS
from functools import wraps
from db import *

app = Flask(__name__)
users = Users()
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

if __name__ == '__main__':
    app.run(debug=True)