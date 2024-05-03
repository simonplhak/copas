FROM copas.ctfd:latest

COPY config.yml /app/config.yml
COPY events.py /app/app/master/events.py

WORKDIR /workdir

ENV ROLE=master

