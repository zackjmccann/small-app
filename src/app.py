import logging
from flask import Flask


app = Flask(__name__)


@app.route("/")
def hello():
    return "Hello I am a small app!"


@app.errorhandler(500)
def server_error(e):
    logging.exception("An error occurred during a request.")
    return "An internal error occurred.", 500

if __name__ == '__main__':
	app.run(host='0.0.0.0', port=8080)
