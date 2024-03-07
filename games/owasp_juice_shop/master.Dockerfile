FROM copas.ctfd:latest

RUN curl -s https://deb.nodesource.com/setup_18.x | /bin/sh && apt install -y nodejs

WORKDIR /juice-shop
RUN git clone https://github.com/juice-shop/juice-shop.git --depth 1 /juice-shop
RUN npm i

WORKDIR /app

COPY config.yml /app/config.yml
COPY ctfd_backup.zip /ctfd/ctfd_backup.zip
COPY supervisord.conf /etc/supervisord.conf.extension
RUN cat /etc/supervisord.conf.extension >> /etc/supervisord.conf

# todo CTFD_CONFIG should be automatic
ENV CTFD_CONFIG=/ctfd/ctfd_backup.zip
ENV CTFD_ADMIN_TOKEN=ctfd_36a898496644fba42c3c29234662b454e09d48ddeeb8d279f7b279488fbc5d71
ENV NODE_ENV=ctf
ENV CTF_KEY=super-key
ENV ROLE=master

EXPOSE 3000
