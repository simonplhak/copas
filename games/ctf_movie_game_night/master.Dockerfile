FROM copas.ctfd:latest
COPY config.yml /app/config.yml


COPY config.yml /app/config.yml
COPY ctfd_backup.zip /ctfd/ctfd_backup.zip
COPY events.py /app/app/master/events.py

WORKDIR /workdir

ENV CTFD_CONFIG=/ctfd/ctfd_backup.zip
ENV CTFD_ADMIN_TOKEN=ctfd_9cc6c4906617986493209fcb6cbe3b82f247a6776b4dda3f114d11dc7aba7c81
ENV ROLE=master

