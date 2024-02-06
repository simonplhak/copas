FROM copas:latest
WORKDIR /
RUN apk update
RUN apk add busybox-extras
RUN adduser -D -s /bin/ash telnetuser && \
    echo "telnetuser:password" | chpasswd
COPY flax.txt /home/telnetuser/
EXPOSE 23
CMD ["telnetd", "-F"]
