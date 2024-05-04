FROM bkimminich/juice-shop as juice-shop

FROM copas.ctfd:latest

RUN curl -s https://deb.nodesource.com/setup_20.x | /bin/sh && apt install -y nodejs

RUN adduser --disabled-password --gecos '' --uid 65532 juice-shop
COPY --from=juice-shop /juice-shop /juice-shop

WORKDIR /app

COPY config.yml /app/config.yml
COPY supervisord.conf /etc/supervisord.conf.extension
RUN cat /etc/supervisord.conf.extension >> /etc/supervisord.conf

ENV NODE_ENV=ctf
ENV ROLE=master

EXPOSE 3000
