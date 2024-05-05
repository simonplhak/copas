FROM copas:latest
COPY config.yml /app/config.yml

WORKDIR /workdir
COPY supervisord.conf /etc/supervisord.conf.extension
RUN cat /etc/supervisord.conf.extension >> /etc/supervisord.conf && rm /etc/supervisord.conf.extension


COPY movie_web.py /workdir/movie_web.py
COPY movies.csv /workdir/movies.csv
COPY game_web.py /workdir/game.py
COPY games.csv /workdir/games.csv
RUN adduser --disabled-password --gecos '' --uid 65532 steve
RUN chown -R steve:steve /workdir

EXPOSE 8080
