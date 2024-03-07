FROM copas:latest
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y mariadb-server mariadb-client

RUN mkdir -p /run/mysqld

WORKDIR /ctfd

RUN git clone https://github.com/CTFd/CTFd.git /ctfd
RUN python3 -m venv env
RUN . env/bin/activate && pip install -r requirements.txt && deactivate

COPY supervisord.conf /etc/supervisord.conf.extension
RUN cat /etc/supervisord.conf.extension >> /etc/supervisord.conf
COPY ctfd.entrypoint.sh /ctfd/ctfd.entrypoint.sh

ENV MYSQL_USER=ctfd
ENV MYSQL_PASSWORD=ctfd
ENV MYSQL_DATABASE=ctfd
ENV DATABASE_URL="mysql+pymysql://ctfd:ctfd@localhost:3306/ctfd"
ENV CTFD=true


# fix: add comment to empty js files, otherwise gunicorn will scream
RUN find /ctfd/CTFd/themes -type f -empty -name "*.js" -exec bash -c 'echo "// fix" >> "$0"' {} \;

WORKDIR /app
