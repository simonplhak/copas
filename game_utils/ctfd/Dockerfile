FROM ubuntu:22.04 as ctfd_build
WORKDIR /ctfd

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get install -y python3.10 python3-pip git python3.10-venv

RUN git clone https://github.com/CTFd/CTFd.git /ctfd
RUN python3.10 -m venv env
RUN . env/bin/activate && pip install -r requirements.txt && deactivate
# fix: add comment to empty js files, otherwise gunicorn will scream
RUN find /ctfd/CTFd/themes -type f -empty -name "*.js" -exec bash -c 'echo "// fix" >> "$0"' {} \;

FROM copas:latest

COPY --from=ctfd_build /ctfd /ctfd
COPY supervisord.conf /etc/supervisord.conf.extension
RUN cat /etc/supervisord.conf.extension >> /etc/supervisord.conf
COPY ctfd.entrypoint.sh /ctfd/ctfd.entrypoint.sh

ENV CTFD=true
ENV CTFD_HOST="http://localhost:8002"
ENV ROLE=master
