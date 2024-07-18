import logging
from flask import Flask


app = Flask(__name__)
app.config.from_object("config.settings")


@app.route("/")
def hello():
    return "Hello I am a small app!"

@app.route("/pagetwo")
def page_two():
    return "Hello from pagetwo of this small app!"


@app.errorhandler(500)
def server_error(e):
    logging.exception("An error occurred during a request.")
    return "An internal error occurred.", 500
