#!/bin/sh

while [ ! "$(lsof -i :3306)" ]; do
    sleep 1
done
echo 'MariaDB started.'

SQL_COMMANDS="
CREATE DATABASE $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost';
FLUSH PRIVILEGES;
"
echo "$SQL_COMMANDS" | mysql

/ctfd/env/bin/flask db upgrade

/ctfd/env/bin/python /ctfd/manage.py import_ctf "$CTFD_CONFIG"

exec /ctfd/env/bin/gunicorn wsgi:app --bind "0.0.0.0:$CTFD_PORT" --chdir /ctfd --workers 4
