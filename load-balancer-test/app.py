from flask import Flask, render_template, request

app = Flask(__name__)

users = {
    'Mohamed': '1234'
}

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/login', methods=['GET'])
def login():
    username = request.args.get('username')
    password = request.args.get('password')
    if username in users and password == users[username]:
        return f'Welcome, {username}!'
    else:
        return render_template('index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, port=5000)
