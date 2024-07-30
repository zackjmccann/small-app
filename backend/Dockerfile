FROM postgres:16.3

ENV HOME=/db
ENV PORT=5432

WORKDIR ${HOME}

RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
    && apt-get clean
    
COPY bin/init.sql /docker-entrypoint-initdb.d/init.sql

EXPOSE ${PORT}

CMD [ "postgres" ]
