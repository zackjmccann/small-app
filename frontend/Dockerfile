FROM python:3.12.4-bookworm

ARG UID=1000
ARG GID=1000
ENV HOME=/app
ENV VIRTUAL_ENV=${HOME}/.venv/env
ENV PORT=8000

WORKDIR ${HOME}

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential curl libpq-dev \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && groupadd -g "${GID}" app \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" small \
  && chown small:app -R ${HOME}

USER small

COPY --chown=small:app requirements*.txt ./
COPY --chown=small:app bin/ ./bin
COPY --chown=small:app . .

RUN chmod 0755 bin/* && bin/install

ARG FLASK_DEBUG="false"
ENV FLASK_DEBUG="${FLASK_DEBUG}" \
    FLASK_APP="src.app" \
    FLASK_SKIP_DOTENV="true" \
    PYTHONUNBUFFERED="true" \
    PYTHONPATH="." \
    PATH=${HOME}/.local/bin:${PATH} \
    USER="small"

EXPOSE ${PORT}

ENTRYPOINT [ "bin/small_app_entrypoint" ]

CMD [ "gunicorn", "-c", "./config/gunicorn.py", "src.app:create_app()" ]