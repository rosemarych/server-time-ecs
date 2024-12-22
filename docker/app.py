from flask import Flask
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def get_server_time():
    return {"server_time": datetime.utcnow().isoformat()}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
