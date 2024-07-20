import os
from config.small_app_logger import logger
from flask import Flask
from src import auth, blog, db


def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)

    if test_config is None:
        app.config.from_object("config.settings")
        logger.debug(f'Server Name: {app.config["SERVER_NAME"]}')
    else:
        app.config.from_object('config.flask_testing', silent=True)

    try:
        os.makedirs(app.instance_path)
    except OSError as err:
        logger.debug(err)

    @app.route("/hello")
    def hello():
        return "Hello I am a small app!"

    @app.route("/pagetwo")
    def page_two():
        return "Hello from pagetwo of this small app!"

    @app.errorhandler(500)
    def server_error(e):
        logging.exception("An error occurred during a request.")
        return "An internal error occurred.", 500

    db.init_app(app)
    app.register_blueprint(auth.bp)
    app.register_blueprint(blog.bp)
    app.add_url_rule('/', endpoint='index')

    return app
