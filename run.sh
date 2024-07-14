#!/usr/bin/env bash

source ${VIRTUAL_ENV}/bin/activate
gunicorn --chdir ${HOME}/src --bind 0.0.0.0:${PORT} wsgi:app
