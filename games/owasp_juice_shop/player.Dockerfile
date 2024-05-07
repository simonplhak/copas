FROM bkimminich/juice-shop:v16.0.1 as juice-shop

FROM copas:latest

RUN curl -s https://deb.nodesource.com/setup_20.x | /bin/sh && apt install -y nodejs

RUN adduser --disabled-password --gecos '' --uid 65532 juice-shop

COPY --from=juice-shop /juice-shop /juice-shop

COPY supervisord.conf /etc/supervisord.conf.extension

RUN cat /etc/supervisord.conf.extension >> /etc/supervisord.conf

ENV NODE_ENV=ctf
