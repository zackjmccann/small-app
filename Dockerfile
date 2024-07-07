FROM python:3.10-alpine

RUN apk update && apk add git

COPY requirements.txt /requirements.txt
RUN pip3 install update && pip3 install -r requirements.txt

ADD src /src

ENTRYPOINT ["python3"]
CMD ["src/app.py"]
