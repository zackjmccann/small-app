FROM python:3.12.4-bookworm

RUN apt-get update && apt-get install -y git nginx

COPY requirements.txt /requirements.txt
RUN pip3 install update && pip3 install -r requirements.txt

ADD src /src

EXPOSE 5000

ENTRYPOINT ["gunicorn"]
CMD ["--chdir", "/src", "--bind", "0.0.0.0:5000", "wsgi:app"]
