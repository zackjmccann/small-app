import os
from distutils.util import strtobool


DEBUG = bool(strtobool(os.getenv('FLASK_DEBUG', 'false')))

SECRET_KEY = os.getenv('SECRET_KEY')

DATABASE=os.path.join('app.sqlite')

SERVER_NAME = os.getenv('SERVER_NAME', f'localhost:{os.getenv("PORT", "8000")}')
