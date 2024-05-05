FROM copas:latest

COPY config.yml /app/config.yml
COPY supervisord.conf /etc/supervisord.conf.extension
RUN cat /etc/supervisord.conf.extension >> /etc/supervisord.conf && rm /etc/supervisord.conf.extension

COPY level_one.py /workdir/level_one.py
COPY level_two.py /workdir/level_two.py

RUN adduser --disabled-password --gecos '' --uid 65532 steve
RUN chown -R steve:steve /workdir

WORKDIR /workdir

ENV ROLE=master
