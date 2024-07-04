FROM python:3.10-alpine AS builder

RUN apk update && apk add git

WORKDIR /app

COPY requirements.txt /app
RUN pip3 install update && pip3 install -r requirements.txt

COPY . /app

ENTRYPOINT ["python3"]
CMD ["app.py"]
