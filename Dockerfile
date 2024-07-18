FROM python:3.12.4-bookworm

ARG UID=1000
ARG GID=1000
ENV HOME=/app
ENV VIRTUAL_ENV=${HOME}/.venv/env
ENV PORT=8000

WORKDIR ${HOME}

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential curl libpq-dev nginx \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && groupadd -g "${GID}" python \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" python \
  && chown python:python -R ${HOME}
  
USER python

COPY --chown=python:python requirements*.txt ./
COPY --chown=python:python bin/ ./bin
COPY --chown=python:python . .

RUN chmod 0755 bin/* && bin/install

ARG FLASK_DEBUG="false"
ENV FLASK_DEBUG="${FLASK_DEBUG}" \
    FLASK_APP="src.app" \
    FLASK_SKIP_DOTENV="true" \
    PYTHONUNBUFFERED="true" \
    PYTHONPATH="." \
    PATH=${HOME}/.local/bin:${PATH} \
    USER="python"

EXPOSE ${PORT}

CMD ["gunicorn", "-c", "python:config.gunicorn", "src.wsgi:app"]
