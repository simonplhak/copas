FROM copas.ctfd:latest

WORKDIR /app

COPY config.yml /app/config.yml

ENV ROLE=master

EXPOSE 3000
