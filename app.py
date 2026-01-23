from flask import Flask, jsonify, request, render_template, redirect, session, url_for 
from functools import wraps
from db import *

app = Flask(__name__)
users = Users()

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
    return render_template('index.html')

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        first_name = request.form.get('firstname')
        last_name = request.form.get('lastname')
        city = request.form.get('location')
        email = request.form.get('email')
        password = request.form.get('password')


    return render_template('signup.html')

if __name__ == '__main__':
    app.run(debug=True)